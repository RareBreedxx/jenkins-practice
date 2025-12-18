#!/bin/sh

LOG_FILE="/logs/system_check.log"

echo "System check started..." | tee "$LOG_FILE"
date | tee -a "$LOG_FILE"

echo "CPU Info:" | tee -a "$LOG_FILE"
cat /proc/cpuinfo | head -10 | tee -a "$LOG_FILE"

echo "Memory Usage:" | tee -a "$LOG_FILE"
free -h | tee -a "$LOG_FILE"

echo "Disk Usage:" | tee -a "$LOG_FILE"
df -h | tee -a "$LOG_FILE"

echo "System check completed successfully." | tee -a "$LOG_FILE"

