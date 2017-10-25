---------------------------------------
--Transform Tables for Hospital Compare
--Shan He
--10/15/2017
---------------------------------------

----------------------------
-- Transform hospitals
----------------------------

-- a. Access Data Quality

-- check null values
SELECT *
FROM hospitals
WHERE provider_id IS NULL
      OR hospital_name IS NULL
      OR state IS NULL
      OR hospital_type IS NULL
      OR hospital_ownership IS NULL
;
-- 0 rows

-- check uniqueness of provider_id
SELECT provider_id, count(*)
FROM hospitals
GROUP BY provider_id
HAVING COUNT(*) <> 1
;
-- 0 rows, good

-- check inclusiveness of provider_id
SELECT a.provider_id, b.provider_id, a.table
FROM
(
    SELECT regexp_replace(provider_id, '^0+', '') provider_id, 'effective_care' table FROM effective_care
    UNION
    SELECT regexp_replace(provider_id, '^0+', '') provider_id, 'readmissions' table FROM readmissions
    UNION
    SELECT regexp_replace(provider_number, '^0+', '') provider_number, 'surveys_responses' table FROM surveys_responses
) a
LEFT JOIN
hospitals b
ON upper(a.provider_id) = upper(regexp_replace(b.provider_id, '^0+', ''))
WHERE b.provider_id is NULL
;
-- an important issure here: in some tables 12345 is loaded as 12345 while in some other files, it becomes 012345. Solved by removing leading zeros
-- 330249  NULL    surveys_responses. needs to added into transformed hospitals. But since this hospital doesn't have data on effective_care or readmission, it's not very important.

-- check whether states make sense
SELECT DISTINCT h.state, s.state
FROM hospitals h
LEFT JOIN states s
on h.state = s.state_abbrev
WHERE s.state is NULL
;
-- 0 rows, all good

-- check distinct categorical values
SELECT DISTINCT hospital_type FROM hospitals;
-- minor issue: 'ACUTE CARE - VETERANS ADMINISTRATION' is all cap

SELECT DISTINCT hospital_ownership FROM hospitals;
-- all good

-- b. Create Transformed Table

DROP TABLE hospitals_t;

CREATE TABLE hospitals_t AS
SELECT upper(regexp_replace(provider_id, '^0+', '')) provider_id, --standardize letter case, remove leading zeros
       hospital_name,
       state,
       initcap(lower(hospital_type)) as hospital_type, -- standardize letter case
       hospital_ownership
FROM hospitals
UNION
SELECT upper(regexp_replace(provider_number, '^0+', '')),
       hospital_name,
       state,
       'NA' hospital_type,
       'NA' hospital_ownership
FROM surveys_responses
WHERE upper(regexp_replace(provider_number, '^0+', '')) = '330249'
;

---------------------------------
-- Transform effective_care Table
---------------------------------

-- a. Access Data Quality
SELECT *
FROM effective_care
WHERE provider_id IS NULL
      OR condition IS NULL
      OR measure_id IS NULL
      OR score IS NULL
      OR sample IS NULL
      OR footnote IS NULL
;
-- 0 rows

-- check distinct categorical values
SELECT DISTINCT condition FROM effective_care
;

SELECT score, count(*) FROM effective_care
WHERE score not rlike '^[0-9]+$'
GROUP BY score
;
--Not Available                                 96693
--High (40,000 - 59,999 patients annually)      586
--Medium (20,000 - 39,999 patients annually)    982
--Very High (60,000+ patients annually)         585
--Low (0 - 19,999 patients annually)            1058

SELECT DISTINCT measure_id, score FROM effective_care
WHERE score not rlike '^[0-9]+$' and score <> "Not Available"
;

--EDV     High (40,000 - 59,999 patients annually)
--EDV     Medium (20,000 - 39,999 patients annually)
--EDV     Very High (60,000+ patients annually)
--EDV     Low (0 - 19,999 patients annually)

