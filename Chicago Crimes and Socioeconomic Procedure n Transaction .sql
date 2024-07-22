##Create a procedure then write a SQL IF statement to update the Leaders_Icon field in the CHICAGO_PUBLIC_SCHOOLS table
##for the school identified by in_School_ID using the following information.
#Score lower limit 	Score upper limit 	Icon
#		80 					99 			Very strong
#		60 					79 			Strong
#		40 					59 			Average
#		20 					39 			Weak
#		0 					19 			Very weak
##Then use Transasction that rolls back the current work if the score did not fit any of the preceding categories.

delimiter // 

create procedure upd_leaders (in in_School_ID int, in in_leaders_score int)
begin
	declare score int;
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
    END;
    start transaction;
    select leaders_score into score from chicago_public_schools where school_id = in_School_ID;
    
    if in_leaders_score < 20 then
		update chicago_public_schools
        set leaders_icon = 'Very weak'
        where school_id = in_School_ID;
    elseif in_leaders_score < 40 then
		update chicago_public_schools
		set leaders_icon = 'Weak'
        where school_id = in_School_ID;
    elseif in_leaders_score < 60 then
		update chicago_public_schools
		set leaders_icon = 'Average'
        where school_id = in_School_ID;
    elseif in_leaders_score < 80 then
		update chicago_public_schools
		set leaders_icon = 'Strong'
        where school_id = in_School_ID;
    elseif in_leaders_score < 100 then
		update chicago_public_schools
		set leaders_icon = 'Very Strong'
        where school_id = in_School_ID;
    end if;
    commit;
end //
delimiter ;