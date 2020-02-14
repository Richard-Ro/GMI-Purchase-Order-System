set echo off
set heading on
set verify off
set feedback off

spool e:Aging.txt
prompt
prompt ****** PURCHASE ORDER AGING Report ******
prompt
select 'Today''s Date: ',to_char (sysdate,'mm/dd/yyyy') from dual;
prompt
accept VDays prompt 'Please enter number of days to query: '

select PO#,status,PODate,Products.P#,PName,OrderQty,UnitPrice,Suppliers.S#,SName, trunc(sysdate)-trunc(PODate) DaysOpen 
from Purchaseorders,Products,Suppliers
where trunc(sysdate)-trunc(PODate)>=&VDays
and status='Open'
and Products.P#=PurchaseOrders.P#
and Suppliers.S#=PurchaseOrders.S#
order by DaysOpen desc;


spool off