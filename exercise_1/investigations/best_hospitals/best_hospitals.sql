---------------------------------------
--Best Hospitals
--Shan He
--10/22/2017
---------------------------------------

-----------------------------------------------
-- Evaluate scope of measures
-----------------------------------------------
-- 1. effective_care_t

-- checking metadata in effective_care_t
select footnote,
       count(*)
from effective_care_t
group by footnote
;

-- 2 - Data submitted were based on a sample of cases/patients., 3 - Results are based on a shorter time period than required.    2948
-- 1 - The number of cases/patients is too few to report., 2 - Data submitted were based on a sample of cases/patients., 3 - Results are based on a shorter time period than required.  1
-- 1 - The number of cases/patients is too few to report., 2 - Data submitted were based on a sample of cases/patients.9
-- 3 - Results are based on a shorter time period than required.  5716
-- 2 - Data submitted were based on a sample of cases/patients. 44709
-- 1 - The number of cases/patients is too few to report. 29
--    67705
-- 11 - There were discrepancies in the data collection process.    9
--  The number of cases/patients is too few to report., 3 - Results are based on a shorter time period than required    2

-- we should exclude 11. after spot-checking, all the other issues are assumed to be minor issues. (a tradeoff to ensure sample size)

-- check measure_id and number of measurements
select a.measure_id,
       b.measure_name,
       max(score), -- check to see whether it's a measure of % rate or an amount/level
       count(*) count
from effective_care_t a
left join measures_t b
on a.measure_id = b.measure_id
where a.footnote <> "11 - There were discrepancies in the data collection process."
group by a.measure_id, b.measure_name
order by count desc
;
-- PN_6    Initial Antibiotic Selection for CAP in Immunocompetent Patient 100     3973
-- HF_2	Evaluation of LVS Function	100	3781
-- IMM_2	Influenza Immunization	100	3739
-- IMM_3_FAC_ADHPCT	Healthcare workers given influenza vaccination	100	3657
-- VTE_1	Venous Thromboembolism Prophylaxis	100	3534
-- SCIP_VTE_2	Surgery Patients Who Received Appropriate Venous Thromboembolism Prophylaxis Within 24 Hours Prior to Surgery to 24 Hours After Surgery	100	3519
-- ED_1B	Median Time from ED Arrival to ED Departure for Admitted ED Patients	1180	3516
-- ED_2B	Admit Decision Time to ED Departure Time for Admitted Patients	1132	3496
-- SCIP_INF_1	Prophylactic Antibiotic Received Within 1 Hour Prior to Surgical Incision	100	3476
-- SCIP_INF_2	Prophylactic Antibiotic Selection for Surgical Patients	100	3467
-- SCIP_INF_3	Prophylactic Antibiotics Discontinued Within 24 hours After Surgery End Time	100	3457
-- OP_20	Median Time from ED Arrival to Provider Contact for ED patients	143	3354
-- OP_18B	Median Time from ED Arrival to ED Departure for Discharged ED Patients	443	3340
-- SCIP_INF_9	Urinary  Catheter Removed on Postoperative Day 1 (POD 1) or Postoperative Day 2 (POD 2) with Day of Surgery being Day Zero	103329
-- SCIP_INF_10	Surgery Patients with Perioperative Temperature Management	100	3259
-- EDV	Emergency Department Volume	3	3211
-- OP_22	Patient left without being seen	22	3206
-- OP_21	Median Time to Pain Management for Long Bone Fracture	182	3172
-- SCIP_CARD_2	Surgery Patients on Beta-Blocker Therapy Prior to Arrival Who Received a Beta-Blocker During the Perioperative Period	100	3149
-- VTE_2	Intensive Care Unit Venous Thromboembolism Prophylaxis	100	2955
-- HF_1	Discharge Instructions	100	2934
-- OP_7	Prophylactic Antibiotic Selection for Surgical Patients	100	2914
-- OP_6	Timing of Antibiotic Prophylaxis	100	2909
-- STK_1	Venous Thromboembolism (VTE) Prophylaxis	100	2710
-- STK_10	Assessed for Rehabilitation	100	2702
-- HF_3	ACEI or ARB for LVSD	100	2692
-- STK_5	Antithrombotic Therapy By End of Hospital Day 2	100	2675
-- STK_2	Discharged on Antithrombotic Therapy	100	2673
-- VTE_3	Venous Thromboembolism Patients with Anticoagulation Overlap Therapy	100	2666
-- STK_6	Discharged on Statin Medication	100	2582
-- PC_01	Elective Delivery	100	2520
-- VTE_5	Venous Thromboembolism Warfarin Therapy Discharge Instructions	100	2468
-- STK_8	Stroke Education	100	2372
-- AMI_2	Aspirin Prescribed at Discharge	100	2207
-- AMI_10	Statin Prescribed at Discharge	100	2188
-- OP_5	Median Time to ECG	142	2099
-- OP_4	Aspirin at Arrival	100	2087
-- VTE_4	Venous Thromboembolism Patients Receiving Unfractionated Heparin with Dosages/Platelet Count Monitoring by Protocol or Nomogram	100	2045
-- AMI_8A	Primary PCI Received Within 90 Minutes of Hospital Arrival	100	1528
-- STK_3	Anticoagulation Therapy for Atrial Fibrillation/Flutter	100	1499
-- VTE_6	Hospital Acquired Potentially-Preventable Venous Thromboembolism	71	1388
-- OP_23	Head CT Scan Results for Acute Ischemic Stroke or Hemorrhagic Stroke Patients who Received Head CT or MRI Scan Interpretation Within 45 Minutes of ED Arrival	100	959
-- STK_4	Thrombolytic Therapy	100	874
-- OP_3B	Median Time to Transfer to Another Facility for Acute Coronary Intervention- Reporting Rate	221	409
-- CAC_1	Relievers for Inpatient Asthma	100	97
-- CAC_2	Systemic Corticosteroids for Inpatient Asthma	100	97
-- CAC_3	Home Management Plan of Care (HMPC) Document Given to Patient/Caregiver	100	96
-- OP_2	Fibrinolytic Therapy Received Within 30 Minutes of ED Arrival	100	68
-- OP_1	Median Time to Fibrinolysis	64	68
-- AMI_7A	Fibrinolytic Therapy Received within 30 Minutes of Hospital Arrival	73	3


