------------------------------------------------------------------------------
--                                                                          --
--                            GNAT2WHY COMPONENTS                           --
--                                                                          --
--                  W H Y - A T R E E - T R A V E R S A L                   --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--                       Copyright (C) 2010, AdaCore                        --
--                                                                          --
-- gnat2why is  free  software;  you can redistribute it and/or modify it   --
-- under terms of the  GNU General Public License as published  by the Free --
-- Software Foundation;  either version  2,  or  (at your option) any later --
-- version. gnat2why is distributed in the hope that it will  be  useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHAN-  --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License  for more details. You  should  have  received a copy of the GNU --
-- General Public License  distributed with GNAT; see file COPYING. If not, --
-- write to the Free Software Foundation,  51 Franklin Street, Fifth Floor, --
-- Boston,                                                                  --
--                                                                          --
-- gnat2why is maintained by AdaCore (http://www.adacore.com)               --
--                                                                          --
------------------------------------------------------------------------------

with Why.Sinfo;           use Why.Sinfo;
with Why.Atree.Tables;    use Why.Atree.Tables;
with Why.Atree.Accessors; use Why.Atree.Accessors;

package body Why.Atree.Traversal is

   --------------
   -- Traverse --
   --------------

   procedure Traverse
     (State : in out Traversal_State'Class;
      Node  : Why_Node_Id) is
   begin
      if State.Control = Terminate_Immediately then
         return;
      end if;

      if State.Control = Abandon_Siblings then
         return;
      end if;

      if Node = Why_Empty then
         return;
      end if;

      case Get_Kind (Node) is
         when W_Identifier =>
            Identifier_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Identifier_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Type_Prop =>
            Type_Prop_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Type_Prop_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Type_Int =>
            Type_Int_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Type_Int_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Type_Bool =>
            Type_Bool_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Type_Bool_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Type_Real =>
            Type_Real_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Type_Real_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Type_Unit =>
            Type_Unit_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Type_Unit_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Abstract_Type =>
            Abstract_Type_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Abstract_Type_Get_Name (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Abstract_Type_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Generic_Formal_Type =>
            Generic_Formal_Type_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Generic_Formal_Type_Get_Name (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Generic_Formal_Type_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Generic_Actual_Type_Chain =>
            Generic_Actual_Type_Chain_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse_List
              (State,
               Generic_Actual_Type_Chain_Get_Type_Chain (Node));
            Traverse
              (State,
               Generic_Actual_Type_Chain_Get_Name (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Generic_Actual_Type_Chain_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Array_Type =>
            Array_Type_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Array_Type_Get_Component_Type (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Array_Type_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Ref_Type =>
            Ref_Type_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Ref_Type_Get_Aliased_Type (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Ref_Type_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Protected_Value_Type =>
            Protected_Value_Type_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Protected_Value_Type_Get_Value_Type (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Protected_Value_Type_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Anonymous_Arrow_Type =>
            Anonymous_Arrow_Type_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Anonymous_Arrow_Type_Get_Left (Node));
            Traverse
              (State,
               Anonymous_Arrow_Type_Get_Right (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Anonymous_Arrow_Type_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Named_Arrow_Type =>
            Named_Arrow_Type_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Named_Arrow_Type_Get_Name (Node));
            Traverse
              (State,
               Named_Arrow_Type_Get_Left (Node));
            Traverse
              (State,
               Named_Arrow_Type_Get_Right (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Named_Arrow_Type_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Computation_Spec =>
            Computation_Spec_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Computation_Spec_Get_Precondition (Node));
            Traverse
              (State,
               Computation_Spec_Get_Result_Name (Node));
            Traverse
              (State,
               Computation_Spec_Get_Return_Type (Node));
            Traverse
              (State,
               Computation_Spec_Get_Effects (Node));
            Traverse
              (State,
               Computation_Spec_Get_Postcondition (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Computation_Spec_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Integer_Constant =>
            Integer_Constant_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Integer_Constant_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Real_Constant =>
            Real_Constant_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Real_Constant_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_True_Literal =>
            True_Literal_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            True_Literal_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_False_Literal =>
            False_Literal_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            False_Literal_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Void_Literal =>
            Void_Literal_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Void_Literal_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Arith_Operation =>
            Arith_Operation_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Arith_Operation_Get_Left (Node));
            Traverse
              (State,
               Arith_Operation_Get_Op (Node));
            Traverse
              (State,
               Arith_Operation_Get_Right (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Arith_Operation_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Negative_Term =>
            Negative_Term_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Negative_Term_Get_Operand (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Negative_Term_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Label_Identifier =>
            Label_Identifier_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Label_Identifier_Get_Name (Node));
            Traverse
              (State,
               Label_Identifier_Get_Label (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Label_Identifier_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Operation =>
            Operation_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Operation_Get_Name (Node));
            Traverse_List
              (State,
               Operation_Get_Parameters (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Operation_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Named_Term =>
            Named_Term_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Named_Term_Get_Name (Node));
            Traverse
              (State,
               Named_Term_Get_Term (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Named_Term_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Conditional_Term =>
            Conditional_Term_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Conditional_Term_Get_Condition (Node));
            Traverse
              (State,
               Conditional_Term_Get_Then_Part (Node));
            Traverse
              (State,
               Conditional_Term_Get_Else_Part (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Conditional_Term_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Binding_Term =>
            Binding_Term_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Binding_Term_Get_Name (Node));
            Traverse
              (State,
               Binding_Term_Get_Def (Node));
            Traverse
              (State,
               Binding_Term_Get_Context (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Binding_Term_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Protected_Term =>
            Protected_Term_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Protected_Term_Get_Term (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Protected_Term_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Add =>
            Op_Add_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Add_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Substract =>
            Op_Substract_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Substract_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Multiply =>
            Op_Multiply_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Multiply_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Divide =>
            Op_Divide_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Divide_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Modulo =>
            Op_Modulo_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Modulo_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_True_Literal_Pred =>
            True_Literal_Pred_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            True_Literal_Pred_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_False_Literal_Pred =>
            False_Literal_Pred_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            False_Literal_Pred_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Predicate_Identifier =>
            Predicate_Identifier_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Predicate_Identifier_Get_Name (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Predicate_Identifier_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Predicate_Instance =>
            Predicate_Instance_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Predicate_Instance_Get_Name (Node));
            Traverse_List
              (State,
               Predicate_Instance_Get_Parameters (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Predicate_Instance_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Related_Terms =>
            Related_Terms_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Related_Terms_Get_Left (Node));
            Traverse
              (State,
               Related_Terms_Get_Op (Node));
            Traverse
              (State,
               Related_Terms_Get_Right (Node));
            Traverse
              (State,
               Related_Terms_Get_Op2 (Node));
            Traverse
              (State,
               Related_Terms_Get_Right2 (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Related_Terms_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Implication =>
            Implication_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Implication_Get_Left (Node));
            Traverse
              (State,
               Implication_Get_Right (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Implication_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Equivalence =>
            Equivalence_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Equivalence_Get_Left (Node));
            Traverse
              (State,
               Equivalence_Get_Right (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Equivalence_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Disjonction =>
            Disjonction_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Disjonction_Get_Left (Node));
            Traverse
              (State,
               Disjonction_Get_Right (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Disjonction_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Conjonction =>
            Conjonction_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Conjonction_Get_Left (Node));
            Traverse
              (State,
               Conjonction_Get_Right (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Conjonction_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Negation =>
            Negation_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Negation_Get_Operand (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Negation_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Conditional_Pred =>
            Conditional_Pred_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Conditional_Pred_Get_Condition (Node));
            Traverse
              (State,
               Conditional_Pred_Get_Then_Part (Node));
            Traverse
              (State,
               Conditional_Pred_Get_Else_Part (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Conditional_Pred_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Binding_Pred =>
            Binding_Pred_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Binding_Pred_Get_Name (Node));
            Traverse
              (State,
               Binding_Pred_Get_Def (Node));
            Traverse
              (State,
               Binding_Pred_Get_Context (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Binding_Pred_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Universal_Quantif =>
            Universal_Quantif_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse_List
              (State,
               Universal_Quantif_Get_Variables (Node));
            Traverse
              (State,
               Universal_Quantif_Get_Var_Type (Node));
            Traverse_List
              (State,
               Universal_Quantif_Get_Triggers (Node));
            Traverse
              (State,
               Universal_Quantif_Get_Pred (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Universal_Quantif_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Existential_Quantif =>
            Existential_Quantif_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse_List
              (State,
               Existential_Quantif_Get_Variables (Node));
            Traverse
              (State,
               Existential_Quantif_Get_Var_Type (Node));
            Traverse
              (State,
               Existential_Quantif_Get_Pred (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Existential_Quantif_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Named_Predicate =>
            Named_Predicate_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Named_Predicate_Get_Name (Node));
            Traverse
              (State,
               Named_Predicate_Get_Pred (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Named_Predicate_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Protected_Predicate =>
            Protected_Predicate_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Protected_Predicate_Get_Pred (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Protected_Predicate_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Triggers =>
            Triggers_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse_List
              (State,
               Triggers_Get_Triggers (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Triggers_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Trigger =>
            Trigger_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse_List
              (State,
               Trigger_Get_Terms (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Trigger_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Rel_Eq =>
            Rel_Eq_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Rel_Eq_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Rel_Ne =>
            Rel_Ne_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Rel_Ne_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Rel_Lt =>
            Rel_Lt_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Rel_Lt_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Rel_Le =>
            Rel_Le_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Rel_Le_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Rel_Gt =>
            Rel_Gt_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Rel_Gt_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Rel_Ge =>
            Rel_Ge_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Rel_Ge_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Type =>
            Type_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Type_Get_External (Node));
            Traverse_List
              (State,
               Type_Get_Type_Parameters (Node));
            Traverse
              (State,
               Type_Get_Name (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Type_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Logic =>
            Logic_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Logic_Get_External (Node));
            Traverse_List
              (State,
               Logic_Get_Names (Node));
            Traverse
              (State,
               Logic_Get_Logic_Type (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Logic_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Function =>
            Function_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Function_Get_Name (Node));
            Traverse_List
              (State,
               Function_Get_Binders (Node));
            Traverse
              (State,
               Function_Get_Return_Type (Node));
            Traverse
              (State,
               Function_Get_Def (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Function_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Predicate_Definition =>
            Predicate_Definition_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Predicate_Definition_Get_Name (Node));
            Traverse_List
              (State,
               Predicate_Definition_Get_Binders (Node));
            Traverse
              (State,
               Predicate_Definition_Get_Def (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Predicate_Definition_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Inductive =>
            Inductive_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Inductive_Get_Name (Node));
            Traverse
              (State,
               Inductive_Get_Logic_Type (Node));
            Traverse_List
              (State,
               Inductive_Get_Def (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Inductive_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Axiom =>
            Axiom_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Axiom_Get_Name (Node));
            Traverse
              (State,
               Axiom_Get_Def (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Axiom_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Goal =>
            Goal_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Goal_Get_Name (Node));
            Traverse
              (State,
               Goal_Get_Def (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Goal_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_External =>
            External_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            External_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Logic_Type =>
            Logic_Type_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse_List
              (State,
               Logic_Type_Get_Arg_Types (Node));
            Traverse_List
              (State,
               Logic_Type_Get_Return_Type (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Logic_Type_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Logic_Binder =>
            Logic_Binder_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Logic_Binder_Get_Name (Node));
            Traverse
              (State,
               Logic_Binder_Get_Param_Type (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Logic_Binder_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Inductive_Case =>
            Inductive_Case_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Inductive_Case_Get_Name (Node));
            Traverse
              (State,
               Inductive_Case_Get_Pred (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Inductive_Case_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Effects =>
            Effects_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse_List
              (State,
               Effects_Get_Reads (Node));
            Traverse_List
              (State,
               Effects_Get_Writes (Node));
            Traverse_List
              (State,
               Effects_Get_Raises (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Effects_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Precondition =>
            Precondition_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Precondition_Get_Assertion (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Precondition_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Postcondition =>
            Postcondition_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Postcondition_Get_Assertion (Node));
            Traverse_List
              (State,
               Postcondition_Get_Handlers (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Postcondition_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Exn_Condition =>
            Exn_Condition_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Exn_Condition_Get_Exn_Case (Node));
            Traverse
              (State,
               Exn_Condition_Get_Assertion (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Exn_Condition_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Assertion =>
            Assertion_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Assertion_Get_Pred (Node));
            Traverse
              (State,
               Assertion_Get_As (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Assertion_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Prog_Constant =>
            Prog_Constant_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Prog_Constant_Get_Def (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Prog_Constant_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Prog_Identifier =>
            Prog_Identifier_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Prog_Identifier_Get_Def (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Prog_Identifier_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Deref =>
            Deref_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Deref_Get_Ref (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Deref_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Assignment =>
            Assignment_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Assignment_Get_Name (Node));
            Traverse
              (State,
               Assignment_Get_Value (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Assignment_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Array_Access =>
            Array_Access_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Array_Access_Get_Name (Node));
            Traverse
              (State,
               Array_Access_Get_Index (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Array_Access_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Array_Update =>
            Array_Update_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Array_Update_Get_Name (Node));
            Traverse
              (State,
               Array_Update_Get_Index (Node));
            Traverse
              (State,
               Array_Update_Get_Value (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Array_Update_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Infix_Call =>
            Infix_Call_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Infix_Call_Get_Left (Node));
            Traverse
              (State,
               Infix_Call_Get_Infix (Node));
            Traverse
              (State,
               Infix_Call_Get_Right (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Infix_Call_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Prefix_Call =>
            Prefix_Call_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Prefix_Call_Get_Prefix (Node));
            Traverse
              (State,
               Prefix_Call_Get_Operand (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Prefix_Call_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Binding_Prog =>
            Binding_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Binding_Prog_Get_Name (Node));
            Traverse
              (State,
               Binding_Prog_Get_Def (Node));
            Traverse
              (State,
               Binding_Prog_Get_Context (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Binding_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Binding_Ref =>
            Binding_Ref_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Binding_Ref_Get_Name (Node));
            Traverse
              (State,
               Binding_Ref_Get_Def (Node));
            Traverse
              (State,
               Binding_Ref_Get_Context (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Binding_Ref_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Conditional_Prog =>
            Conditional_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Conditional_Prog_Get_Condition (Node));
            Traverse
              (State,
               Conditional_Prog_Get_Then_Part (Node));
            Traverse
              (State,
               Conditional_Prog_Get_Else_Part (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Conditional_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_While_Loop =>
            While_Loop_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               While_Loop_Get_Condition (Node));
            Traverse
              (State,
               While_Loop_Get_Annotation (Node));
            Traverse
              (State,
               While_Loop_Get_Loop_Content (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            While_Loop_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Statement_Sequence =>
            Statement_Sequence_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse_List
              (State,
               Statement_Sequence_Get_Statements (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Statement_Sequence_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Label =>
            Label_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Label_Get_Name (Node));
            Traverse
              (State,
               Label_Get_Def (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Label_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Assert =>
            Assert_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse_List
              (State,
               Assert_Get_Assertions (Node));
            Traverse
              (State,
               Assert_Get_Prog (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Assert_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Post_Assertion =>
            Post_Assertion_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Post_Assertion_Get_Prog (Node));
            Traverse
              (State,
               Post_Assertion_Get_Post (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Post_Assertion_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Opaque_Assertion =>
            Opaque_Assertion_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Opaque_Assertion_Get_Prog (Node));
            Traverse
              (State,
               Opaque_Assertion_Get_Post (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Opaque_Assertion_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Fun_Def =>
            Fun_Def_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Fun_Def_Get_Binders (Node));
            Traverse
              (State,
               Fun_Def_Get_Def (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Fun_Def_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Binding_Fun =>
            Binding_Fun_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Binding_Fun_Get_Name (Node));
            Traverse
              (State,
               Binding_Fun_Get_Binders (Node));
            Traverse
              (State,
               Binding_Fun_Get_Def (Node));
            Traverse
              (State,
               Binding_Fun_Get_Context (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Binding_Fun_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Binding_Rec =>
            Binding_Rec_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Binding_Rec_Get_Recfun (Node));
            Traverse
              (State,
               Binding_Rec_Get_Context (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Binding_Rec_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Prog_Sequence =>
            Prog_Sequence_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse_List
              (State,
               Prog_Sequence_Get_Progs (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Prog_Sequence_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Raise_Statement =>
            Raise_Statement_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Raise_Statement_Get_Name (Node));
            Traverse
              (State,
               Raise_Statement_Get_Exn_Type (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Raise_Statement_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Raise_Statement_With_Parameters =>
            Raise_Statement_With_Parameters_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Raise_Statement_With_Parameters_Get_Name (Node));
            Traverse
              (State,
               Raise_Statement_With_Parameters_Get_Parameter (Node));
            Traverse
              (State,
               Raise_Statement_With_Parameters_Get_Exn_Type (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Raise_Statement_With_Parameters_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Try_Block =>
            Try_Block_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Try_Block_Get_Prog (Node));
            Traverse_List
              (State,
               Try_Block_Get_Handler (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Try_Block_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Unreachable_Code =>
            Unreachable_Code_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Unreachable_Code_Get_Exn_Type (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Unreachable_Code_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Begin_Block =>
            Begin_Block_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Begin_Block_Get_Prog (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Begin_Block_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Protected_Prog =>
            Protected_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Protected_Prog_Get_Prog (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Protected_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Add_Prog =>
            Op_Add_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Add_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Substract_Prog =>
            Op_Substract_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Substract_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Multiply_Prog =>
            Op_Multiply_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Multiply_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Divide_Prog =>
            Op_Divide_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Divide_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Mod_Prog =>
            Op_Mod_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Mod_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Eq_Prog =>
            Op_Eq_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Eq_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Ne_Prog =>
            Op_Ne_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Ne_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Lt_Prog =>
            Op_Lt_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Lt_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Le_Prog =>
            Op_Le_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Le_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Gt_Prog =>
            Op_Gt_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Gt_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Ge_Prog =>
            Op_Ge_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Ge_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Or_Else_Prog =>
            Op_Or_Else_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Or_Else_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_And_Then_Prog =>
            Op_And_Then_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_And_Then_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Minus_Prog =>
            Op_Minus_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Minus_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Op_Not_Prog =>
            Op_Not_Prog_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Op_Not_Prog_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Binders =>
            Binders_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse_List
              (State,
               Binders_Get_Binders (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Binders_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Binder =>
            Binder_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse_List
              (State,
               Binder_Get_Names (Node));
            Traverse
              (State,
               Binder_Get_Arg_Type (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Binder_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Recfun =>
            Recfun_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Recfun_Get_Name (Node));
            Traverse
              (State,
               Recfun_Get_Binders (Node));
            Traverse
              (State,
               Recfun_Get_Return_Type (Node));
            Traverse
              (State,
               Recfun_Get_Variant (Node));
            Traverse
              (State,
               Recfun_Get_Def (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Recfun_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Loop_Annot =>
            Loop_Annot_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Loop_Annot_Get_Invariant (Node));
            Traverse
              (State,
               Loop_Annot_Get_Variant (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Loop_Annot_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Wf_Arg =>
            Wf_Arg_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Wf_Arg_Get_Def (Node));
            Traverse
              (State,
               Wf_Arg_Get_For_Id (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Wf_Arg_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Handler =>
            Handler_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Handler_Get_Name (Node));
            Traverse
              (State,
               Handler_Get_Parameter (Node));
            Traverse
              (State,
               Handler_Get_Def (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Handler_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_File =>
            File_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse_List
              (State,
               File_Get_Declarations (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            File_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Global_Binding =>
            Global_Binding_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Global_Binding_Get_Name (Node));
            Traverse
              (State,
               Global_Binding_Get_Binders (Node));
            Traverse
              (State,
               Global_Binding_Get_Def (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Global_Binding_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Global_Rec_Binding =>
            Global_Rec_Binding_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Global_Rec_Binding_Get_Name (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Global_Rec_Binding_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Parameter_Declaration =>
            Parameter_Declaration_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Parameter_Declaration_Get_External (Node));
            Traverse_List
              (State,
               Parameter_Declaration_Get_Names (Node));
            Traverse_List
              (State,
               Parameter_Declaration_Get_Parameter_Type (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Parameter_Declaration_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Exception_Declaration =>
            Exception_Declaration_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Exception_Declaration_Get_Name (Node));
            Traverse
              (State,
               Exception_Declaration_Get_Parameter (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Exception_Declaration_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when W_Logic_Declaration =>
            Logic_Declaration_Pre_Op (State, Node);

            if State.Control = Abandon_Children then
               State.Control := Continue;
               return;
            end if;

            if State.Control = Abandon_Siblings then
               return;
            end if;

            Traverse
              (State,
               Logic_Declaration_Get_Decl (Node));

            if State.Control = Terminate_Immediately then
               return;
            end if;

            Logic_Declaration_Post_Op (State, Node);

            if State.Control = Abandon_Siblings then
               State.Control := Continue;
            end if;

            if State.Control = Terminate_Immediately then
               return;
            end if;

         when others =>
            pragma Assert (False);
      end case;   end Traverse;

   -------------------
   -- Traverse_List --
   -------------------

   procedure Traverse_List
     (State   : in out Traversal_State'Class;
      List_Id : Why_Node_List)
   is
      use Node_Lists;

      Position : Cursor := First (Get_List (List_Id));
   begin
      while Position /= No_Element loop
         pragma Assert (Has_Element (Position)
                        and then State.Control /= Abandon_Siblings
                        and then State.Control /= Terminate_Immediately);

         declare
            Node : constant Why_Node_Id := Element (Position);
         begin
            exit when State.Control = Abandon_Siblings
              or else State.Control = Terminate_Immediately;

            Traverse (State, Node);
         end;

         Next (Position);
      end loop;
   end Traverse_List;

end Why.Atree.Traversal;
