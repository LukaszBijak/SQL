
-- Assignment 4: Practice working with data
SELECT * FROM master_sql.people
where first_name = 'Bonnie' and last_name = 'Brooks' ;

insert into people (first_name, last_name, quiz_points, team, city, state_code, shirt_or_hat)
	values 
    ('Walter', 'St. John', 93, 'Baffled Badgers', 'Buffalo', 'NY', 'hat'),
    ('Emerald', 'Chou', 92, 'Angry Ants', 'Topeka', 'KS', 'shirt');
update people 
	set shirt_or_hat='shirt'
	where first_name = 'Bonnie' and last_name = 'Brooks';
    
select * from people
where quiz_points = (select max(quiz_points) from people);

select max(quiz_points)  from people;
    


	