-- 2. readmissions_t

-- check measure_id and number of measurements
select a.measure_id,
       b.measure_name,
       max(score), -- check to see whether it's a measure of % rate or an amount/level
       count(*) count
from readmissions_t a
left join measures_t b
on a.measure_id = b.measure_id
group by a.measure_id, b.measure_name
order by count desc
;
-- READM_30_HOSP_WIDE      30-Day Hospital-Wide All-Cause Unplanned Readmission Rate	20	4466
-- READM_30_PN	Pneumonia 30-Day Readmission Rate	22	4227
-- MORT_30_PN	Pneumonia 30-Day Mortality Rate	20	4212
-- READM_30_HF	Heart  Failure (HF) 30-Day Readmission Rate	32	3887
-- MORT_30_HF	Heart Failure (HF) 30-Day Mortality Rate	19	3800
-- READM_30_COPD	Chronic Obstructive Pulmonary Disease (COPD) 30-Day Readmission Rate	27	3723
-- MORT_30_COPD	Chronic Obstructive Pulmonary Disease (COPD) 30-Day Mortality Rate	14	3644
-- READM_30_HIP_KNEE	30-Day Readmission Rate Following Elective Primary Total Hip Arthroplasty (THA) and/or Total Knee Arthroplasty (TKA)	9	2779
-- MORT_30_STK	Acute Ischemic Stroke (STK) 30-Day Mortality Rate	22	2761
-- READM_30_STK	Stroke (STK) 30-Day Readmission Rate	18	2723
-- MORT_30_AMI	Acute Myocardial Infarction (AMI) 30-Day Mortality Rate	21	2506
-- READM_30_AMI	Acute Myocardial Infarction (AMI) 30-Day Readmission Rate	21	2302
-- MORT_30_CABG	30-Day All-Cause Mortality Following Coronary Artery Bypass Graft (CABG) Surgery	9	1061
-- READM_30_CABG	30-Day All-Cause Unplanned Readmission Following Coronary Artery Bypass Graft Surgery (CABG)	21	1052


