with System;
package Pedantic
is
   type R is record
      F1 : Integer;
   end record;

   type A is array (Boolean) of R;

   V : R := R'(F1 => 0);

   C : constant Natural := R'Alignment;

   function Alignment_Of (X : in R) return Natural;

   function Alignment_Of_R return Natural;

   function Address_Of_V return System.Address
     with Global => (Input => V);

   function Order_Of_R return System.Bit_Order;

   function CS_Of_A return Natural;

   function First_Bit_Of_F1 return Natural;

   function Last_Bit_Of_F1 return Natural;

   function Position_Of_F1 return Natural;

   function Size_Of_A return Natural;

   function Size_Of_V return Natural;

end Pedantic;
