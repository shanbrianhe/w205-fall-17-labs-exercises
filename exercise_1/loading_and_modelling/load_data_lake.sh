#load_data_lake.sh

#create dir for loading
cd /Desktop/w205/w205-fall-17-labs-exercises/exercise_1/loading_and_modelling/raw_data

#unzip source file
unzip Hospital_Revised_Flatfiles.zip

#set up files for load
cd /Desktop/w205/w205-fall-17-labs-exercises/exercise_1/loading_and_modelling
mkdir data_for_loading
cp -R raw_data/ data_for_loading/

#delete the first line of all csv files
sed -i '' '1d' *.data

#log into EC2 instance
cd /Desktop/w205/
ssh -i foo.pem root@$1

#create HDFS folder
su - w205
hdfs dfs -mkdir /user/w205/hospital_compare

#in local computer
scp -r -i ~/Desktop/w205/foo.pem ~/Desktop/w205/w205-fall-17-labs-exercises/exercise_1/loading_and_modelling/data_for_loading/* root@ec2-54-209-210-239.compute-1.amazonaws.com:~/hospital_compare
