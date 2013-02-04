pragma Ada_2012;
with Ada.Containers.Formal_Doubly_Linked_Lists; use Ada.Containers;

package Int_List is
  type my_record (capacity : Integer) is private;

   subtype My_Int is Integer range 1 .. 100;

   function My_Eq (I1 : My_Int; I2 : My_Int) return Boolean is (I1 = I2);

   package My_Lists is new Ada.Containers.Formal_Doubly_Linked_Lists
     (My_Int, "=" => My_Eq);
   use My_Lists;

   procedure Add (L : in out List; I : My_Int) with
     Pre  => L.Length < L.Capacity,
     Post =>
       L.Element (L.First) = I
         and then
       L.Length = L'Old.Length + 1
         and then
       (for all C in L'Old.Iterate => L.Element (C) = L'Old.Element (C));

   procedure Incr (L : in out List) with
     Pre  => (for all C in L.Iterate => L.Element (C) < My_Int'Last),
     Post =>
       L.Length = L'Old.Length
         and then
       (for all C in L.Iterate => L.Element (C) = L'Old.Element (C) + 1);

private
  type my_record (capacity : Integer) is record
    capacity2 : Integer;
  end record;
end Int_List;