------------------------------------------- Comment -------------------------------------------------
-- we see that 1) there are a few of procedures that have fewer than 1000 hospitals measured.
-- (Assumption) In order to make sure we have enough data points for comparison, we ONLY LOOK AT
-- procedures with >= 1000 hospitals measured.
-- Also, 2) that a higher score can mean both good and bad things in different measures
-- hence, I decided to create a lookup table to note which measures indicate better care when the score is higer and vice versa
------------------------------------------------------------------------------------------------------
-- 3. create a lookup for the in-scope measures

select a.measure_id,
       b.measure_name,
       max(a.score), -- check to see whether it's a measure of % rate or an amount/level
       count(*) count,
       'effective_care_t' as table
from effective_care_t a
left join measures_t b
on a.measure_id = b.measure_id
where a.footnote <> "11 - There were discrepancies in the data collection process."
group by a.measure_id, b.measure_name
having count >= 1000
UNION
select c.measure_id,
       d.measure_name,
       max(c.score), -- check to see whether it's a measure of % rate or an amount/level
       count(*) count,
       'readmission_t' table
from readmissions_t c
left join measures_t d
on c.measure_id = d.measure_id
group by c.measure_id, d.measure_name
order by measure_id
;
-- AMI_10  Statin Prescribed at Discharge  100     2188    effective_care_t
-- AMI_2	Aspirin Prescribed at Discharge	100	2207	effective_care_t
-- AMI_8A	Primary PCI Received Within 90 Minutes of Hospital Arrival	100	1528	effective_care_t
-- EDV	Emergency Department Volume	3	3211	effective_care_t
-- ED_1B	Median Time from ED Arrival to ED Departure for Admitted ED Patients	1180	3516	effective_care_t
-- ED_2B	Admit Decision Time to ED Departure Time for Admitted Patients	1132	3496	effective_care_t
-- HF_1	Discharge Instructions	100	2934	effective_care_t
-- HF_2	Evaluation of LVS Function	100	3781	effective_care_t
-- HF_3	ACEI or ARB for LVSD	100	2692	effective_care_t
-- IMM_2	Influenza Immunization	100	3739	effective_care_t
-- IMM_3_FAC_ADHPCT	Healthcare workers given influenza vaccination	100	3657	effective_care_t
-- MORT_30_AMI	Acute Myocardial Infarction (AMI) 30-Day Mortality Rate	21	2506	readmission_t
-- MORT_30_CABG	30-Day All-Cause Mortality Following Coronary Artery Bypass Graft (CABG) Surgery	9	1061	readmission_t
-- MORT_30_COPD	Chronic Obstructive Pulmonary Disease (COPD) 30-Day Mortality Rate	14	3644	readmission_t
-- MORT_30_HF	Heart Failure (HF) 30-Day Mortality Rate	19	3800	readmission_t
-- MORT_30_PN	Pneumonia 30-Day Mortality Rate	20	4212	readmission_t
-- MORT_30_STK	Acute Ischemic Stroke (STK) 30-Day Mortality Rate	22	2761	readmission_t
-- OP_18B	Median Time from ED Arrival to ED Departure for Discharged ED Patients	443	3340	effective_care_t
-- OP_20	Median Time from ED Arrival to Provider Contact for ED patients	143	3354	effective_care_t
-- OP_21	Median Time to Pain Management for Long Bone Fracture	182	3172	effective_care_t
-- OP_22	Patient left without being seen	22	3206	effective_care_t
-- OP_4	Aspirin at Arrival	100	2087	effective_care_t
-- OP_5	Median Time to ECG	142	2099	effective_care_t
-- OP_6	Timing of Antibiotic Prophylaxis	100	2909	effective_care_t
-- OP_7	Prophylactic Antibiotic Selection for Surgical Patients	100	2914	effective_care_t
-- PC_01	Elective Delivery	100	2520	effective_care_t
-- PN_6	Initial Antibiotic Selection for CAP in Immunocompetent Patient	100	3973	effective_care_t
-- READM_30_AMI	Acute Myocardial Infarction (AMI) 30-Day Readmission Rate	21	2302	readmission_t
-- READM_30_CABG	30-Day All-Cause Unplanned Readmission Following Coronary Artery Bypass Graft Surgery (CABG)	21	1052	readmission_t
-- READM_30_COPD	Chronic Obstructive Pulmonary Disease (COPD) 30-Day Readmission Rate	27	3723	readmission_t
-- READM_30_HF	Heart  Failure (HF) 30-Day Readmission Rate	32	3887	readmission_t
-- READM_30_HIP_KNEE	30-Day Readmission Rate Following Elective Primary Total Hip Arthroplasty (THA) and/or Total Knee Arthroplasty (TKA)	9	2779	readmission_t
-- READM_30_HOSP_WIDE	30-Day Hospital-Wide All-Cause Unplanned Readmission Rate	20	4466	readmission_t
-- READM_30_PN	Pneumonia 30-Day Readmission Rate	22	4227	readmission_t
-- READM_30_STK	Stroke (STK) 30-Day Readmission Rate	18	2723	readmission_t
-- SCIP_CARD_2	Surgery Patients on Beta-Blocker Therapy Prior to Arrival Who Received a Beta-Blocker During the Perioperative Period	100	3149	effective_care_t
-- SCIP_INF_1	Prophylactic Antibiotic Received Within 1 Hour Prior to Surgical Incision	100	3476	effective_care_t
-- SCIP_INF_10	Surgery Patients with Perioperative Temperature Management	100	3259	effective_care_t
-- SCIP_INF_2	Prophylactic Antibiotic Selection for Surgical Patients	100	3467	effective_care_t
-- SCIP_INF_3	Prophylactic Antibiotics Discontinued Within 24 hours After Surgery End Time	100	3457	effective_care_t
-- SCIP_INF_9	Urinary  Catheter Removed on Postoperative Day 1 (POD 1) or Postoperative Day 2 (POD 2) with Day of Surgery being Day Zero	103329	effective_care_t
-- SCIP_VTE_2	Surgery Patients Who Received Appropriate Venous Thromboembolism Prophylaxis Within 24 Hours Prior to Surgery to 24 Hours After Surgery	100	3519	effective_care_t
-- STK_1	Venous Thromboembolism (VTE) Prophylaxis	100	2710	effective_care_t
-- STK_10	Assessed for Rehabilitation	100	2702	effective_care_t
-- STK_2	Discharged on Antithrombotic Therapy	100	2673	effective_care_t
-- STK_3	Anticoagulation Therapy for Atrial Fibrillation/Flutter	100	1499	effective_care_t
-- STK_5	Antithrombotic Therapy By End of Hospital Day 2	100	2675	effective_care_t
-- STK_6	Discharged on Statin Medication	100	2582	effective_care_t
-- STK_8	Stroke Education	100	2372	effective_care_t
-- VTE_1	Venous Thromboembolism Prophylaxis	100	3534	effective_care_t
-- VTE_2	Intensive Care Unit Venous Thromboembolism Prophylaxis	100	2955	effective_care_t
-- VTE_3	Venous Thromboembolism Patients with Anticoagulation Overlap Therapy	100	2666	effective_care_t
-- VTE_4	Venous Thromboembolism Patients Receiving Unfractionated Heparin with Dosages/Platelet Count Monitoring by Protocol or Nomogram	100	2045	effective_care_t
-- VTE_5	Venous Thromboembolism Warfarin Therapy Discharge Instructions	100	2468	effective_care_t
-- VTE_6	Hospital Acquired Potentially-Preventable Venous Thromboembolism	71	1388	effective_care_t

