select * from people;
select 
	first_name,
    last_name,
    team,
    quiz_points,
    shirt_or_hat prize
from people
order by shirt_or_hat, team;