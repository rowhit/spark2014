------------------------------------------------------------------------------
--                                                                          --
--                            GNAT2WHY COMPONENTS                           --
--                                                                          --
--                        W H Y - G E N - N A M E S                         --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--                       Copyright (C) 2010-2011, AdaCore                   --
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

with Why.Atree.Builders;  use Why.Atree.Builders;
with Why.Atree.Accessors; use Why.Atree.Accessors;
with Why.Conversions;     use Why.Conversions;

package body Why.Gen.Names is

   function Bool_Cmp_String
     (Rel       : EW_Relation;
      Arg_Types : EW_Scalar) return String;
   --  Return the name of a boolean integer comparison operator

   -----------------------
   -- EW_Base_Type_Name --
   -----------------------

   function EW_Base_Type_Name (Kind : EW_Base_Type) return String is
   begin
      case Kind is
         when EW_Unit =>
            return "unit";
         when EW_Prop =>
            return "prop";
         when EW_Real =>
            return "real";
         when EW_Int =>
            return "int";
         when EW_Bool =>
            return "bool";
      end case;
   end EW_Base_Type_Name;

   ---------------------
   -- Bool_Cmp_String --
   ---------------------

   function Bool_Cmp_String
     (Rel       : EW_Relation;
      Arg_Types : EW_Scalar) return String
   is
   begin
      case Rel is
         when EW_None =>
            pragma Assert (False);
            return "always_true_" & EW_Base_Type_Name (Arg_Types) & "_bool";
         when EW_Eq =>
            return "eq_" & EW_Base_Type_Name (Arg_Types) & "_bool";
         when EW_Ne =>
            return "neq_" & EW_Base_Type_Name (Arg_Types) & "_bool";
         when EW_Lt =>
            return "lt_" & EW_Base_Type_Name (Arg_Types) & "_bool";
         when EW_Le =>
            return "le_" & EW_Base_Type_Name (Arg_Types) & "_bool";
         when EW_Gt =>
            return "gt_" & EW_Base_Type_Name (Arg_Types) & "_bool";
         when EW_Ge =>
            return "ge_" & EW_Base_Type_Name (Arg_Types) & "_bool";
      end case;
   end Bool_Cmp_String;

   ------------------
   -- New_Bool_Cmp --
   ------------------

   function New_Bool_Cmp
     (Rel       : EW_Relation;
      Arg_Types : EW_Scalar)
     return W_Identifier_Id is
   begin
      return New_Identifier (EW_Pred, Bool_Cmp_String (Rel, Arg_Types));
   end New_Bool_Cmp;

   ------------------
   -- New_Division --
   ------------------

   function New_Division (Kind : EW_Numeric) return W_Identifier_Id is
   begin
      case Kind is
         when EW_Real =>
            return New_Real_Division.Id;
         when EW_Int =>
            return New_Integer_Division.Id;
      end case;
   end New_Division;

   --------------------
   -- New_Identifier --
   --------------------

   function New_Identifier (Name : String) return W_Identifier_Id is
   begin
      return New_Identifier (EW_Term, Name);
   end New_Identifier;

   function New_Identifier
     (Domain : EW_Domain;
      Name   : String)
     return W_Identifier_Id is
   begin
      return New_Identifier (Domain => Domain, Symbol => NID (Name));
   end New_Identifier;

   function New_Identifier
     (Name   : W_Identifier_Id;
      Label  : String)
     return W_Identifier_Id
   is
      S : constant Name_Id := Get_Symbol (Name);
      L : constant Name_Id := NID (Label);
   begin
      return New_Identifier (Domain => EW_Term, Symbol => S, Label => L);
   end New_Identifier;

   ---------
   -- NID --
   ---------

   function NID (Name : String) return Name_Id is
   begin
      Name_Len := 0;
      Add_Str_To_Name_Buffer (Name);
      return Name_Find;
   end NID;

   --------------
   -- New_Prog --
   --------------

   function New_Prog (Name : String) return W_Prog_Id is
   begin
      return +New_Identifier (EW_Prog, Name);
   end New_Prog;

   --------------
   -- New_Term --
   --------------

   function New_Term (Name : String) return W_Term_Id is
   begin
      return +New_Identifier (Name);
   end New_Term;

   ----------------------
   -- To_Program_Space --
   ----------------------

   function To_Program_Space (Name : W_Identifier_Id) return W_Identifier_Id is
      Suffix : constant String := "_";
      N_Id   : constant Name_Id := Get_Symbol (Name);
      Img    : constant String := Get_Name_String (N_Id);
   begin
      return New_Identifier (EW_Prog, Img & Suffix);
   end To_Program_Space;

   --------------------------
   -- Why_Scalar_Type_Name --
   --------------------------

   function Why_Scalar_Type_Name (Kind : EW_Scalar) return String is
   begin
      case Kind is
         when EW_Bool =>
            return "bool";
         when EW_Int =>
            return "int";
         when EW_Real =>
            return "real";
      end case;
   end Why_Scalar_Type_Name;

end Why.Gen.Names;
