set echo off
set heading off
set verify off
set feedback off

spool e:ShortShip.txt
prompt
prompt ****** SHORT SHIP Report ******
prompt
select 'Today''s Date: ',to_char (sysdate,'mm/dd/yyyy') from dual;
prompt
set heading on
select PO#,status,PODate,Products.P#,PName,OrderQty,ShipQty,trunc(OrderQty)-trunc(ShipQty) ShortQty,Suppliers.S#,SName
from PurchaseOrders,Products,Suppliers
where ShipQty<OrderQty
and Suppliers.S#=PurchaseOrders.S#
and Products.P#=PurchaseOrders.P#
and status='Closed'
and ShipQty<OrderQty
order by PO#;

spool off