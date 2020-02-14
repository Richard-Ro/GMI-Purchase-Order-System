set echo off
set heading off
set verify off
set feedback off

spool e:QueryPO.txt
prompt
Prompt ****** Q U E R Y    O R D E R ******
Prompt
accept VPurchaseOrder prompt 'Please enter the Purchase Order Number: '

Select 'Purchase Order Number: ', PO# from PurchaseOrders 
	where PO#=('&VPurchaseOrder');

Select 'Item Number: ', P# from PurchaseOrders
	where PO#=('&VPurchaseOrder');

Select 'Item Description: ', PName from Products,PurchaseOrders
	where PO#=('&VPurchaseOrder')
	and Products.P#=PurchaseOrders.P#; 

Select 'Current Inventory Level: ', Inventory from Products, PurchaseOrders
	where PO#=('&VPurchaseOrder')
	and Products.P#=PurchaseOrders.P#;

Select 'Supplier Number: ', Suppliers.S# from Suppliers, PurchaseOrders
	where PO#=('&VPurchaseOrder')
	and Suppliers.S#=PurchaseOrders.S#;

Select 'Supplier Name: ', SName from Suppliers, PurchaseOrders
	where PO#=('&VPurchaseOrder')
	and Suppliers.S#=PurchaseOrders.S#;

Select 'Date Ordered: ', PODate from PurchaseOrders
	where PO#=('&VPurchaseOrder'); 
prompt


Select 'Quantity Ordered: ', OrderQty from PurchaseOrders
	 where PO#=('&VPurchaseOrder');

	
Select 'Date Received: ', ShipDate from PurchaseOrders
	where PO#=('&VPurchaseOrder');

Select 'Quantity Receieved: ', ShipQty from PurchaseOrders
	where PO#=('&VPurchaseOrder');

column UnitPrice heading 'UnitPrice' format $9,999.99

Select 'Unit Price: ', UnitPrice from PurchaseOrders
	where PO#=('&VPurchaseOrder');

column value heading 'Amount Ordered' format $9,999.99
select 'Amount Ordered: ', UnitPrice * OrderQty AS value
	from PurchaseOrders
	where PO#=('&VPurchaseOrder');


column value heading 'Amount Due' format $9,999.99
select 'Amount Due: ', UnitPrice * ShipQty as value
	from PurchaseOrders
	where PO#=('&VPurchaseOrder');

Select 'Order Status: ', status from PurchaseOrders
	where PO#=('&VPurchaseOrder');


spool off

