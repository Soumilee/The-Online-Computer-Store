create table product_type (product_type_id int not null primary key, name varchar(20));
insert into product_type values (1,'Desktop');
insert into product_type values (2,'Laptops');
insert into product_type values (3,'Accessories');
insert into product_type values (4,'Printers');
select * from product_type;
alter table product_type add unique(name);
