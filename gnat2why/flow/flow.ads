------------------------------------------------------------------------------
--                                                                          --
--                            GNAT2WHY COMPONENTS                           --
--                                                                          --
--                                 F L O W                                  --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--                  Copyright (C) 2013, Altran UK Limited                   --
--                                                                          --
-- gnat2why is  free  software;  you can redistribute  it and/or  modify it --
-- under terms of the  GNU General Public License as published  by the Free --
-- Software  Foundation;  either version 3,  or (at your option)  any later --
-- version.  gnat2why is distributed  in the hope that  it will be  useful, --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of  MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License for  more details.  You should have  received  a copy of the GNU --
-- General  Public License  distributed with  gnat2why;  see file COPYING3. --
-- If not,  go to  http://www.gnu.org/licenses  for a complete  copy of the --
-- license.                                                                 --
--                                                                          --
------------------------------------------------------------------------------

with Ada.Containers;
with Ada.Containers.Hashed_Maps;
with Ada.Containers.Hashed_Sets;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Atree; use Atree;
with Einfo; use Einfo;
with Types; use Types;

with Gnat2Why.Nodes;         use Gnat2Why.Nodes;
--  Node_Sets and Node_Hash

with SPARK_Frame_Conditions; use SPARK_Frame_Conditions;
--  Entity_Name

with Graph;
with Flow_Types;           use Flow_Types;
with Flow_Tree_Utility;    use Flow_Tree_Utility;
with Flow_Dependency_Maps; use Flow_Dependency_Maps;

