#load_data_lake.sh'
#Shan He

#ReadMe
#run script with load_data_lake.sh <directory to raw files> <directory to EC2 security key pair> <EC2 Public DNS>
#locate directory for raw data
cd $1
#for me: $1 = /Desktop/w205/w205-fall-17-labs-exercises/exercise_1/loading_and_modelling/raw_data

#unzip source file
unzip Hospital_Revised_Flatfiles.zip

#set up files for loading
cd ..
mkdir data_for_loading
cp -R $1 data_for_loading/

#delete the first line of all csv files
sed -i '' '1d' *.data

#rename base files
mv Hospital\ General\ Information.csv hospitals.csv
mv Timely\ and\ Effective\ Care\ -\ Hospital.csv effective_care.csv
mv Readmissions\ and\ Deaths\ -\ Hospital.csv readmissions.csv
mv Measure\ Dates.csv measures.csv
mv surveys_responsed.csv surveys_responses.csv

#log into EC2 instance
cd $2
ssh -i foo.pem root@$3

#transfer files to EC2 from local machine
#on local machine
scp -r -i ~/Desktop/w205/foo.pem ~/Desktop/w205/w205-fall-17-labs-exercises/exercise_1/loading_and_modelling/data_for_loading/* root@$3:/data/hospital_compare

#create HDFS folders
su - w205
hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -mkdir /user/w205/hospital_compare/measures
hdfs dfs -mkdir /user/w205/hospital_compare/surveys_responses

#put base files into hdfs
cd /data/hospital_compare
hdfs dfs -put hospitals.csv /user/w205/hospital_compare/hospitals
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/effective_care
hdfs dfs -put readmissions.csv /user/w205/hospital_compare/readmissions
hdfs dfs -put measures.csv /user/w205/hospital_compare/measures
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/surveys_responses

#check whether all base files are transferred
hdfs dfs -ls -R /user/w205/hospital_compare/
