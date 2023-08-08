drop procedure if exists week5()
delimiter //

create procedure week5()
begin
	declare sql_error int default false;
    declare continue handler for sqlexception
		set sql_error = true;
	
    start transaction;
    
    insert into orders
    values (NULL, "2023-06-01", 1);
    set  @last_id = last_insert_id();
    insert into order_details 
	values (NULL, 1, @last_id, 1);
    
    insert into orders
    values (NULL, "2023-06-02", 1);
    set  @last_id = last_insert_id();
    insert into order_details 
	values (NULL, 1, @last_id, 2);
    insert into order_details 
	values (NULL, 1, @last_id, 11);
    insert into order_details 
	values (NULL, 1, @last_id, 14);
    
    insert into orders
    values (NULL, "2023-06-03", 1);
    set  @last_id = last_insert_id();
    insert into order_details 
	values (NULL, 1, @last_id, 5);
    insert into order_details 
	values (NULL, 1, @last_id, 11);
    insert into order_details 
	values (NULL, 1, @last_id, 13);
    
    insert into orders
    values (NULL, "2023-06-04", 1);
    set  @last_id = last_insert_id();
    insert into order_details 
	values (NULL, 2, @last_id, 5);
    insert into order_details 
	values (NULL, 2, @last_id, 13);

	if sql_error = false then
		commit;
        select 'The transaction was committed.';
	else
		rollback;
        select 'The transaction was rolled back.';
	end if;
end //
delimiter ;

call week5();

select members.member_name, menu_of_coffee.menu_name as sweetness_level, count(order_details.menu_of_coffee_id) as Count
from members join orders using(members_id)
			join order_details using(orders_id)
            join menu_of_coffee using(menu_of_coffee_id)
where menu_of_coffee_id between 12 and 16
group by members.member_name, sweetness_level;
