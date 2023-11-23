#!/bin/bash

dbname="/hdd/db"
output_name="/users/Ruisong/outputs"
num=1000000
value_size=1024

#rm -rf $dbname
sync
sudo bash -c "echo 3 > /proc/sys/vm/drop_caches" 
../db_bench --db=$dbname --num=$num --use_existing_db=0  --compression_type=none --compression_ratio=1 --benchmarks="fillseq,stats" --value_size=$value_size  --report_interval_seconds=1 --report_file="fillseq_report.txt" | tee $output_name/fillseq_runresult.txt
sleep 5s
sync
sudo bash -c "echo 3 > /proc/sys/vm/drop_caches" 
../db_bench --db=$dbname --num=$num --use_existing_db=0  --compression_type=none --compression_ratio=1 --benchmarks="fillrandom,stats" --value_size=$value_size  --report_interval_seconds=1 --report_file="fillrandom_report.txt" | tee $output_name/fillrandom_runresult.txt
sleep 5s
sync
sudo bash -c "echo 3 > /proc/sys/vm/drop_caches" 
../db_bench --db=$dbname --num=$num --use_existing_db=1  --compression_type=none --compression_ratio=1 --benchmarks="overwrite,stats" --value_size=$value_size  --report_interval_seconds=1 --report_file="overwrite_report.txt" | tee $output_name/overwrite_runresult.txt
sleep 5s
sync
sudo bash -c "echo 3 > /proc/sys/vm/drop_caches" 
../db_bench --db=$dbname --num=$num --use_existing_db=1  --compression_type=none --compression_ratio=1 --benchmarks="readseq,stats" --value_size=$value_size  --report_interval_seconds=1 --report_file="readseq_report.txt" | tee $output_name/readseq_runresult.txt
sleep 5s
sync
sudo bash -c "echo 3 > /proc/sys/vm/drop_caches" 
../db_bench --db=$dbname --num=$num --reads=10000 --use_existing_db=1  --compression_type=none --compression_ratio=1 --benchmarks="readrandom,stats" --value_size=$value_size  --report_interval_seconds=1 --report_file="readrandom_report.txt" | tee $output_name/readrandom_runresult.txt