package Flow is

   ----------------------------------------------------------------------
   --  Global variables
   ----------------------------------------------------------------------

   JSON_Msgs_List   : Unbounded_String_Lists.List;
   --  This will holds all of the emitted flow messages in JSON format

   Found_Flow_Error : Boolean := False;
   --  This boolean becomes True if we find a flow error or if we find a
   --  flow warning while Warning_Mode = Treat_As_Error.

   ----------------------------------------------------------------------
   --  Flow_Graphs
   ----------------------------------------------------------------------

   package Flow_Graphs is new Graph
     (Vertex_Key        => Flow_Id,
      Vertex_Attributes => V_Attributes,
      Edge_Colours      => Edge_Colours,
      Null_Key          => Null_Flow_Id,
      Test_Key          => "=");

   ----------------------------------------------------------------------
   --  Utility packages
   ----------------------------------------------------------------------

   package Node_To_Vertex_Maps is new Ada.Containers.Hashed_Maps
     (Key_Type        => Node_Id,
      Element_Type    => Flow_Graphs.Vertex_Id,
      Hash            => Node_Hash,
      Equivalent_Keys => "=",
      "="             => Flow_Graphs."=");

   package Vertex_Sets is new Ada.Containers.Hashed_Sets
     (Element_Type        => Flow_Graphs.Vertex_Id,
      Hash                => Flow_Graphs.Vertex_Hash,
      Equivalent_Elements => Flow_Graphs."=",
      "="                 => Flow_Graphs."=");

   package Vertex_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Flow_Graphs.Vertex_Id,
      "="          => Flow_Graphs."=");

   package Magic_String_To_Node_Sets is new Ada.Containers.Hashed_Maps
     (Key_Type        => Entity_Name,
      Element_Type    => Node_Sets.Set,
      Hash            => Name_Hash,
      Equivalent_Keys => Name_Equal,
      "="             => Node_Sets."=");

   ----------------------------------------------------------------------
   --  Flow_Analysis_Graphs
   ----------------------------------------------------------------------

   subtype Valid_Analyzed_Entity is Entity_Kind
     with Static_Predicate =>
       Valid_Analyzed_Entity in E_Subprogram_Body |
                                E_Package |
                                E_Package_Body;

   type Flow_Analysis_Graphs_Root (Kind : Valid_Analyzed_Entity :=
                                     E_Subprogram_Body)
   is record
      Analyzed_Entity   : Entity_Id;
      Scope             : Scope_Ptr;
      --  The entity and scope of the analysed entity.

      Spec_Node         : Entity_Id;
      --  Useful shorthand to the node where the n_contract node is
      --  attached.

      Start_Vertex      : Flow_Graphs.Vertex_Id;
      End_Vertex        : Flow_Graphs.Vertex_Id;
      --  The start and end vertices in the graphs.

      CFG               : Flow_Graphs.T;
      DDG               : Flow_Graphs.T;
      CDG               : Flow_Graphs.T;
      TDG               : Flow_Graphs.T;
      PDG               : Flow_Graphs.T;
      --  The graphs.

      All_Vars          : Flow_Id_Sets.Set;
      --  A set of all variables used.

      Unmodified_Vars   : Node_Sets.Set;
      --  A set of all variables that are not expected to be modified
      --  because the were named in a pragma Unmodified.

      Unreferenced_Vars : Node_Sets.Set;
      --  A set of all variables that are not expected to be referenced
      --  because the were named in a pragma Unreferenced.

      Loops             : Node_Sets.Set;
      --  A set of all loops (identified by label).

      Magic_Source      : Magic_String_To_Node_Sets.Map;
      --  A mapping of any magic string to entities of the
      --  subprogram(s) they originate from. We need this to print
      --  more helpful error messages.

      Base_Filename     : Unbounded_String;
      --  A string with the name of the entity that is being analysed.
      --  This string follows the convention that we use for naming the
      --  .dot and .pdf files.

      Aliasing_Present  : Boolean;
      --  True if this subprogram introduces (bad)
      --  aliasing. Subsequent analysis is then meaningless.

      case Kind is
         when E_Subprogram_Body =>
            Is_Main : Boolean;
            --  True if this is the main program. In order to be the
            --  main it has to be a library level subprogram without
            --  formal parameters (global parameters are allowed).

            Is_Generative : Boolean;
            --  True if we do not have a global contract.

            Last_Statement_Is_Raise : Boolean;
            --  True if the last statement of the subprogram is an
            --  N_Raise_Statement.

            Depends_N         : Node_Id;
            Refined_Depends_N : Node_Id;
            --  A few contract nodes cached as they can be a bit
            --  tedious to find.

            Function_Side_Effects_Present : Boolean;
            --  Set to true if we are dealing with a function that has side
            --  effects.

         when E_Package =>
            null;

         when E_Package_Body =>
            null;
      end case;
   end record;

   function Is_Valid (X : Flow_Analysis_Graphs_Root) return Boolean;

   subtype Flow_Analysis_Graphs is Flow_Analysis_Graphs_Root;
   --  with Dynamic_Predicate => Is_Valid (Flow_Analysis_Graphs);

   package Analysis_Maps is new Ada.Containers.Hashed_Maps
     (Key_Type        => Entity_Id,
      Element_Type    => Flow_Analysis_Graphs,
      Hash            => Node_Hash,
      Equivalent_Keys => "=",
      "="             => "=");

   ----------------------------------------------------------------------
   --  Utilities
   ----------------------------------------------------------------------

   function Loop_Parameter_From_Loop (E : Entity_Id) return Entity_Id
     with Pre  => Ekind (E) = E_Loop,
          Post => not Present (Loop_Parameter_From_Loop'Result) or else
                  Ekind (Loop_Parameter_From_Loop'Result) = E_Loop_Parameter;
   --  Given a loop label, returns the identifier of the loop
   --  parameter or Empty.

   procedure Get_Globals (Subprogram             : Entity_Id;
                          Reads                  : out Flow_Id_Sets.Set;
                          Writes                 : out Flow_Id_Sets.Set;
                          Refined_View           : Boolean;
                          Consider_Discriminants : Boolean := False)
   with Pre  => Ekind (Subprogram) in E_Procedure | E_Function,
        Post => (for all G of Reads  => G.Variant = In_View) and
                (for all G of Writes => G.Variant = Out_View);
   --  Given a subprogram call, work out globals from the provided
   --  aspect or the computed globals. The sets returned will contain
   --  Flow_Id with the variant set to Global_In_View and
   --  Global_Out_View.
   --
   --  If refined_view is false, then the global are returned. If
   --  true, the refined globals are returned instead.
   --
   --  If Consider_Discriminants is provided then an out global will
   --  include a corresponding read if the global includes at least
   --  one discriminant.

   function Has_Depends (Subprogram : Entity_Id) return Boolean
   with Pre => Ekind (Subprogram) in E_Procedure | E_Function;
   --  Return true if the given subprogram has been annotated with a
   --  dependency relation.

   function Has_Refined_Depends (Subprogram : Entity_Id) return Boolean
   with Pre => Ekind (Subprogram) in E_Procedure | E_Function;
   --  Return true if the given subprogram has been annotated with a
   --  refined dependency relation.

   procedure Get_Depends (Subprogram : Entity_Id;
                          Refined    : Boolean;
                          Depends    : out Dependency_Maps.Map)
   with Pre  => Ekind (Subprogram) in E_Procedure | E_Function and
                Has_Depends (Subprogram),
        Post => (for all C in Depends.Iterate =>
                   (for all D of Dependency_Maps.Element (C) =>
                      Present (D)));
   --  Return the dependency relation of the given subprogram. The
   --  dependency relation is represented as a map from entities to
   --  sets of entities.
   --
   --  For example (X, Y) =>+ Z would be represented as:
   --     x -> {x, z}
   --     y -> {y, z}
   --
   --  This procedure can deal with all forms the depends
   --  annotation. For each item in the dependency annotation, the LHS
   --  and RHS can be any of the following:
   --     * (x, y, z)     (an aggregate)
   --     * x             (a variable)
   --     * null          (keyword null)
   --  One final form which is supported is the null dependency.
   --
   --  The + shorthand to mean "itself" is expanded away by the
   --  front-end and this procedure does not have to deal with it.

   ----------------------------------------------------------------------
   --  Debug
   ----------------------------------------------------------------------

   procedure Print_Graph
     (Filename     : String;
      G            : Flow_Graphs.T;
      Start_Vertex : Flow_Graphs.Vertex_Id := Flow_Graphs.Null_Vertex;
      End_Vertex   : Flow_Graphs.Vertex_Id := Flow_Graphs.Null_Vertex);
   --  Write a dot and pdf file for the given graph.

   ----------------------------------------------------------------------
   --  Main entry to flo analysis
   ----------------------------------------------------------------------

   procedure Flow_Analyse_CUnit (GNAT_Root       : Node_Id;
                                 Has_Flow_Errors : out Boolean);
   --  Flow analyses the current compilation unit. Sets Has_Flow_Errors to
   --  True if either a flow error was found, or if a flow warning was found
   --  and warnings are treated as errors.

end Flow;
