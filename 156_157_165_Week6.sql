use mydb;

drop trigger if exists update_Total_credit;
delimiter //
create trigger update_Total_credit
after insert on register_details for each row
begin
	declare total int;
    select sum(credit) into total from courses
    join section using (course_id)
    join register_details using (section_id) 
    where registers_id = new.registers_id;
    
    update registers set credit_total = total
    where registers_id = new.registers_id;
end //
delimiter ;

show triggers;
insert into register_details value (NULL, 1, 5);