-- Although there are many records, NA's won't be useful in comparison and hence are ignored
-- For measure EDV, there aren't many reconrd. And since we care more about how different hospitals compare within this measure, we assign 0 to Low, 1 to Medium, 2 to High, and 3 to Very High

-- b. Create Transformed Table
DROP TABLE effective_care_t;

CREATE TABLE effective_care_t AS
SELECT upper(regexp_replace(provider_id, '^0+', '')) provider_id, --standardize letter case, remove leading zeros
       condition,
       upper(measure_id) measure_id, --standardize letter case
       CASE when substring(score, 1, 1) = 'L' then 0
            when substring(score ,1 ,1) = 'M' then 1
            when substring(score ,1 ,1) = 'H' then 2
            when substring(score ,1 ,1) = 'V' then 3
            else cast(score as int)
       END as score,
       sample,
       footnote
FROM effective_care
WHERE score <> 'Not Available' -- exclude NA's
;

---------------------------------
-- Transform readmissions Table
---------------------------------

-- a. Access Data Quality
SELECT *
FROM readmissions
WHERE provider_id IS NULL
      OR measure_id IS NULL
      OR compared_to_national IS NULL
      OR denominator IS NULL
      OR score IS NULL
      OR lower_estimate IS NULL
      OR higher_estimate IS NULL
;
-- 0 rows

SELECT score, count(*) FROM readmissions
WHERE score not rlike '[0-9]+'
GROUP BY score
;
-- Not Available      23847
-- like in the effective_care table, NA's won't be helpful for comparison and hence are ignored


-- b. Create Transformed Table
DROP TABLE readmissions_t;

CREATE TABLE readmissions_t AS
SELECT upper(regexp_replace(provider_id, '^0+', '')) provider_id, --standardize letter case, remove leading zeros
       upper(measure_id) measure_id, --standardize letter case
       compared_to_national,
       denominator,
       cast(score as int) score,
       lower_estimate,
       higher_estimate
FROM readmissions
WHERE score <> 'Not Available' -- exclude NA's
;

---------------------------------
-- Transform measures Table
---------------------------------

-- a. Access Data Quality
SELECT *
FROM measures
WHERE measure_id IS NULL
      OR measure_name IS NULL
      OR measure_start_date IS NULL
      OR measure_end_date IS NULL
;
-- 0 rows

-- check uniqueness of measure_id
SELECT measure_id, count(*)
FROM measures
GROUP BY measure_id
HAVING COUNT(*) <> 1
;
-- 0 rows, good

--check inclusiveness of measure_id

SELECT a.measure_id, b.measure_id
FROM
(
    SELECT measure_id FROM effective_care
    UNION
    SELECT measure_id FROM readmissions
) a
LEFT JOIN
measures b
ON upper(a.measure_id) = upper(b.measure_id)
WHERE b.measure_id is NULL
;
-- IMM_3_FAC_ADHPCT        NULL

--check effective_care table for this missing measure_id

SELECT distinct measure_id, measure_name, measure_start_date, measure_end_date from effective_care
WHERE upper(measure_id) = 'IMM_3_FAC_ADHPCT'
;
-- IMM_3_FAC_ADHPCT        Healthcare workers given influenza vaccination  10/1/13 3/31/14

-- b. Create Transformed Table
DROP TABLE measures_t;

CREATE TABLE measures_t AS
SELECT upper(measure_id) measure_id, --standardize letter case
       measure_name,
       measure_start_date,
       measure_end_date
FROM measures
UNION
SELECT DISTINCT
        measure_id,
        measure_name,
        measure_start_date,
        measure_end_date
FROM effective_care
WHERE upper(measure_id) = 'IMM_3_FAC_ADHPCT'
;


---------------------------------
-- Transform surveys_responses Table
---------------------------------

-- a. Access Data Quality
SELECT *
FROM surveys_responses_t
WHERE provider_number IS NULL
      OR overall_rating_of_hospital_achiev_pts IS NULL
      OR overall_rating_of_hospital_improve_pts IS NULL
      OR overall_rating_of_hospital_dim_score IS NULL
      OR hcahps_base_score IS NULL
      OR hcahps_consistency_score IS NULL
