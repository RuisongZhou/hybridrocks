#!/bin/bash

dbname="/ssd/db"
output_name="/users/Ruisong/ssdoutputs"
num=100000000
value_size=1024
level0_size=67108864  #64MB
sst_size=16777216   #16MB

rm -rf $dbname
sync
sudo bash -c "echo 3 > /proc/sys/vm/drop_caches" 
../db_bench --db=$dbname --num=$num --use_existing_db=0  --compression_type=none --compression_ratio=1 \
--benchmarks="fillseq,stats" --statistics --value_size=$value_size --max_bytes_for_level_base=$level0_size --target_file_size_base=$sst_size --report_interval_seconds=1 \
--stats_interval_seconds=5 --report_file="$output_name/fillseq_report.txt" | tee $output_name/fillseq_runresult.txt
sleep 5s

sync
sudo bash -c "echo 3 > /proc/sys/vm/drop_caches" 
../db_bench --db=$dbname --num=$num --use_existing_db=0  --compression_type=none --compression_ratio=1 \
--benchmarks="fillrandom,stats" --statistics --value_size=$value_size  --max_bytes_for_level_base=$level0_size --target_file_size_base=$sst_size --report_interval_seconds=1 \
--stats_interval_seconds=5 --report_file="$output_name/fillrandom_report.txt" | tee $output_name/fillrandom_runresult.txt
sleep 5s

sync
sudo bash -c "echo 3 > /proc/sys/vm/drop_caches" 
../db_bench --db=$dbname --num=$num --use_existing_db=1  --compression_type=none --compression_ratio=1 \
--benchmarks="overwrite,stats" --statistics --value_size=$value_size  --max_bytes_for_level_base=$level0_size --target_file_size_base=$sst_size --report_interval_seconds=1 \
--stats_interval_seconds=5 --report_file="$output_name/overwrite_report.txt" | tee $output_name/overwrite_runresult.txt
sleep 5s

sync
sudo bash -c "echo 3 > /proc/sys/vm/drop_caches" 
../db_bench --db=$dbname --num=$num --use_existing_db=1  --use_existing_keys=1 --compression_type=none --compression_ratio=1 \
--benchmarks="readseq,stats" --statistics --value_size=$value_size  --max_bytes_for_level_base=$level0_size --target_file_size_base=$sst_size --report_interval_seconds=1 \
--stats_interval_seconds=5 --report_file="$output_name/readseq_report.txt" | tee $output_name/readseq_runresult.txt
sleep 5s

sync
sudo bash -c "echo 3 > /proc/sys/vm/drop_caches" 
../db_bench --db=$dbname --num=$num --reads=10000 --use_existing_db=1  --use_existing_keys=1 --compression_type=none --compression_ratio=1 \
--benchmarks="readrandom,stats" --statistics --value_size=$value_size  --max_bytes_for_level_base=$level0_size --target_file_size_base=$sst_size --report_interval_seconds=1 \
--stats_interval_seconds=5 --report_file="$output_name/readrandom_report.txt" | tee $output_name/readrandom_runresult.txt