-- Understanding Measures referring to https://www.medicare.gov/hospitalcompare/Data/Data-Updated.html
-- using the reference, I am creating a lookup table that 1) label each measure with either '+' implying the higher the better or '-' for the lower the better
-- and 2) 'NA' for measures that aren't defined clearly for me to judge which is the correct direction

drop table tmp_measure_lkp;

create table tmp_measure_lkp as
select x.measure_id,
       x.measure_name,
       case when x.measure_id in ('AMI_10', 'AMI_2', 'EDV', 'HF_2', 'HF_3','OP_6', 'OP_7','PN_6', 'STK_1','VTE_1', 'VTE_2', 'VTE_3', 'VTE_4', 'SCIP_INF_2') then 'NA'
            when x.measure_id in ('AMI_8A', 'HF_1', 'IMM_2', 'IMM_3_FAC_ADHPCT', 'OP_4', 'VTE_5') or (x.measure_id like 'SCIP%' and x.measure_id <> 'SCIP_INF_2') or (x.measure_id like 'STK_%' and x.measure_id <> 'STK_1') then '+'
            else '-' end measure_flag -- according to understanding from https://www.medicare.gov/hospitalcompare/Data/Data-Updated.html
from
(
  select a.measure_id, b.measure_name, 'effective_care_t' as table
  from effective_care_t a
  left join measures_t b
  on a.measure_id = b.measure_id
  where a.footnote <> "11 - There were discrepancies in the data collection process."
  group by a.measure_id, b.measure_name
  having count(*) >= 1000
  UNION
  select distinct c.measure_id, d.measure_name, 'readmission_t' as table
  from readmissions_t c
  left join measures_t d
  on c.measure_id = d.measure_id
  order by measure_id
) x
;

