alter table shipping_address modify column street_name varchar(50); 
insert into shipping_address values (1,'home','USA','NJ','jersey','St pauls ave','07306'); 
insert into shipping_address values (2,'home','USA','NJ','newark','St Michaels ave','07306');
insert into shipping_address values (3,'home','USA','NJ','jersey','St pauls ave','07306'); 
insert into shipping_address values (4,'home','USA','MA','boston','Ridegwood St','07345'); 
insert into shipping_address values (5,'home','USA','MA','boston','Rampo St','07345'); 
insert into shipping_address values (6,'home','USA','NJ','kearny','Vermella Crossing','07310'); 
insert into shipping_address values (7,'home','USA','NJ','kearny','Vermella Crossing','07310'); 
insert into shipping_address values (8,'home','USA','NJ','kearny','Vermella Crossing','07310'); 
insert into shipping_address values (9,'home','USA','NJ','kearny','Vermella Crossing','07310'); 
insert into shipping_address values (10,'home','USA','MA','boston','Yorkshire St','07350'); 
select* from shipping_address; 