------------------------------------------------------------------------------
--                                                                          --
--                            GNAT2WHY COMPONENTS                           --
--                                                                          --
--                        W H Y - G E N - N A M E S                         --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--                       Copyright (C) 2010-2015, AdaCore                   --
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
-- gnat2why is maintained by AdaCore (http://www.adacore.com)               --
--                                                                          --
------------------------------------------------------------------------------

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Gnat2Why.Util;         use Gnat2Why.Util;
with Namet;                 use Namet;
with Snames;                use Snames;
with Types;                 use Types;
with Why.Ids;               use Why.Ids;
with Why.Sinfo;             use Why.Sinfo;
with Why.Types;

package Why.Gen.Names is
   --  This package provides ways to manipulate subprogram names and
   --  to create identifiers from their string representation

   New_Temp_Identifier_Suffix : Unbounded_String;
   --  Suffix for all temporary names, so that the final name is
   --    _temp_<suffix>_<num>
   --  where <num> is a counter increased by one at each new temporary.

   function NID (Name : String) return Name_Id;
   --  Return Name_Id for Name

   function Conversion_Name
      (From : W_Type_Id;
       To   : W_Type_Id) return W_Identifier_Id;
   --  Return the name of the conversion function between the two types

   function Range_Pred_Name
     (Ty : Entity_Id) return W_Identifier_Id;
   --  Return the name of the "in_range" predicate for the type

   function Dynamic_Prop_Name
     (Ty : Entity_Id) return W_Identifier_Id;
   --  Return the name of the "dynamic_property" predicate for the type

   function Range_Check_Name
     (Ty : Entity_Id; R : Range_Check_Kind) return W_Identifier_Id;
   --  Return the name of the "range_check_" program function for the type

   function New_Division (Kind : W_Type_Id) return W_Identifier_Id;
   --  Return the name of the division for the given kind

   function New_Exp (Kind : W_Type_Id) return W_Identifier_Id;
   --  Return the name of the exponential for the given kind

   function New_Abs (Kind : W_Type_Id) return W_Identifier_Id;
   --  Return the name of the absolute value operator for the given kind

   function New_Identifier (Ada_Node : Node_Id := Empty;
                            Name     : String;
                            Typ      : W_Type_Id := Why.Types.Why_Empty)
       return W_Identifier_Id;
   --  Create a new term identifier for Name and return the result

   function New_Identifier
     (Ada_Node  : Node_Id := Empty;
      Name      : String;
      Namespace : Name_Id := No_Name;
      Module    : W_Module_Id;
      Typ       : W_Type_Id := Why.Types.Why_Empty) return W_Identifier_Id;

   function New_Identifier
     (Ada_Node : Node_Id := Empty;
      Domain   : EW_Domain;
      Name     : String;
      Typ      : W_Type_Id := Why.Types.Why_Empty)
      return W_Identifier_Id;

   function New_Identifier
     (Ada_Node  : Node_Id := Empty;
      Domain    : EW_Domain;
      Name      : String;
      Namespace : Name_Id := No_Name;
      Module    : W_Module_Id;
      Typ       : W_Type_Id := Why.Types.Why_Empty)
      return W_Identifier_Id;

   function New_Identifier (Name : W_Name_Id) return W_Identifier_Id;

   function New_Temp_Identifier
     (Ada_Node : Node_Id := Empty;
      Typ      : W_Type_Id := Why.Types.Why_Empty)
      return W_Identifier_Id;

   function New_Temp_Identifier return String;
   --  Return a new unique identifier

   function New_Temp_Identifiers
     (Num : Positive;
      Typ : W_Type_Id)
      return W_Identifier_Array;
   --  Return an array of new unique identifiers with Num elements

   function New_Result_Ident (Typ : W_Type_Id) return W_Identifier_Id;

   function To_Exprs (Ids : W_Identifier_Array) return W_Expr_Array;
   --  Conversion each element of Ids to exprs and return the result

   function To_Program_Space (Name : W_Identifier_Id) return W_Identifier_Id;
   --  Create a new identifier for an entity in program space, given
   --  the name of the corresponding entity in logic space.

   Def_Axiom : constant String := "def_axiom";
   --  suffix for a definition axiom

   Post_Axiom          : constant String := "post_axiom";
   Post_Dispatch_Axiom : constant String := "post__dispatch_axiom";
   Post_Refine_Axiom   : constant String := "post_refine_axiom";
   --  suffix for a postcondition axiom

   Keep_On_Simp : constant String := "keep_on_simp";

   --  The following enumeration is used for two things:
   --    * a simple enumeration of strings, accessed using the "To_String"
   --      function below. In practice, many of these strings are used to build
   --      Why identifiers. To_String is also used in various *Append
   --      functions.
   --    * as a way to identify Why3 identifiers that belong to specific Ada
   --      entities, accessed using the E_Symb function in Why.Atree.Modules.
   --  Note that the first way of these is considered deprecated, instead use
   --  the E_Symb function if possible (and register the required symbols using
   --  Insert_Symbols in Why.Atree.Modules)

   type Why_Name_Enum is
     (
      WNE_Array_Base_Range_Pred,
      WNE_Array_Base_Range_Pred_2,
      WNE_Array_Base_Range_Pred_3,
      WNE_Array_Base_Range_Pred_4,
      WNE_Array_Component_Type,
      WNE_Array_Elts,
      WNE_Array_Type,
      WNE_Attr_Address,
      WNE_Attr_Constrained,
      WNE_Attr_First,
      WNE_Attr_First_2,
      WNE_Attr_First_3,
      WNE_Attr_First_4,
      WNE_Attr_Image,
      WNE_Attr_Last,
      WNE_Attr_Last_2,
      WNE_Attr_Last_3,
      WNE_Attr_Last_4,
      WNE_Attr_Length,
      WNE_Attr_Length_2,
      WNE_Attr_Length_3,
      WNE_Attr_Length_4,
      WNE_Attr_Modulus,
      WNE_Attr_Object_Size,
      WNE_Attr_Value_Size,
      WNE_Attr_Tag,

      --  Integer value of the inverse of the "small" of a fixed-point type
      WNE_Attr_Small,

      WNE_Attr_Value,
      WNE_Bool_Eq,
      WNE_Check_Not_First,
      WNE_Check_Not_Last,
      WNE_Dispatch_Eq,
      WNE_Dummy,
      WNE_Dynamic_Property,
      WNE_Dynamic_Property_BV_Int, --  for bitvector when index of an array

      --  Prefix for Why3 field names corresponding to record components
      WNE_Rec_Comp_Prefix,

      --  Name of the Why3 field representing invisible private components in
      --  a private type.
      WNE_Rec_Main,  --  rec__main__

      --  Name of the Why3 field representing extension components in a tagged
      --  type or a class-wide type.
      WNE_Rec_Extension,  --  rec__ext__

      --  Name of the Why3 field representing invisible ancestor components in
      --  record with a private ancestor.
      WNE_Rec_Ancestor,  --  rec__anc__

      --  Suffix of the above main field, to be used in related functions
      WNE_Rec_Main_Suffix,  --  main__

      --  Suffix of the above extension field, to be used in related functions
      WNE_Rec_Extension_Suffix,  --  ext__

      --  Suffix of the above ancestor field, to be used in related functions
      WNE_Rec_Ancestor_Suffix,  --  anc__

      --  Name of constant tag value for a tagged type
      WNE_Tag,  --  __tag

      --  Name of the function aggregating the extension components and the
      --  special extension field rec__ext__ in the derived type, to generate
      --  a value of the special extension field rec__ext__ in the root type.
      WNE_Hide_Extension,  --  hide_ext__

      --  Name of the function hiding ancestor components in a derived tagged
      --  type with private ancestor
      WNE_Hide_Ancestor,  --  hide_anc__

      --  Division operator for a fixed-point type
      WNE_Fixed_Point_Div,
      WNE_Fixed_Point_Div_Int,

      --  Multiplication operators for a fixed-point type
      WNE_Fixed_Point_Mult,
      WNE_Fixed_Point_Mult_Int,

      --  Name of an unknown floating-point rounding operation, when the
      --  floating-point type is neither single precision nor double precision.
      WNE_Float_Round,

      --  Name of the temporary floating point rounding operation, to be
      --  replaced when cloning module Floating
      WNE_Float_Round_Tmp,

      --  Predecessor and successor functions for a floating-point type
      WNE_Float_Pred,
      WNE_Float_Succ,

      WNE_Index_Dynamic_Property,
      WNE_Index_Dynamic_Property_2,
      WNE_Index_Dynamic_Property_3,
      WNE_Index_Dynamic_Property_4,

      --  Prefix for name of functions which extract the value of an extension
      --  component from the extension field of a value of the root type.
      WNE_Extract_Prefix,

      --  Prefix for name of functions which extract the value of an ancestor
      --  component from the ancestor field of a value of the derived type.
      WNE_Ancestor_Prefix,

      --  Name of module containing the functions which correspond to the
      --  dispatching version of a primitive operation of a tagged type.
      WNE_Dispatch_Module,  --  Dispatch

      --  Name of module containing the function which corresponds to the
      --  refined version (refined_post) of a subprogram.
      WNE_Refine_Module,  --  Dispatch

      WNE_Of_Array,
      WNE_Of_Base,
      WNE_Of_Rep,
      WNE_Of_Int,
      WNE_Of_Fixed,
      WNE_Of_Real,
      WNE_Of_BitVector,
      WNE_Range_Check_Fun,
      WNE_Range_Check_Fun_BV_Int, --  for convertion from int to bitvector
      WNE_Rec_Split_Discrs,
      WNE_Rec_Split_Fields,
      WNE_Range_Pred,
      WNE_Range_Pred_BV_Int,      --  range predicate on bv with ints
      WNE_To_Array,
      WNE_To_Base,
      WNE_To_Rep,
      WNE_To_Int,
      WNE_To_Int_2,
      WNE_To_Int_3,
      WNE_To_Int_4,
      WNE_To_Fixed,
      WNE_To_Real,
      WNE_To_BitVector
     );

   function Attr_To_Why_Name (A : Attribute_Id) return Why_Name_Enum;

   function Attr_Append (Base     : String;
                         A        : Attribute_Id;
                         Count    : Positive;
                         Typ      : W_Type_Id;
                         Module   : W_Module_Id := Why.Types.Why_Empty;
                         Ada_Node : Node_Id := Empty) return W_Identifier_Id;

   function Attr_Append (Base  : W_Identifier_Id;
                         A     : Attribute_Id;
                         Count : Positive;
                         Typ   : W_Type_Id) return W_Identifier_Id;

   function Discr_Append (Base  : W_Identifier_Id;
                          Typ   : W_Type_Id) return W_Identifier_Id;

   function Field_Append (Base  : W_Identifier_Id;
                          Typ   : W_Type_Id) return W_Identifier_Id;

   function To_String (W : Why_Name_Enum) return String;

   function To_Ident (W        : Why_Name_Enum;
                      Ada_Node : Node_Id := Empty)
                      return W_Identifier_Id;

   function To_Name (W : Why_Name_Enum) return W_Name_Id;
   function To_Name (I : W_Identifier_Id) return W_Name_Id;

   function To_Local (Name : W_Identifier_Id) return W_Identifier_Id;
   function To_Local (Name : W_Identifier_Id) return W_Name_Id;
   --  @param Name a possibly fully qualified identifier
   --  @return the identifier or name where the module component has been
   --    removed

   function WNE_Attr_First (I : Integer) return Why_Name_Enum;
   --  wrapper function for the enumeration literals WNE_Attr_First_X
   --  @param I an index between 1 and 4 selecting the dimension

   function WNE_Attr_Last (I : Integer) return Why_Name_Enum;
   --  wrapper function for the enumeration literals WNE_Attr_Last_X
   --  @param I an index between 1 and 4 selectind the dimension

   function WNE_Attr_Length (I : Integer) return Why_Name_Enum;
   --  wrapper function for the enumeration literals WNE_Attr_Last_X
   --  @param I an index between 1 and 4 selectind the dimension

   function WNE_To_Int (I : Integer) return Why_Name_Enum;
   --  wrapper function for the enumeration literals WNE_To_Int_X
   --  @param I an index between 1 and 4 selectind the dimension

   function WNE_Array_Base_Range_Pred (I : Integer) return Why_Name_Enum;
   --  wrapper function for the enumeration literals WNE_Array_Base_Range_Pred
   --  @param I an index between 1 and 4 selectind the dimension

   function WNE_Index_Dynamic_Property (I : Integer) return Why_Name_Enum;
   --  wrapper function for the enumeration literals WNE_Index_Dynamic_Property
   --  @param I an index between 1 and 4 selectind the dimension

   function Prefix (M        : W_Module_Id;
                    W        : Why_Name_Enum;
                    Ada_Node : Node_Id := Empty;
                    Typ      : W_Type_Id := Why.Types.Why_Empty)
                    return W_Identifier_Id;

   function Get_Modular_Converter_Range_Check
     (From, To : W_Type_Id) return W_Identifier_Id;
   --  @param From the BV type to convert from
   --  @param To the BV type to convert to
   --  @return the appropriate range check function

end Why.Gen.Names;