-- To simplify the following queries, I am going to create a table that house all the measures that we need
-- and their scores in the effective_care_t and readmissions_t tables

drop table tmp_measure_score;

create table tmp_measure_score as
select x.provider_id,
       x.measure_id,
       x.table,
       x.score,
       avg(x.score) over (partition by x.measure_id) score_avg, -- compute average score for further analysis
       stddev(x.score) over (partition by x.measure_id) score_std -- compute standard deviation for measure score for further analysis
from
(
  select provider_id,
         measure_id,
         score,
         'hospital care' table
  from effective_care_t
  where footnote <> "11 - There were discrepancies in the data collection process."
  UNION
  select provider_id,
         measure_id,
         score,
         'readmission' table
  from readmissions_t
) x
left join tmp_measure_lkp y
on x.measure_id = y.measure_id
where y.measure_flag <> 'NA' -- exclude measures with 'NA' flag
;


-----------------------------------------------
-- Evaluate scope of measures
-----------------------------------------------
-- create standardized compare_score for each measure
-- Assuming each measure has a normal distribution, using the means and standard deviations across all hospitals
-- compute z values: (score - average score)/(sample standard deviation) when a measure has a flag '+' or
-- (average score - score)/(sample standard deviation) when a measure has a flag '-'
-- assign 1-10 using z values

drop table hospital_compare_score;

