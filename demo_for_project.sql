select * from shopping_cart;
insert into shopping_cart (cart_id, product_id, quantity, cart_status, cust_id, amount)values
(1006, 110, 1, 'pending', 12, 1289);
insert into shopping_cart (cart_id, product_id, quantity, cart_status, cust_id, amount)values
(1007, 111, 1, 'pending', 13, 2699);
insert into shopping_cart (cart_id, product_id, quantity, cart_status, cust_id, amount)values
(1008, 112, 1, 'pending', 14, 1349);
insert into shopping_cart (cart_id, product_id, quantity, cart_status, cust_id, amount)values
(1010, 108, 3, 'pending', 15, 200);
insert into shopping_cart (cart_id, product_id, quantity, cart_status, cust_id, amount)values
(1006, 118, 1, 'pending', 12, 3490);
insert into shopping_cart (cart_id, product_id, quantity, cart_status, cust_id, amount)values
(1007, 121, 1, 'pending', 13, 998);
Update shopping_cart
set cart_status = 'complete'
where cart_id in (1008,1006,1007,1010);

