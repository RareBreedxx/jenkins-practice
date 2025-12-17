#!/bin/sh

echo "System check started..." | tee system_check.log
echo "Date:" $(date) | tee -a system_check.log

echo "CPU Info:" | tee -a system_check.log
cat /proc/cpuinfo | head -5 | tee -a system_check.log

echo "Memory Usage:" | tee -a system_check.log
free -h | tee -a system_check.log

echo "Disk Usage:" | tee -a system_check.log
df -h | tee -a system_check.log

echo "System check completed successfully." | tee -a system_check.log

