generic
   type FT is digits <>;
   Biggest_Representable_Int : FT;
   Nextup_One                : FT;
package Generic_Float_Tests
  with SPARK_Mode
is
   pragma Elaborate_Body (Generic_Float_Tests);
end Generic_Float_Tests;
