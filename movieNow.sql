

select c.country,
  m.year_of_release,
  count(*) as n_rentals,
  count(distinct r.movie_id) as n_movies,
  avg(rating) as avg_rating
  from
renting r
left join customer c
on c.customer_id = r.customer_id
left join
movies as m
on m.movie_id = r.movie_id

where r.movie_id in (
select movie_id
  from renting
  group by movie_id
  having count(rating) >=4
  
)
and r.date_renting >='2018-04-01'
group by rollup(m.year_of_release, c.country)
order by c.country, m.year_of_release;

