set echo on
set heading on
set wrap off 
set linesize 120
spool e:setup.txt

drop table Counter;
drop table PurchaseOrders;
drop table Pricelist;
drop table Products;
drop table Suppliers;

create table Suppliers (
S# varchar2(2),
SName varchar2(12),
Address varchar2(24),
City varchar2(11),
State varchar2(2),
Zip varchar2(5),
Phone varchar2(10),
primary key(S#));

insert into Suppliers values ('s1','Staples','297 Brewery Road', 
'Portsmouth', 'VA', '23703','1934720817');
insert into Suppliers values ('s2','Office Depot','86 S. Glen Eagles Street', 
'North Fort', 'FL', 33917,'9974247882');
insert into Suppliers values ('s3','Office Max','1 West Holly Rd.', 
'Ames', 'IA', '50010','5692680512');
insert into Suppliers values ('s4','Amazon','742 Columbia Road', 
'Middleburg', 'FL', '32068','9473737909');
insert into Suppliers values ('s5','Office World','18 Overlook St.', 
'Chillicothe', 'OH', '45601','1886424523');
select * from Suppliers;

create table Products (
P# varchar2(2),
PName varchar2(12),
Inventory number(6),
primary key(P#));

insert into Products values ('p1','Pencil','20');
insert into Products values ('p2','Paper','21');
insert into Products values ('p3','Magic Marker','22');
insert into Products values ('p4','Pen','23');
insert into Products values ('p5','Clipboard','24');
select * from Products;

create table Pricelist (
P# varchar2(2),
S# varchar2(2),
UnitPrice number(6,2),
primary key(P#,S#),
constraint fk_Pricelist_P# foreign key(P#) references Products(P#),
constraint fk_Pricelist_S# foreign key(S#) references Suppliers(S#));

insert into Pricelist values('p1','s1', '2');
insert into Pricelist values('p1','s3', '3');
insert into Pricelist values('p2','s4', '5');
insert into Pricelist values('p3','s2', '1');
insert into Pricelist values('p3','s1', '6');
select * from Pricelist;

create table PurchaseOrders (
PO# number(4),
PODate date,
status varchar2(6),
P# varchar2(2),
S# varchar2(2),
OrderQty number(6),
UnitPrice number(6,2),
OrderAmt number(6,2),
ShipDate date,
ShipQty number(6),
ShipAmt number(6,2),
primary key(PO#),
constraint fk_PurchaseOrders_P# foreign key(P#) references Products(P#),
constraint fk_PurchaseOrders_S# foreign key(S#) references Suppliers(S#));


insert into PurchaseOrders values (995,'02-Jan-2018', 'Closed','p1','s1','11','2', '22','02-Jun-2018','4','8');
insert into PurchaseOrders values (996,'02-Feb-2018', 'Open','p1','s3','15','3', '45','02-Jul-2018','5','15');
insert into PurchaseOrders values (997,'02-Mar-2018', 'Closed','p2','s4','14','5', '70','02-Aug-2018','6','30');
insert into PurchaseOrders values (998,'02-Apr-2018', 'Open','p3','s2','13','1', '13','02-Sep-2018','7','7');
insert into PurchaseOrders values (999,'02-May-2018', 'Open','p3','s1','14','6', '84','02-Oct-2018','8','48'); 
select * from PurchaseOrders;


create table Counter (
Maxnum number(4));

insert into Counter values (1000);

select * from Counter;

spool off

