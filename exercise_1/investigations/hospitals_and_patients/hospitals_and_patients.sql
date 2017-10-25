---------------------------------------
--Hospital and Patients
--Shan He
--10/22/2017
---------------------------------------

----------------------------
-- All Procedures
----------------------------
select (avg(avg_compare_score * hcahps_total_score) - avg(avg_compare_score) * avg(hcahps_total_score)) / (stddev(avg_compare_score) * stddev(hcahps_total_score)) correlation
from  (
      select provider_id,
             avg(compare_score) avg_compare_score
      from hospital_compare_score
      group by provider_id
      ) a
inner join
      (
      select provider_number,
             hcahps_base_score + hcahps_consistency_score as hcahps_total_score
      from surveys_responses_t
      ) b
on a.provider_id = b.provider_number
;
-- 0.30

select (avg(stddev_compare_score * hcahps_total_score) - avg(stddev_compare_score)*avg(hcahps_total_score)) / (stddev(stddev_compare_score) * stddev(hcahps_total_score)) correlation
from (
      select provider_id,
      stddev(compare_score) stddev_compare_score
      from hospital_compare_score
      group by provider_id
     ) a
inner join
     (
      select provider_number,
            hcahps_base_score + hcahps_consistency_score as hcahps_total_score
      from surveys_responses_t
      ) b
on a.provider_id = b.provider_number
;
-- -0.23


----------------------------
-- Hospital Care Procedures
----------------------------
select (avg(avg_compare_score * hcahps_total_score) - avg(avg_compare_score) * avg(hcahps_total_score)) / (stddev(avg_compare_score) * stddev(hcahps_total_score)) correlation
from  (
      select provider_id,
             avg(compare_score) avg_compare_score
      from hospital_compare_score
      where source_data = 'hospital care'
      group by provider_id
      ) a
inner join
      (
      select provider_number,
             hcahps_base_score + hcahps_consistency_score as hcahps_total_score
      from surveys_responses_t
      ) b
on a.provider_id = b.provider_number
;
-- 0.24

select (avg(stddev_compare_score * hcahps_total_score) - avg(stddev_compare_score)*avg(hcahps_total_score)) / (stddev(stddev_compare_score) * stddev(hcahps_total_score)) correlation
from (
      select provider_id,
      stddev(compare_score) stddev_compare_score
      from hospital_compare_score
      where source_data = 'hospital care'
      group by provider_id
     ) a
inner join
     (
      select provider_number,
            hcahps_base_score + hcahps_consistency_score as hcahps_total_score
      from surveys_responses_t
      ) b
on a.provider_id = b.provider_number
;
-- -0.14


----------------------------
-- Readmission Procedures
----------------------------
select (avg(avg_compare_score * hcahps_total_score) - avg(avg_compare_score) * avg(hcahps_total_score)) / (stddev(avg_compare_score) * stddev(hcahps_total_score)) correlation
from  (
      select provider_id,
             avg(compare_score) avg_compare_score
      from hospital_compare_score
      where source_data = 'readmission'
      group by provider_id
      ) a
inner join
      (
      select provider_number,
             hcahps_base_score + hcahps_consistency_score as hcahps_total_score
      from surveys_responses_t
      ) b
on a.provider_id = b.provider_number
;
-- 0.23

select (avg(stddev_compare_score * hcahps_total_score) - avg(stddev_compare_score)*avg(hcahps_total_score)) / (stddev(stddev_compare_score) * stddev(hcahps_total_score)) correlation
from (
      select provider_id,
      stddev(compare_score) stddev_compare_score
      from hospital_compare_score
      where source_data = 'readmission'
      group by provider_id
     ) a
inner join
     (
      select provider_number,
            hcahps_base_score + hcahps_consistency_score as hcahps_total_score
      from surveys_responses_t
      ) b
on a.provider_id = b.provider_number
;
-- -0.29
