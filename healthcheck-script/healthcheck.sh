#!/bin/bash
# Buiding a logging health_check script 

set -e

# Exec replaces the current process entirely with a new process(not a child process)
# when attaching the >> operator, then it means "replace this process". 2>&1 (stderr/stdout)
exec >> /home/user_name/healthcheck.log 2>&1

echo "Checking today's date"
echo "Today's date is: $(date)"

echo "Determining NGINX status..."
STATUS=$(system is-active nginx) || true
  
  echo "nginx is $STATUS"

if [ "$STATUS" == "active" ]; then
  
  echo "nginx is UP"
else
  
  echo "nginx is DOWN"
fi

echo "Checking Disk Space..."
df -h /

echo "Checking directory existence..."
if [ -d "/mnt/testfile" ]; then
  
  echo "Mount point exists"
else
  
  echo "Mount point missing"
fi

echo "Determining exit code for script..."
echo $?
