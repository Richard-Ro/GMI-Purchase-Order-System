set echo off
set heading on
set verify off
set feedback on

spool e:SupplierMonthly.txt
prompt
prompt ******* SUPPLIER MONTHLY Report *******
prompt


column TotalAmount heading 'TotalAmount' format $9,999.99

select Suppliers.S#,SName,TO_CHAR(PODate, 'mm/yyyy') OrderMonth,count(PO#) NoOfOrders,sum(OrderQty)TotalUnits,sum(OrderAmt)TotalAmount
from PurchaseOrders,Suppliers,Products
where Suppliers.S#=PurchaseOrders.S# and Products.P#=PurchaseOrders.P# 
group by Suppliers.S#,SName,PODate
order by S#,OrderMonth;


spool off

