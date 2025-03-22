#!/bin/bash

echo "Server Performance Stats"

# Total CPU Usage
echo -e "\nCPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " $2 + $4 "%"}'

# Total Memory Usage
echo -e "\nMemory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB, Free: %sMB (%.2f%%)\n", $3, $4, $3*100/($3+$4)}'

#Total Disk Usage
echo -e "\nDisk Usage:"
df -h --total | grep "total" | awk '{printf "Used: %s, Free: %s, Usage: %s\n", $3, $4, $5}'

# Top 5 Processes by CPU Usage
echo -e "\nTop 5 Processes by CPU Usage:"
ps -eo pid, comm, %cpu --sort=-%cpu | head -n 6

# Top 5 Processes by Memory Usage
echo -e "\nTop5 Processes by Memory Usage:"
ps -eo pid, comm, %mem ==sort=-%mem | head -n 6

# Additional Stats
echo -e "\nAdditional Stats:"
echo "OS Version:" $(uname -a)
echo "Uptime:" $(uptime -p)
echo "Load Average:" $(uptime | awk -F'load average: ' '{print $2}')
echo "Logged in Users:" ($who | wc -l)
echo "Failed Login Attempts:" $(grep "Failed password" /var/log/auth.log | wc-l 2>/dev/null || echo "Log file not accessible.")

echo -e "\nAnalysis Complete."