create table hospital_compare_score as
select a.provider_id,
       a.table as source_data,
       a.measure_id,
       a.score,
       a.score_avg,
       a.score_std,
       case when b.measure_flag = '+' then (a.score - a.score_avg)/(a.score_std) else (a.score_avg - a.score)/(a.score_std) end score_z,
       b.measure_flag,
       case when b.measure_flag = '+' then
            (
             case when (a.score - a.score_avg)/(a.score_std) >= 2 then 10
                  when (a.score - a.score_avg)/(a.score_std) < -2 then 1
                  when (a.score - a.score_avg)/(a.score_std) <= 0.5 and (a.score - a.score_avg)/(a.score_std) > 0 then 6
                  when (a.score - a.score_avg)/(a.score_std) <= 0 and (a.score - a.score_avg)/(a.score_std) > -0.5 then 5
                  when (a.score - a.score_avg)/(a.score_std) >= -2.5 and (a.score - a.score_avg)/(a.score_std) < 2 then cast((((a.score - a.score_avg)/(a.score_std)) +2.5)/0.5 as int) + 1
             end
           ) -- allocate standardized compare scores for scores based on their z-values: (score - average score)/(sample standard deviation)
            when b.measure_flag = '-' then
            (
              case when (a.score_avg - a.score)/(a.score_std) >= 2 then 10
                   when (a.score_avg - a.score)/(a.score_std) < -2 then 1
                   when (a.score_avg - a.score)/(a.score_std) <= 0.5 and (a.score_avg - a.score)/(a.score_std) > 0 then 6
                   when (a.score_avg - a.score)/(a.score_std) <= 0 and (a.score_avg - a.score)/(a.score_std) > -0.5 then 5
                   when (a.score_avg - a.score)/(a.score_std) >= -2.5 and (a.score_avg - a.score)/(a.score_std) < 2 then cast((((a.score_avg - a.score)/(a.score_std)) + 2.5)/0.5 as int) + 1
              end
            ) -- allocate standardized compare scores for scores based on their z-values: (average score - score)/(sample standard deviation)
        end as compare_score
from tmp_measure_score a
left join tmp_measure_lkp b
on a.measure_id = b.measure_id
;

--Quality Check
select distinct measure_flag from hospital_compare_score;
-- +
-- -

select * from hospital_compare_score
where measure_flag = '+'
limit 1000
; -- looks good

select * from hospital_compare_score
where measure_flag = '-'
limit 100
; -- looks good

------------------------------------------------------
-- Compare Average Standardize Scores across hospitals
------------------------------------------------------

-- Quality Check for Hospital Comapare Scores
select source_data, count(distinct measure_id)
from hospital_compare_score
group by source_data
;
-- readmission     14
-- hospital care	27
-- Expected

select measure_id, avg(compare_score)
from hospital_compare_score
group by measure_id
;
-- all measures have very close average at around 5.5, ensuring the comparability of different measures

-- there are in total of 41 measures,
-- to find the hospital that provides consitently high-quality care, (ASSUMPTION) let's look at hospitals with at least 50% of the measures taken

select a.provider_id,
       initcap(lower(b.hospital_name)) hospital_name,
       count(a.measure_id) num_of_measure,
       round(avg(a.compare_score),3) avg_compare_score
from hospital_compare_score a
left join hospitals_t b
on a.provider_id = b.provider_id
group by a.provider_id, b.hospital_name
having num_of_measure >= 21 -- look at hospitals with at least 50% measures taken
order by avg_compare_score desc
limit 10
;

-- +-----------+--------------------------------------+--------------+-----------------+
-- |provider_id|hospital_name                         |num_of_measure|avg_compare_score|
-- +-----------+--------------------------------------+--------------+-----------------+
-- |420087     |Roper Hospital                        |40            |7.025            |
-- |420104     |Mount Pleasant Hospital               |30            |6.933            |
-- |370215     |Oklahoma Heart Hospital               |33            |6.909            |
-- |420065     |Bon Secours-st Francis Xavier Hospital|34            |6.882            |
-- |670025     |The Heart Hospital Baylor Plano       |24            |6.792            |
-- |151323     |Parkview Lagrange Hospital            |23            |6.783            |
-- |50424      |Scripps Green Hospital                |32            |6.781            |
-- |260006     |Heartland Regional Medical Center     |39            |6.769            |
-- |390138     |Waynesboro Hospital                   |34            |6.765            |
-- |390057     |Grand View Hospital                   |38            |6.763            |
-- +-----------+--------------------------------------+--------------+-----------------+
