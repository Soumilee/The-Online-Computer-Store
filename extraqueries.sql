
#insertion qurey into databse
insert into final_project.customer (`fname`,`lname`,`email`,`address`,`phone`) 
value ('chirag','contractor','ch@gmail.com','310 liberty st',1234567891);

insert into final_project.customer (`fname`,`lname`,`email`,`address`,`phone`) 
value ('jugal','parmar','jp@gmail.com','310 liberty st',1234512345);

#enter credit card details
insert into creditcard (`ccnumber`,`secnumber`,`ownername`,`cctype`,`billaddress`,`expdate`,`storedcardid`)
values (1234567891232345,333,'chirag','business','310 liberty st','2023-05-19',5);

#insert shipping address
insert into shipping_address(`cid`,`saname`,`recepientname`,`street`,`snumber`,`city`,`zipcode`,`state`,`country`)
values (5,'c1','chirag','Boston','620','BS','67611','NY','US');

#---------------------------------------
#update credit details
update creditcard 
set billaddress = '320 liberty st'
where ccnumber = 1111222233334444;

#update shipping_address
update shipping_address
set street = 'Main st', snumber = '700',city = 'harrison'
where cid = 1 and saname = 's1';

#update ttag when cargo get lost
update transaction
set ttag = 'Lost'
where bid = 8 and ccnumber = 1111222233335555 and cid = 2 and saname = 's1'; 

#updating status of customer.
UPDATE final_project.customer 
SET status= 'Platinum' 
WHERE cid = 3;

#---------------------------------------
#delete credit card 
delete from creditcard where ccnumber = 1234567891232345;
delete from shipping_address where cid = 3 and saname = 'j1';

#remove customer record
delete from customer where cid = 1;





#---------------------------------------
#insert data into silver_above
insert into final_project.silver_and_above (`cid`,`creditline`)
values (1,0);
insert into final_project.silver_and_above (`cid`,`creditline`)
values (5,0);


#insert product
insert into product(`ptype`,`pname`,`pprice`,`pqunatity`,`description`)
values ('hardware','laptop','300','1350','chkhdebevcdjhehb');

insert into computer(`pid`,`cputype`)
values (4,'multi-core');

insert into printer(`pid`,`printertype`,`resolution`)
values (5,'DMP','400*400');

insert into laptop(`pid`,`btype`,`weight`)
values (6,'windows','6');

#creating basket
insert into basket(`cid`)
values (5);

#transaction
insert into transaction(`bid`,`ccnumber`,`cid`,`saname`,`tdate`)
values (10,1111222233337777,3,'j1','2022-04-27');

#appears_in
insert into appears_in(`bid`,`pid`,`quantity`,`pricesold`)
values (11,1,1,800);

#offer product
insert into offer_product(`pid`,`offerprice`)
values (5,120);




#---------------------------------------------------------------------------------
#check all info. of all transaction for user with cid = 1
select * from transaction where cid = 1 ;

#check status of particular product
select ttag from transaction where bid = '6' and cid = 1 and tdate = '2022-04-29';


#check the detalis of all transaction between particular dates.
select * from transaction where tdate between '2022-04-27' and '2022-04-28';

#check the detalis of all transaction for particular dates.
SELECT *
FROM transaction T, customer C, appears_in A
WHERE T.CID = C.CID
and t.bid = a.bid
AND C.FNAME = 'chirag'
AND C.LNAME = 'contractor'
AND T.TDATE BETWEEN '2022-04-27' AND '2022-04-30';
#AND A.PID = ‘p1’

#For a given time period (begin date and end date) compute the most frequently sold products.
select pid,pname
from product
where pid In (select pid
			  from appears_in
              group by pid
			  having max(quantity) In ( select bid 
										from transaction 
										where tdate between '2022-04-27' and '2022-04-30'));

SELECT A.PID, SUM(quantity) AS count
FROM TRANSACTION T, APPEARS_IN A
WHERE T.BID = A.BID
AND TDATE BETWEEN '2022-04-27' AND '2022-04-30'
GROUP BY A.PID;

#For a given time period (begin date and end date) compute the products which are sold to the highest number of distinct customers.
SELECT PID, COUNT(DISTINCT CID) AS 'distict customers'
FROM TRANSACTION T, APPEARS_IN A
WHERE T.BID = A.BID
AND TDATE BETWEEN '2022-04-27' AND '2022-04-30'
GROUP BY PID;


SELECT CID, SUM(A.PRICESOLD) AS MONEY_SPENT
FROM TRANSACTION T, APPEARS_IN A
WHERE T.BID = A.BID
AND TDATE BETWEEN '2022-04-27' AND '2022-04-30'
GROUP BY CID
ORDER BY MONEY_SPENT DESC;

#For a given time period (begin date and end date) compute the maximum basket total amount per credit card.
SELECT CCNUMBER, SUM(A.PRICESOLD)
FROM TRANSACTION T, APPEARS_IN A
WHERE T.BID = A.BID
AND TDATE BETWEEN '2022-04-27' AND '2022-04-30'
GROUP BY CCNUMBER;

#For a given time period (begin date and end date) compute the average selling product price per product type for desktops, laptops and printers.
SELECT AVG(A.PRICESOLD) AS DESKTOP_AVG_PRICE
FROM TRANSACTION T, APPEARS_IN A
WHERE T.BID = A.BID
AND TDATE BETWEEN '2022-04-27' AND '2022-04-30'
AND PID IN ( SELECT PID FROM COMPUTER);

SELECT AVG(A.PRICESOLD)  AS PRINTER_AVG_PRICE
FROM TRANSACTION T, APPEARS_IN A
WHERE T.BID = A.BID
AND TDATE BETWEEN '2022-04-27' AND '2022-04-30'
AND PID IN ( SELECT PID FROM PRINTER);


SELECT AVG(A.PRICESOLD)  AS LAPTOP_AVG_PRICE
FROM TRANSACTION T, APPEARS_IN A
WHERE T.BID = A.BID
AND TDATE BETWEEN '2022-04-27' AND '2022-04-30'
AND PID IN ( SELECT PID FROM LAPTOP);

#---------------------------------------------------------------------------------
#extra
alter table appears_in drop constraint appears_in_ibfk_2;

ALTER TABLE appears_in
add CONSTRAINT appears_in_ibfk_2 FOREIGN KEY(`pid`) REFERENCES product(`pid`) ON DELETE CASCADE ON UPDATE CASCADE; 
