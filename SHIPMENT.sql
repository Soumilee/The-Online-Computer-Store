alter table shipment modify column s_status nvarchar(20);
insert into shipment values (005,'IN TRANSIT');
insert into shipment values (001, 'DISPATCHED');
INSERT INTO SHIPMENT values (010, 'REACHED LOCATION');
insert INTO shipment values (002,'IN WAREHOUSE');
SELECT * FROM SHIPMENT; 
