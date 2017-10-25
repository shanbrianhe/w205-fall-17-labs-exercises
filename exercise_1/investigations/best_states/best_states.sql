---------------------------------------
--Best States
--Shan He
--10/22/2017
---------------------------------------

select b.state,
       c.state as state_name,
       count(a.provider_id) num_of_hospital,
       count(distinct a.measure_id) num_of_measure,
       round(avg(a.compare_score),3) avg_compare_score
from hospital_compare_score a
left join hospitals_t b
on a.provider_id = b.provider_id
left join states c
on b.state = c.state_abbrev
group by b.state, c.state
order by avg_compare_score desc
limit 10
;

-- +-----+-------------+---------------+--------------+-----------------+
-- |state|state_name   |num_of_hospital|num_of_measure|avg_compare_score|
-- +-----+-------------+---------------+--------------+-----------------+
-- |UT   |Utah         |1021           |41            |6.071            |
-- |WI   |Wisconsin    |3167           |41            |6.012            |
-- |CO   |Colorado     |1739           |41            |6.006            |
-- |ME   |Maine        |932            |41            |5.965            |
-- |SD   |South Dakota |659            |41            |5.933            |
-- |ID   |Idaho        |615            |41            |5.846            |
-- |NH   |New Hampshire|701            |41            |5.836            |
-- |MN   |Minnesota    |2468           |41            |5.825            |
-- |MT   |Montana      |690            |41            |5.819            |
-- |NE   |Nebraska     |1178           |41            |5.807            |
-- +-----+-------------+---------------+--------------+-----------------+
