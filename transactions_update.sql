Delimiter //
create trigger transactions_insert
after update on shopping_cart
for each row
Begin
Declare total_amount int;
Declare card_id_value int ;
declare action_value varchar(5);
set total_amount = (select sum(quantity*amount) as total_amount from shopping_cart where cart_id = new.cart_id and new.cart_status = 'complete');
set card_id_value = (select card_id from has_card where cust_id = new.cust_id );
set action_value = (select max(tid) from transactions where cart_id = new.cart_id);
IF (action_value is NULL)
	THEN
		Insert into transactions (cust_id, cart_id, card_id, tdate, tamount) values (new.cust_id, new.cart_id,card_id_value, curdate(), total_amount);
ELSEIF (action_value is not NULL)
	THEN	
		Update transactions t
        set t.tdate = curdate(), t.tamount = total_amount where t.cart_id = new.cart_id;
End IF;
End //
Delimiter ;