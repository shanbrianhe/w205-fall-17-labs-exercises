-- Create Raw Tables for Hospital Compare
-- Author: Shan He
-- Date: 10/18/2017

DROP TABLE hospitals;

CREATE EXTERNAL TABLE hospitals
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
phone_number string,
hospital_type string,
hospital_ownership string,
emergency_services string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\
'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals'
;

DROP TABLE effective_care;

CREATE EXTERNAL TABLE effective_care
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
phone_number string,
condition string,
measure_id string,
measure_name string,
score string,
sample string,
footnote string,
measure_start_date string,
measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\
'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care'
;

DROP TABLE readmissions;

CREATE EXTERNAL TABLE readmissions
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
phone_number string,
measure_name string,
measure_id string,
compared_to_national string,
denominator string,
score string,
lower_estimate string,
higher_estimate string,
footnote string,
measure_start_date string,
measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\
'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions'
;

DROP TABLE measures;

CREATE EXTERNAL TABLE measures
(
measure_name string,
measure_id string,
measure_start_quarter string,
measure_start_date string,
measure_end_quarter string,
measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\
'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measures'
;

DROP TABLE surveys_responses;

CREATE EXTERNAL TABLE surveys_responses
(
provider_number string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
communication_with_nurses_achiev_pts string,
communication_with_nurses_improve_pts string,
communication_with_nurses_dim_score string,
communication_with_doctors_achiev_pts string,
communication_with_doctors_improve_pts string,
communication_with_doctors_dim_score string,
responsiveness_of_hospital_staff_achiev_pts string,
responsiveness_of_hospital_staff_improve_pts string,
responsiveness_of_hospital_staff_dim_score string,
pain_management_achiev_pts string,
pain_management_improve_pts string,
pain_management_dim_score string,
communication_about_medicines_achiev_pts string,
communication_about_medicines_improve_pts string,
communication_about_medicines_dim_score string,
cleanliness_and_quietness_achiev_pts string,
cleanliness_and_quietness_improve_pts string,
cleanliness_and_quietness_dim_score string,
discharge_information_achiev_pts string,
discharge_information_improve_pts string,
discharge_information_dim_score string,
overall_rating_of_hospital_achiev_pts string,
overall_rating_of_hospital_improve_pts string,
overall_rating_of_hospital_dim_score string,
hcahps_base_score string,
hcahps_consistency_score string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\
'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/surveys_responses'
;

DROP TABLE states;

CREATE TABLE states (state varchar(64), state_abbrev varchar(64));

INSERT INTO TABLE states
VALUES ('Alabama', 'AL'), ('Alaska', 'AK'), ('Arizona', 'AZ'), ('Arkansas', 'AR'), ('American Samoa', 'AS'), ('California', 'CA'), ('Colorado', 'CO'), ('Connecticut', 'CT'), ('Delaware', 'DE'), ('Florida', 'FL'), ('Georgia', 'GA'), ('Hawaii', 'HI'), ('Idaho', 'ID'),
('Illinois', 'IL'), ('Indiana', 'IN'), ('Iowa', 'IA'), ('Kansas', 'KS'), ('Kentucky', 'KY'), ('Louisiana', 'LA'), ('Maine', 'ME'), ('Maryland', 'MD'), ('Massachusetts', 'MA'), ('Michigan', 'MI'), ('Minnesota', 'MN'), ('Mississippi', 'MS'),
('Missouri', 'MO'), ('Montana', 'MT'), ('Nebraska', 'NE'), ('Nevada', 'NV'), ('New Hampshire', 'NH'), ('New Jersey', 'NJ'), ('New Mexico', 'NM'), ('New York', 'NY'), ('North Carolina', 'NC'), ('North Dakota', 'ND'), ('Ohio', 'OH'), ('Oklahoma', 'OK'),
('Oregon', 'OR'), ('Pennsylvania', 'PA'), ('Rhode Island', 'RI'), ('South Carolina', 'SC'), ('South Dakota', 'SD'), ('Tennessee', 'TN'), ('Texas', 'TX'), ('Utah', 'UT'), ('Vermont', 'VT'), ('Virginia', 'VA'), ('Washington', 'WA'), ('West Virginia', 'WV'),
('Wisconsin', 'WI'), ('Wyoming', 'WY'), ('District of Columbia', 'DC'), ('Federated States of Micronesia', 'FM'), ('Guam', 'GU'), ('Marshall Islands', 'MH'), ('Northern Mariana Islands', 'MP'), ('Palau', 'PW'), ('Puerto Rico', 'PR'), ('Virgin Islands', 'VI')
;
