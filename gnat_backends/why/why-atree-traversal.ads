------------------------------------------------------------------------------
--                                                                          --
--                            GNAT2WHY COMPONENTS                           --
--                                                                          --
--                  W H Y - A T R E E - T R A V E R S A L                   --
--                                                                          --
--                                 S p e c                                  --
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

with Why.Ids; use Why.Ids;

package Why.Atree.Traversal is

   type Traverse_Control is
     (Continue,
      --  Continues the normal depth-first traversal

      Abandon_Children,
      --  Prevents traversal of the current element's children

      Abandon_Siblings,
      --  Prevents traversal of the current element's children and remaining
      --  siblings.

      Terminate_Immediately
      --  Does exactly that
      );

   type Traversal_State is abstract tagged record
      Control : Traverse_Control;
   end record;

   procedure Traverse
     (State : in out Traversal_State'Class;
      Node  : Why_Node_Id);

   procedure Traverse_List
     (State   : in out Traversal_State'Class;
      List_Id : Why_Node_List);

   procedure Identifier_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Identifier_Id)
     is null;

   procedure Identifier_Post_Op
     (State : in out Traversal_State;
      Node  : W_Identifier_Id)
     is null;

   procedure Type_Prop_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Type_Prop_Id)
     is null;

   procedure Type_Prop_Post_Op
     (State : in out Traversal_State;
      Node  : W_Type_Prop_Id)
     is null;

   procedure Type_Int_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Type_Int_Id)
     is null;

   procedure Type_Int_Post_Op
     (State : in out Traversal_State;
      Node  : W_Type_Int_Id)
     is null;

   procedure Type_Bool_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Type_Bool_Id)
     is null;

   procedure Type_Bool_Post_Op
     (State : in out Traversal_State;
      Node  : W_Type_Bool_Id)
     is null;

   procedure Type_Real_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Type_Real_Id)
     is null;

   procedure Type_Real_Post_Op
     (State : in out Traversal_State;
      Node  : W_Type_Real_Id)
     is null;

   procedure Type_Unit_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Type_Unit_Id)
     is null;

   procedure Type_Unit_Post_Op
     (State : in out Traversal_State;
      Node  : W_Type_Unit_Id)
     is null;

   procedure Abstract_Type_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Abstract_Type_Id)
     is null;

   procedure Abstract_Type_Post_Op
     (State : in out Traversal_State;
      Node  : W_Abstract_Type_Id)
     is null;

   procedure Generic_Formal_Type_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Generic_Formal_Type_Id)
     is null;

   procedure Generic_Formal_Type_Post_Op
     (State : in out Traversal_State;
      Node  : W_Generic_Formal_Type_Id)
     is null;

   procedure Generic_Actual_Type_Chain_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Generic_Actual_Type_Chain_Id)
     is null;

   procedure Generic_Actual_Type_Chain_Post_Op
     (State : in out Traversal_State;
      Node  : W_Generic_Actual_Type_Chain_Id)
     is null;

   procedure Array_Type_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Array_Type_Id)
     is null;

   procedure Array_Type_Post_Op
     (State : in out Traversal_State;
      Node  : W_Array_Type_Id)
     is null;

   procedure Ref_Type_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Ref_Type_Id)
     is null;

   procedure Ref_Type_Post_Op
     (State : in out Traversal_State;
      Node  : W_Ref_Type_Id)
     is null;

   procedure Protected_Value_Type_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Protected_Value_Type_Id)
     is null;

   procedure Protected_Value_Type_Post_Op
     (State : in out Traversal_State;
      Node  : W_Protected_Value_Type_Id)
     is null;

   procedure Anonymous_Arrow_Type_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Anonymous_Arrow_Type_Id)
     is null;

   procedure Anonymous_Arrow_Type_Post_Op
     (State : in out Traversal_State;
      Node  : W_Anonymous_Arrow_Type_Id)
     is null;

   procedure Named_Arrow_Type_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Named_Arrow_Type_Id)
     is null;

   procedure Named_Arrow_Type_Post_Op
     (State : in out Traversal_State;
      Node  : W_Named_Arrow_Type_Id)
     is null;

   procedure Computation_Spec_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Computation_Spec_Id)
     is null;

   procedure Computation_Spec_Post_Op
     (State : in out Traversal_State;
      Node  : W_Computation_Spec_Id)
     is null;

   procedure Integer_Constant_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Integer_Constant_Id)
     is null;

   procedure Integer_Constant_Post_Op
     (State : in out Traversal_State;
      Node  : W_Integer_Constant_Id)
     is null;

   procedure Real_Constant_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Real_Constant_Id)
     is null;

   procedure Real_Constant_Post_Op
     (State : in out Traversal_State;
      Node  : W_Real_Constant_Id)
     is null;

   procedure True_Literal_Pre_Op
     (State : in out Traversal_State;
      Node  : W_True_Literal_Id)
     is null;

   procedure True_Literal_Post_Op
     (State : in out Traversal_State;
      Node  : W_True_Literal_Id)
     is null;

   procedure False_Literal_Pre_Op
     (State : in out Traversal_State;
      Node  : W_False_Literal_Id)
     is null;

   procedure False_Literal_Post_Op
     (State : in out Traversal_State;
      Node  : W_False_Literal_Id)
     is null;

   procedure Void_Literal_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Void_Literal_Id)
     is null;

   procedure Void_Literal_Post_Op
     (State : in out Traversal_State;
      Node  : W_Void_Literal_Id)
     is null;

   procedure Arith_Operation_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Arith_Operation_Id)
     is null;

   procedure Arith_Operation_Post_Op
     (State : in out Traversal_State;
      Node  : W_Arith_Operation_Id)
     is null;

   procedure Negative_Term_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Negative_Term_Id)
     is null;

   procedure Negative_Term_Post_Op
     (State : in out Traversal_State;
      Node  : W_Negative_Term_Id)
     is null;

   procedure Label_Identifier_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Label_Identifier_Id)
     is null;

   procedure Label_Identifier_Post_Op
     (State : in out Traversal_State;
      Node  : W_Label_Identifier_Id)
     is null;

   procedure Operation_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Operation_Id)
     is null;

   procedure Operation_Post_Op
     (State : in out Traversal_State;
      Node  : W_Operation_Id)
     is null;

   procedure Named_Term_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Named_Term_Id)
     is null;

   procedure Named_Term_Post_Op
     (State : in out Traversal_State;
      Node  : W_Named_Term_Id)
     is null;

   procedure Conditional_Term_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Conditional_Term_Id)
     is null;

   procedure Conditional_Term_Post_Op
     (State : in out Traversal_State;
      Node  : W_Conditional_Term_Id)
     is null;

   procedure Binding_Term_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Binding_Term_Id)
     is null;

   procedure Binding_Term_Post_Op
     (State : in out Traversal_State;
      Node  : W_Binding_Term_Id)
     is null;

   procedure Protected_Term_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Protected_Term_Id)
     is null;

   procedure Protected_Term_Post_Op
     (State : in out Traversal_State;
      Node  : W_Protected_Term_Id)
     is null;

   procedure Op_Add_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Add_Id)
     is null;

   procedure Op_Add_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Add_Id)
     is null;

   procedure Op_Substract_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Substract_Id)
     is null;

   procedure Op_Substract_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Substract_Id)
     is null;

   procedure Op_Multiply_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Multiply_Id)
     is null;

   procedure Op_Multiply_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Multiply_Id)
     is null;

   procedure Op_Divide_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Divide_Id)
     is null;

   procedure Op_Divide_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Divide_Id)
     is null;

   procedure Op_Modulo_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Modulo_Id)
     is null;

   procedure Op_Modulo_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Modulo_Id)
     is null;

   procedure True_Literal_Pred_Pre_Op
     (State : in out Traversal_State;
      Node  : W_True_Literal_Pred_Id)
     is null;

   procedure True_Literal_Pred_Post_Op
     (State : in out Traversal_State;
      Node  : W_True_Literal_Pred_Id)
     is null;

   procedure False_Literal_Pred_Pre_Op
     (State : in out Traversal_State;
      Node  : W_False_Literal_Pred_Id)
     is null;

   procedure False_Literal_Pred_Post_Op
     (State : in out Traversal_State;
      Node  : W_False_Literal_Pred_Id)
     is null;

   procedure Predicate_Identifier_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Predicate_Identifier_Id)
     is null;

   procedure Predicate_Identifier_Post_Op
     (State : in out Traversal_State;
      Node  : W_Predicate_Identifier_Id)
     is null;

   procedure Predicate_Instance_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Predicate_Instance_Id)
     is null;

   procedure Predicate_Instance_Post_Op
     (State : in out Traversal_State;
      Node  : W_Predicate_Instance_Id)
     is null;

   procedure Related_Terms_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Related_Terms_Id)
     is null;

   procedure Related_Terms_Post_Op
     (State : in out Traversal_State;
      Node  : W_Related_Terms_Id)
     is null;

   procedure Implication_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Implication_Id)
     is null;

   procedure Implication_Post_Op
     (State : in out Traversal_State;
      Node  : W_Implication_Id)
     is null;

   procedure Equivalence_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Equivalence_Id)
     is null;

   procedure Equivalence_Post_Op
     (State : in out Traversal_State;
      Node  : W_Equivalence_Id)
     is null;

   procedure Disjonction_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Disjonction_Id)
     is null;

   procedure Disjonction_Post_Op
     (State : in out Traversal_State;
      Node  : W_Disjonction_Id)
     is null;

   procedure Conjonction_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Conjonction_Id)
     is null;

   procedure Conjonction_Post_Op
     (State : in out Traversal_State;
      Node  : W_Conjonction_Id)
     is null;

   procedure Negation_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Negation_Id)
     is null;

   procedure Negation_Post_Op
     (State : in out Traversal_State;
      Node  : W_Negation_Id)
     is null;

   procedure Conditional_Pred_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Conditional_Pred_Id)
     is null;

   procedure Conditional_Pred_Post_Op
     (State : in out Traversal_State;
      Node  : W_Conditional_Pred_Id)
     is null;

   procedure Binding_Pred_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Binding_Pred_Id)
     is null;

   procedure Binding_Pred_Post_Op
     (State : in out Traversal_State;
      Node  : W_Binding_Pred_Id)
     is null;

   procedure Universal_Quantif_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Universal_Quantif_Id)
     is null;

   procedure Universal_Quantif_Post_Op
     (State : in out Traversal_State;
      Node  : W_Universal_Quantif_Id)
     is null;

   procedure Existential_Quantif_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Existential_Quantif_Id)
     is null;

   procedure Existential_Quantif_Post_Op
     (State : in out Traversal_State;
      Node  : W_Existential_Quantif_Id)
     is null;

   procedure Named_Predicate_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Named_Predicate_Id)
     is null;

   procedure Named_Predicate_Post_Op
     (State : in out Traversal_State;
      Node  : W_Named_Predicate_Id)
     is null;

   procedure Protected_Predicate_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Protected_Predicate_Id)
     is null;

   procedure Protected_Predicate_Post_Op
     (State : in out Traversal_State;
      Node  : W_Protected_Predicate_Id)
     is null;

   procedure Triggers_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Triggers_Id)
     is null;

   procedure Triggers_Post_Op
     (State : in out Traversal_State;
      Node  : W_Triggers_Id)
     is null;

   procedure Trigger_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Trigger_Id)
     is null;

   procedure Trigger_Post_Op
     (State : in out Traversal_State;
      Node  : W_Trigger_Id)
     is null;

   procedure Rel_Eq_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Rel_Eq_Id)
     is null;

   procedure Rel_Eq_Post_Op
     (State : in out Traversal_State;
      Node  : W_Rel_Eq_Id)
     is null;

   procedure Rel_Ne_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Rel_Ne_Id)
     is null;

   procedure Rel_Ne_Post_Op
     (State : in out Traversal_State;
      Node  : W_Rel_Ne_Id)
     is null;

   procedure Rel_Lt_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Rel_Lt_Id)
     is null;

   procedure Rel_Lt_Post_Op
     (State : in out Traversal_State;
      Node  : W_Rel_Lt_Id)
     is null;

   procedure Rel_Le_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Rel_Le_Id)
     is null;

   procedure Rel_Le_Post_Op
     (State : in out Traversal_State;
      Node  : W_Rel_Le_Id)
     is null;

   procedure Rel_Gt_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Rel_Gt_Id)
     is null;

   procedure Rel_Gt_Post_Op
     (State : in out Traversal_State;
      Node  : W_Rel_Gt_Id)
     is null;

   procedure Rel_Ge_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Rel_Ge_Id)
     is null;

   procedure Rel_Ge_Post_Op
     (State : in out Traversal_State;
      Node  : W_Rel_Ge_Id)
     is null;

   procedure Type_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Type_Id)
     is null;

   procedure Type_Post_Op
     (State : in out Traversal_State;
      Node  : W_Type_Id)
     is null;

   procedure Logic_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Logic_Id)
     is null;

   procedure Logic_Post_Op
     (State : in out Traversal_State;
      Node  : W_Logic_Id)
     is null;

   procedure Function_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Function_Id)
     is null;

   procedure Function_Post_Op
     (State : in out Traversal_State;
      Node  : W_Function_Id)
     is null;

   procedure Predicate_Definition_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Predicate_Definition_Id)
     is null;

   procedure Predicate_Definition_Post_Op
     (State : in out Traversal_State;
      Node  : W_Predicate_Definition_Id)
     is null;

   procedure Inductive_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Inductive_Id)
     is null;

   procedure Inductive_Post_Op
     (State : in out Traversal_State;
      Node  : W_Inductive_Id)
     is null;

   procedure Axiom_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Axiom_Id)
     is null;

   procedure Axiom_Post_Op
     (State : in out Traversal_State;
      Node  : W_Axiom_Id)
     is null;

   procedure Goal_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Goal_Id)
     is null;

   procedure Goal_Post_Op
     (State : in out Traversal_State;
      Node  : W_Goal_Id)
     is null;

   procedure External_Pre_Op
     (State : in out Traversal_State;
      Node  : W_External_Id)
     is null;

   procedure External_Post_Op
     (State : in out Traversal_State;
      Node  : W_External_Id)
     is null;

   procedure Logic_Type_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Logic_Type_Id)
     is null;

   procedure Logic_Type_Post_Op
     (State : in out Traversal_State;
      Node  : W_Logic_Type_Id)
     is null;

   procedure Logic_Binder_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Logic_Binder_Id)
     is null;

   procedure Logic_Binder_Post_Op
     (State : in out Traversal_State;
      Node  : W_Logic_Binder_Id)
     is null;

   procedure Inductive_Case_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Inductive_Case_Id)
     is null;

   procedure Inductive_Case_Post_Op
     (State : in out Traversal_State;
      Node  : W_Inductive_Case_Id)
     is null;

   procedure Effects_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Effects_Id)
     is null;

   procedure Effects_Post_Op
     (State : in out Traversal_State;
      Node  : W_Effects_Id)
     is null;

   procedure Precondition_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Precondition_Id)
     is null;

   procedure Precondition_Post_Op
     (State : in out Traversal_State;
      Node  : W_Precondition_Id)
     is null;

   procedure Postcondition_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Postcondition_Id)
     is null;

   procedure Postcondition_Post_Op
     (State : in out Traversal_State;
      Node  : W_Postcondition_Id)
     is null;

   procedure Exn_Condition_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Exn_Condition_Id)
     is null;

   procedure Exn_Condition_Post_Op
     (State : in out Traversal_State;
      Node  : W_Exn_Condition_Id)
     is null;

   procedure Assertion_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Assertion_Id)
     is null;

   procedure Assertion_Post_Op
     (State : in out Traversal_State;
      Node  : W_Assertion_Id)
     is null;

   procedure Prog_Constant_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Prog_Constant_Id)
     is null;

   procedure Prog_Constant_Post_Op
     (State : in out Traversal_State;
      Node  : W_Prog_Constant_Id)
     is null;

   procedure Prog_Identifier_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Prog_Identifier_Id)
     is null;

   procedure Prog_Identifier_Post_Op
     (State : in out Traversal_State;
      Node  : W_Prog_Identifier_Id)
     is null;

   procedure Deref_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Deref_Id)
     is null;

   procedure Deref_Post_Op
     (State : in out Traversal_State;
      Node  : W_Deref_Id)
     is null;

   procedure Assignment_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Assignment_Id)
     is null;

   procedure Assignment_Post_Op
     (State : in out Traversal_State;
      Node  : W_Assignment_Id)
     is null;

   procedure Array_Access_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Array_Access_Id)
     is null;

   procedure Array_Access_Post_Op
     (State : in out Traversal_State;
      Node  : W_Array_Access_Id)
     is null;

   procedure Array_Update_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Array_Update_Id)
     is null;

   procedure Array_Update_Post_Op
     (State : in out Traversal_State;
      Node  : W_Array_Update_Id)
     is null;

   procedure Infix_Call_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Infix_Call_Id)
     is null;

   procedure Infix_Call_Post_Op
     (State : in out Traversal_State;
      Node  : W_Infix_Call_Id)
     is null;

   procedure Prefix_Call_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Prefix_Call_Id)
     is null;

   procedure Prefix_Call_Post_Op
     (State : in out Traversal_State;
      Node  : W_Prefix_Call_Id)
     is null;

   procedure Binding_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Binding_Prog_Id)
     is null;

   procedure Binding_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Binding_Prog_Id)
     is null;

   procedure Binding_Ref_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Binding_Ref_Id)
     is null;

   procedure Binding_Ref_Post_Op
     (State : in out Traversal_State;
      Node  : W_Binding_Ref_Id)
     is null;

   procedure Conditional_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Conditional_Prog_Id)
     is null;

   procedure Conditional_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Conditional_Prog_Id)
     is null;

   procedure While_Loop_Pre_Op
     (State : in out Traversal_State;
      Node  : W_While_Loop_Id)
     is null;

   procedure While_Loop_Post_Op
     (State : in out Traversal_State;
      Node  : W_While_Loop_Id)
     is null;

   procedure Statement_Sequence_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Statement_Sequence_Id)
     is null;

   procedure Statement_Sequence_Post_Op
     (State : in out Traversal_State;
      Node  : W_Statement_Sequence_Id)
     is null;

   procedure Label_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Label_Id)
     is null;

   procedure Label_Post_Op
     (State : in out Traversal_State;
      Node  : W_Label_Id)
     is null;

   procedure Assert_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Assert_Id)
     is null;

   procedure Assert_Post_Op
     (State : in out Traversal_State;
      Node  : W_Assert_Id)
     is null;

   procedure Post_Assertion_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Post_Assertion_Id)
     is null;

   procedure Post_Assertion_Post_Op
     (State : in out Traversal_State;
      Node  : W_Post_Assertion_Id)
     is null;

   procedure Opaque_Assertion_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Opaque_Assertion_Id)
     is null;

   procedure Opaque_Assertion_Post_Op
     (State : in out Traversal_State;
      Node  : W_Opaque_Assertion_Id)
     is null;

   procedure Fun_Def_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Fun_Def_Id)
     is null;

   procedure Fun_Def_Post_Op
     (State : in out Traversal_State;
      Node  : W_Fun_Def_Id)
     is null;

   procedure Binding_Fun_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Binding_Fun_Id)
     is null;

   procedure Binding_Fun_Post_Op
     (State : in out Traversal_State;
      Node  : W_Binding_Fun_Id)
     is null;

   procedure Binding_Rec_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Binding_Rec_Id)
     is null;

   procedure Binding_Rec_Post_Op
     (State : in out Traversal_State;
      Node  : W_Binding_Rec_Id)
     is null;

   procedure Prog_Sequence_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Prog_Sequence_Id)
     is null;

   procedure Prog_Sequence_Post_Op
     (State : in out Traversal_State;
      Node  : W_Prog_Sequence_Id)
     is null;

   procedure Raise_Statement_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Raise_Statement_Id)
     is null;

   procedure Raise_Statement_Post_Op
     (State : in out Traversal_State;
      Node  : W_Raise_Statement_Id)
     is null;

   procedure Raise_Statement_With_Parameters_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Raise_Statement_With_Parameters_Id)
     is null;

   procedure Raise_Statement_With_Parameters_Post_Op
     (State : in out Traversal_State;
      Node  : W_Raise_Statement_With_Parameters_Id)
     is null;

   procedure Try_Block_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Try_Block_Id)
     is null;

   procedure Try_Block_Post_Op
     (State : in out Traversal_State;
      Node  : W_Try_Block_Id)
     is null;

   procedure Unreachable_Code_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Unreachable_Code_Id)
     is null;

   procedure Unreachable_Code_Post_Op
     (State : in out Traversal_State;
      Node  : W_Unreachable_Code_Id)
     is null;

   procedure Begin_Block_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Begin_Block_Id)
     is null;

   procedure Begin_Block_Post_Op
     (State : in out Traversal_State;
      Node  : W_Begin_Block_Id)
     is null;

   procedure Protected_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Protected_Prog_Id)
     is null;

   procedure Protected_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Protected_Prog_Id)
     is null;

   procedure Op_Add_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Add_Prog_Id)
     is null;

   procedure Op_Add_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Add_Prog_Id)
     is null;

   procedure Op_Substract_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Substract_Prog_Id)
     is null;

   procedure Op_Substract_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Substract_Prog_Id)
     is null;

   procedure Op_Multiply_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Multiply_Prog_Id)
     is null;

   procedure Op_Multiply_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Multiply_Prog_Id)
     is null;

   procedure Op_Divide_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Divide_Prog_Id)
     is null;

   procedure Op_Divide_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Divide_Prog_Id)
     is null;

   procedure Op_Mod_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Mod_Prog_Id)
     is null;

   procedure Op_Mod_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Mod_Prog_Id)
     is null;

   procedure Op_Eq_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Eq_Prog_Id)
     is null;

   procedure Op_Eq_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Eq_Prog_Id)
     is null;

   procedure Op_Ne_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Ne_Prog_Id)
     is null;

   procedure Op_Ne_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Ne_Prog_Id)
     is null;

   procedure Op_Lt_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Lt_Prog_Id)
     is null;

   procedure Op_Lt_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Lt_Prog_Id)
     is null;

   procedure Op_Le_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Le_Prog_Id)
     is null;

   procedure Op_Le_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Le_Prog_Id)
     is null;

   procedure Op_Gt_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Gt_Prog_Id)
     is null;

   procedure Op_Gt_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Gt_Prog_Id)
     is null;

   procedure Op_Ge_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Ge_Prog_Id)
     is null;

   procedure Op_Ge_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Ge_Prog_Id)
     is null;

   procedure Op_Or_Else_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Or_Else_Prog_Id)
     is null;

   procedure Op_Or_Else_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Or_Else_Prog_Id)
     is null;

   procedure Op_And_Then_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_And_Then_Prog_Id)
     is null;

   procedure Op_And_Then_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_And_Then_Prog_Id)
     is null;

   procedure Op_Minus_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Minus_Prog_Id)
     is null;

   procedure Op_Minus_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Minus_Prog_Id)
     is null;

   procedure Op_Not_Prog_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Op_Not_Prog_Id)
     is null;

   procedure Op_Not_Prog_Post_Op
     (State : in out Traversal_State;
      Node  : W_Op_Not_Prog_Id)
     is null;

   procedure Binders_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Binders_Id)
     is null;

   procedure Binders_Post_Op
     (State : in out Traversal_State;
      Node  : W_Binders_Id)
     is null;

   procedure Binder_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Binder_Id)
     is null;

   procedure Binder_Post_Op
     (State : in out Traversal_State;
      Node  : W_Binder_Id)
     is null;

   procedure Recfun_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Recfun_Id)
     is null;

   procedure Recfun_Post_Op
     (State : in out Traversal_State;
      Node  : W_Recfun_Id)
     is null;

   procedure Loop_Annot_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Loop_Annot_Id)
     is null;

   procedure Loop_Annot_Post_Op
     (State : in out Traversal_State;
      Node  : W_Loop_Annot_Id)
     is null;

   procedure Wf_Arg_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Wf_Arg_Id)
     is null;

   procedure Wf_Arg_Post_Op
     (State : in out Traversal_State;
      Node  : W_Wf_Arg_Id)
     is null;

   procedure Handler_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Handler_Id)
     is null;

   procedure Handler_Post_Op
     (State : in out Traversal_State;
      Node  : W_Handler_Id)
     is null;

   procedure File_Pre_Op
     (State : in out Traversal_State;
      Node  : W_File_Id)
     is null;

   procedure File_Post_Op
     (State : in out Traversal_State;
      Node  : W_File_Id)
     is null;

   procedure Global_Binding_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Global_Binding_Id)
     is null;

   procedure Global_Binding_Post_Op
     (State : in out Traversal_State;
      Node  : W_Global_Binding_Id)
     is null;

   procedure Global_Rec_Binding_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Global_Rec_Binding_Id)
     is null;

   procedure Global_Rec_Binding_Post_Op
     (State : in out Traversal_State;
      Node  : W_Global_Rec_Binding_Id)
     is null;

   procedure Parameter_Declaration_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Parameter_Declaration_Id)
     is null;

   procedure Parameter_Declaration_Post_Op
     (State : in out Traversal_State;
      Node  : W_Parameter_Declaration_Id)
     is null;

   procedure Exception_Declaration_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Exception_Declaration_Id)
     is null;

   procedure Exception_Declaration_Post_Op
     (State : in out Traversal_State;
      Node  : W_Exception_Declaration_Id)
     is null;

   procedure Logic_Declaration_Pre_Op
     (State : in out Traversal_State;
      Node  : W_Logic_Declaration_Id)
     is null;

   procedure Logic_Declaration_Post_Op
     (State : in out Traversal_State;
      Node  : W_Logic_Declaration_Id)
     is null;

end Why.Atree.Traversal;
