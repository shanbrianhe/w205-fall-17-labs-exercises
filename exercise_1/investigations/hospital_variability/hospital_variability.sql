---------------------------------------
--Hospital Variability
--Shan He
--10/22/2017
---------------------------------------

select a.measure_id,
       b.measure_name,
       count(distinct provider_id) num_of_measure,
       round(stddev(score),3) standard_deviation,
       round(avg(score),3) average_score,
       round(stddev(score)/avg(score),3) std_to_mean_ratio
from tmp_measure_score a
left join measures_t b
on a.measure_id = b.measure_id
group by a.measure_id, b.measure_name
order by std_to_mean_ratio desc
limit 10
;

-- +------------+--------------------------------------------------------------------------------+--------------+------------------+-------------+-----------------+
-- |measure_id  |measure_name                                                                    |num_of_measure|standard_deviation|average_score|std_to_mean_ratio|
-- +------------+--------------------------------------------------------------------------------+--------------+------------------+-------------+-----------------+
-- |PC_01       |Elective Delivery                                                               |2520          |6.958             |4.233        |1.644            |
-- |VTE_6       |Hospital Acquired Potentially-Preventable Venous Thromboembolism                |1388          |8.062             |6.347        |1.27             |
-- |OP_22       |Patient left without being seen                                                 |3206          |1.717             |1.7          |1.01             |
-- |OP_5        |Median Time to ECG                                                              |2099          |6.109             |8.333        |0.733            |
-- |ED_2B       |Admit Decision Time to ED Departure Time for Admitted Patients                  |3496          |62.167            |98.519       |0.631            |
-- |OP_20       |Median Time from ED Arrival to Provider Contact for ED patients                 |3354          |16.882            |28.082       |0.601            |
-- |ED_1B       |Median Time from ED Arrival to ED Departure for Admitted ED Patients            |3516          |92.832            |271.607      |0.342            |
-- |OP_21       |Median Time to Pain Management for Long Bone Fracture                           |3172          |17.722            |55.357       |0.32             |
-- |OP_18B      |Median Time from ED Arrival to ED Departure for Discharged ED Patients          |3340          |40.722            |142.799      |0.285            |
-- |MORT_30_CABG|30-Day All-Cause Mortality Following Coronary Artery Bypass Graft (CABG) Surgery|1061          |0.841             |3.315        |0.254            |
-- +------------+--------------------------------------------------------------------------------+--------------+------------------+-------------+-----------------+
