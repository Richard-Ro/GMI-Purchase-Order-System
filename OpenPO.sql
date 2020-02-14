set echo off
set heading off
set verify off
set feedback off

spool e:OpenPO.txt
prompt
prompt ****** O P E N     O R D E R  ******
Select 'Today''s Date: ', sysdate from dual;

prompt
accept VPNum prompt 'Enter the Item Number: '


select 'Item Description: ', PName from Products
	where P#='&VPNum';

select 'Current Inventory Level: ', ltrim(rtrim(Inventory)) from Products
	where P#='&VPNum';
prompt
prompt Please select from one of the following Authorized Suppliers:
column UnitPrice heading 'UnitPrice' format $9,999.99


set heading on

select Suppliers.S#,SName,City||','||State Location,Pricelist.UnitPrice from Pricelist,Suppliers 
	where P#='&VPNum'
	and Pricelist.S#=Suppliers.S#;

set heading off

prompt	
accept VSNum prompt 'Enter the Supplier Number: '


select 'Supplier Name: ', ltrim(rtrim(SName)) from Suppliers
	where S#='&VSNum';

select 'Address: ', ltrim(rtrim(Address)) from Suppliers
	where S#='&VSNum';

select 'City, State Zip: ', initcap(rtrim(City))||','||initcap(ltrim(rtrim(State))) from Suppliers
	where S#='&VSNum'; 


select 'Phone:', '('||substr(Phone,1,3)||')'||' '||substr(Phone,4,3)||'-'||substr(Phone,7,4) from Suppliers
	where S#='&VSNum';

prompt

accept VOrderQty prompt 'Enter Order Quantity: '

column UnitPrice heading 'UnitPrice' format $9,999.99

select 'Unit Price: ', UnitPrice from Pricelist
	where S#='&VSNum'
	and P#='&VPNum';
	
column value heading 'Amount Ordered' format $9,999.99
select 'Amount Ordered: ', UnitPrice * &VOrderQty as value from Pricelist
	where S#='&VSNum'
	and P#='&VPNum';


insert into PurchaseOrders (PO#,PODate,status,UnitPrice,OrderQty, OrderAmt,P#,S#)
        select Maxnum, sysdate, 'Open',UnitPrice, &VOrderQty, UnitPrice*&VOrderQty,'&VPNum','&VSNum'
	from Counter,Pricelist
	where P#='&VPNum'
	and S#='&VSNum'; 


select '***** Order Status: ', status from PurchaseOrders, counter
	where PO#=Maxnum;
	 
select '****** Purchase Order number is -----> ', PO# from PurchaseOrders, counter
	where PO# = Maxnum;

update counter set maxnum=maxnum+1;	
commit;

spool off