;

-- check NA's
SELECT DISTINCT overall_rating_of_hospital_achiev_pts
FROM surveys_responses
where overall_rating_of_hospital_achiev_pts not rlike '[0-9]+'
;
-- Not Available

-- check to see whether all NA's are in the same rows
SELECT DISTINCT
            (CASE WHEN overall_rating_of_hospital_achiev_pts = 'Not Available' THEN 1 ELSE 0 END)
            +
            (CASE WHEN overall_rating_of_hospital_improve_pts = 'Not Available' THEN 1 ELSE 0 END)
            +
            (CASE WHEN overall_rating_of_hospital_dim_score = 'Not Available' THEN 1 ELSE 0 END)
            +
            (CASE WHEN hcahps_base_score = 'Not Available' THEN 1 ELSE 0 END)
            +
            (CASE WHEN hcahps_consistency_score = 'Not Available' THEN 1 ELSE 0 END)
FROM surveys_responses
;
-- 0
-- 1
-- 5
-- means than there is one case when there is only one NA

SELECT  overall_rating_of_hospital_achiev_pts,
        overall_rating_of_hospital_improve_pts,
        overall_rating_of_hospital_dim_score,
        hcahps_base_score,
        hcahps_consistency_score
FROM surveys_responses
WHERE (CASE WHEN overall_rating_of_hospital_achiev_pts = 'Not Available' THEN 1 ELSE 0 END)
      +
      (CASE WHEN overall_rating_of_hospital_improve_pts = 'Not Available' THEN 1 ELSE 0 END)
      +
      (CASE WHEN overall_rating_of_hospital_dim_score = 'Not Available' THEN 1 ELSE 0 END)
      +
      (CASE WHEN hcahps_base_score = 'Not Available' THEN 1 ELSE 0 END)
      +
      (CASE WHEN hcahps_consistency_score = 'Not Available' THEN 1 ELSE 0 END)
= 1
;
-- all in hospital_improve_pts, will be treated as null
-- after looking at https://www.medicare.gov/hospitalcompare/Data/hospital-vbp.html, it seems that overall_rating_of_hospital_dim_score = max(overall_rating_of_hospital_achiev_pts, overall_rating_of_hospital_improve_pts)

-- b. Create Transformed Table
DROP TABLE surveys_responses_t;

CREATE TABLE surveys_responses_t AS
SELECT upper(regexp_replace(provider_number, '^0+', '')) provider_number,  --standardize letter case, remove leading zeros
       cast(regexp_replace(overall_rating_of_hospital_achiev_pts, ' .+$','') as int) overall_rating_of_hospital_achiev_pts,
       cast( case when overall_rating_of_hospital_improve_pts = 'Not Available' then ''
                  else regexp_replace(overall_rating_of_hospital_improve_pts, ' .+$','') end as int
           ) overall_rating_of_hospital_improve_pts,
       cast(regexp_replace(overall_rating_of_hospital_dim_score, ' .+$','') as int) overall_rating_of_hospital_dim_score,
       cast(hcahps_base_score as int) hcahps_base_score,
       cast(hcahps_consistency_score as int) hcahps_consistency_score
FROM surveys_responses
WHERE overall_rating_of_hospital_achiev_pts <> 'Not Available'
;

---------------------------------
-- Quality Check
---------------------------------

-- check uniformity of keys primaty_id/num
SELECT a.provider_id, b.provider_id, a.table
FROM
(
    SELECT provider_id, 'effective_care' table FROM effective_care_t
    UNION
    SELECT provider_id, 'readmissions' table FROM readmissions_t
    UNION
    SELECT provider_number, 'surveys_responses' table FROM surveys_responses_t
) a
LEFT JOIN
hospitals_t b
ON upper(a.provider_id) = upper(b.provider_id)
WHERE b.provider_id is NULL
;
