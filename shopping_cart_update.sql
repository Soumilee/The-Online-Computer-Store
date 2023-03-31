create table shopping_cart (cart_id bigint, product_id int, quantity int, amount int, 
cart_status varchar(20), 
primary key(cart_id,product_id),
foreign key(product_id) references products(product_id));
describe shopping_cart;
create table transactions (
tid bigint,
cust_id int,
cart_id bigint,
card_id int,
tdate date,
tamount bigint,
primary key(tid),
foreign key(cust_id) references customer(cust_id),
foreign key(cart_id) references shopping_cart(cart_id),
foreign key(card_id) references credit_card(card_id)
);
describe transactions;

select * from shopping_cart;
describe customer;
alter table shopping_cart add column cust_id int, add foreign key(cust_id) references customer(cust_id);

select sum(quantity*amount) as total_amount, cart_id from shopping_cart
where cart_id = 1001 and cart_status = 'pending';

insert into shopping_cart values (1001, 100, 2, 500, 'pending', 1);
insert into shopping_cart values (1001, 101, 1, 100, 'pending', 1);

insert into shopping_cart (cart_id, product_id, quantity, cart_status, cust_id, amount)values
(1003, 109, 1, 'pending', 5, 679);

insert into shopping_cart (cart_id, product_id, quantity, cart_status, cust_id, amount)values
(1006, 101, 2, 'pending', 6, 20);

delete from shopping_cart where cart_id = 1001;

Update shopping_cart
set cart_status = 'complete'
where cart_id in (1002,1003,1004,1005);

Delimiter //
create trigger product_update_add
after insert on shopping_cart
for each row
Begin
declare pQuant int;
set pQuant = (Select quantity from products p where p.product_id = new.product_id);
Update products p
set quantity = pQuant-new.quantity
where p.product_id = new.product_id;
End //
Delimiter ;

Delimiter //
create trigger product_update_delete
after delete on shopping_cart
for each row
Begin
declare pQuant int;
set pQuant = (Select quantity from products p where p.product_id = old.product_id);  
Update products p
set quantity = pQuant+old.quantity
where p.product_id = old.product_id;
End //
Delimiter ;

------------- first function

Select 	count(*) as count, 
		product_id, 
		(select product_name from products p where p.product_id = sc.product_id) as product_name 
from shopping_cart sc inner join transactions t on sc.cart_id = t.cart_id
where t.tdate between '2022-04-01' AND '2022-05-02' and sc.cart_status = 'complete' 
group by product_id
having count(*) > 1
order by count(*) desc;

------- second function

Select product_id, count(distinct sc.cust_id) as distinct_customers_sold,
(select product_name from products p where p.product_id = sc.product_id) as product_name
from shopping_cart sc inner join transactions t on sc.cart_id = t.cart_id
where t.tdate between '2022-04-01' AND '2022-05-03' and sc.cart_status = 'complete' 
group by product_id
order by count(distinct sc.cust_id) desc;

--------- third function

Select sum(t.tamount) as total_expense, c.first_name, c.last_name 
from transactions t inner join customer c on t.cust_id = c.cust_id
where t.tdate between '2022-04-01' AND '2022-05-03'
group by t.cust_id
order by sum(t.tamount) desc
limit 10;

--------- fourth fucntion

Select sum(t.tamount) as total_amount_spent, cc.name, cc.billing_address, cc.card_type 
from transactions t inner join credit_card cc on t.card_id = cc.card_id
where t.tdate between '2022-04-01' AND '2022-05-03'
group by t.card_id
order by sum(t.tamount) desc;

--------- fifth function

Select avg(sc.amount) as Avg_Selling_Price, pt.name as Product_type from 
shopping_cart sc inner join products p on sc.product_id = p.product_id
inner join product_type pt on p.product_type = pt.product_type_id
inner join transactions t on sc.cart_id = t.cart_id
where t.tdate between '2022-04-01' AND '2022-05-02' and sc.cart_status = 'complete'
group by pt.name;  