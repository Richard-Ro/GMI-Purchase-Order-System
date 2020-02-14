set echo off
set heading off
set verify off
set feedback off

spool e:ReceivePO.txt
prompt
prompt ****** R E C E I V E    O R D E R ******
prompt
select 'Today''s Date: ', sysdate from dual;
prompt
accept VPONum prompt 'Please enter the Purchase Order Number: '

select 'Order Number: ',PO# from PurchaseOrders
	where PO#=&VPONum;

select 'Item Number: ',P# from PurchaseOrders
	where PO#=&VPONum;

select '   Item Description:  ', PName from Products,PurchaseOrders
	where PO#=&VPONum
	and Products.P#=PurchaseOrders.P#;

select 'Supplier Number:', S# from PurchaseOrders
	where PO#=&VPONum;
	

select '   Supplier Name: ',SName from Suppliers,PurchaseOrders
	where PO#=&VPONum
	and Suppliers.S#=PurchaseOrders.S#;

select 'Date ordered: ', PODate from PurchaseOrders
	where PO#=&VPONum;

select 'Today''s date: ', sysdate from dual;

select 'Quantity ordered: ', OrderQty from PurchaseOrders
	where PO#=&VPONum;

column UnitPrice heading 'UnitPrice' format $9,999.99
select 'Unit Price: ', UnitPrice from PurchaseOrders
	where PO#=&VPONum;

column value heading 'Amount Ordered' format $9,999.99 
select 'Amount Ordered: ',OrderQty*UnitPrice as value from PurchaseOrders 
	where PO#=&VPONum; 
prompt
accept VRecQty prompt 'Enter quantity received: '

select 'Amount Due:', UnitPrice*&VRecQty as value from PurchaseOrders
where PO#=&VPONum;

select 'Inventory Level: ', Inventory+&VRecQty from Products,PurchaseOrders
where Products.P#=PurchaseOrders.P#
and PO#=&VPONum;

prompt
prompt *************************************

update PurchaseOrders
set status='Closed',Shipdate=sysdate,ShipQty=&VRecQty,ShipAmt=(UnitPrice*&VRecQty)
where PO#=&VPONum;

select 'Order is now ---> ', status from PurchaseOrders
where PO#=&VPONum;

select 'Date Closed: ', ShipDate from PurchaseOrders
where PO#=&VPONum;

update Products
set Inventory=Inventory+&VRecQty
where P# in (select P# from PurchaseOrders where Products.P#=PurchaseOrders.P#
and PO#=&VPONum);

commit;
spool off
