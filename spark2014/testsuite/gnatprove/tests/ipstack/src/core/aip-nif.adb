------------------------------------------------------------------------------
--                            IPSTACK COMPONENTS                            --
--             Copyright (C) 2010, Free Software Foundation, Inc.           --
------------------------------------------------------------------------------

package body AIP.NIF is

   type Netif is record
      State             : Netif_State := Invalid;
      --  Interface state

      Name              : Netif_Name;
      --  Unique name of interface

      LL_Address        : Netif_LL_Address;
      --  Link-level address

      LL_Address_Length : U8_T;
      --  Actual length of link level address

      MTU               : U16_T;
      --  Maximum Transmission Unit

      IP                : IPaddrs.IPaddr;
      --  IP address

      Mask              : IPaddrs.IPaddr;
      --  Netmask

      Broadcast         : IPaddrs.IPaddr;
      --  Broadcast address: (IP and mask) or (not mask)

      Input_CB          : Callbacks.CBK_Id;
      --  Packet input callback
      --  procedure I (Buf : Buffer_Id; Nid : Netif_Id);

      Output_CB         : Callbacks.CBK_Id;
      --  Packet output callback (called by network layer)
      --  procedure O (Buf : Buffer_Id; Nid : Netif_Id; Dst_Address : IPaddr);

      Link_Output_CB   : Callbacks.CBK_Id;
      --  Link level packet output callback (called by ARP layer)
      --  procedure LO (Buf : Buffer_Id; Nid : Netif_Id);

      Dev               : System.Address;
      --  Driver private information
   end record;
   pragma Convention (C, Netif);

   type NIF_Array is array (Netif_Id) of aliased Netif;

   NIFs : NIF_Array;

   --------------------
   -- Allocate_Netif --
   --------------------

   procedure Allocate_Netif (Nid : out EID) is
   begin
      Nid := IF_NOID;
      for J in NIFs'Range loop
         if NIFs (J).State = Invalid then
            Nid := J;

            --  Mark NIF as allocated

            NIFs (J).State := Down;
            exit;
         end if;
      end loop;
   end Allocate_Netif;

   ---------------
   -- Get_Netif --
   ---------------

   function Get_Netif (Nid : Netif_Id) return System.Address is
   begin
      return NIFs (Nid)'Address;
   end Get_Netif;

   ----------------------
   -- Is_Local_Address --
   ----------------------

   function Is_Local_Address
     (Nid  : Netif_Id;
      Addr : IPaddrs.IPaddr) return Boolean
   is
   begin
      return Addr = NIF_Addr (Nid);
   end Is_Local_Address;

   --------------------------
   -- Is_Broadcast_Address --
   --------------------------

   function Is_Broadcast_Address
     (Nid  : Netif_Id;
      Addr : IPaddrs.IPaddr) return Boolean
   is
   begin
      return Addr = IPaddrs.IP_ADDR_BCAST
               or else Addr = NIF_Broadcast (Nid);
   end Is_Broadcast_Address;

   ----------------------
   -- Low_Level_Output --
   ----------------------

   procedure Low_Level_Output
     (Nid : Netif_Id;
      Buf : Buffers.Buffer_Id)
   is
   begin
      --  Call Nid's LL_output callback???
      null;
   end Low_Level_Output;

   -------------------
   -- NIF_Broadcast --
   -------------------

   function NIF_Broadcast (Nid : Netif_Id) return IPaddrs.IPaddr is
   begin
      return NIFs (Nid).Broadcast;
   end NIF_Broadcast;

   ------------
   -- NIF_Addr --
   ------------

   function NIF_Addr (Nid : Netif_Id) return IPaddrs.IPaddr is
   begin
      return NIFs (Nid).IP;
   end NIF_Addr;

   --------------
   -- NIF_Mask --
   --------------

   function NIF_Mask (Nid : Netif_Id) return IPaddrs.IPaddr is
   begin
      return NIFs (Nid).Mask;
   end NIF_Mask;

end AIP.NIF;
