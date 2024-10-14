#!/bin/bash

# Function to display CPU usage

function cpu_usage {
	echo "==== CPU USAGE ===="
	# Get total CPU usage from top command
	top -bn1 | grep "Cpu(s)" | awk '{print "Total CPU Usage: "100 - $8"%"}'
}

# Function to display memory usage

function memory_usage {
         echo "==== MEMORY USAGE ===="
	 # Get total, used and free memory from the free command 
	 free -m | awk 'NR==2{printf "Memory Usage: %sMB/%sMB (%.2f%%)\n", $3, $2, $3*100/$2}'

}

# Function to display disk Usage

 function disk_usage {
          echo "==== DISK USAGE ===="
          # Get disk usage from df command 
          df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'	  
 }
 
# Function to display top 5 processes by CPU Usage

  function top_cpu_processes {
           echo "==== TOP 5 PROCESSES BY CPU USAGE ===="
	   ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6  
  }
 
# Function to display top 5 processes by memory usage

  function top_memory_usage {
           echo "==== TOP 5 PROCESSES BY MEMORY USAGE"
	   ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
  }


# Optional: Add more stats (OS version, uptime, load average, logged-in users)
  function additional_stats {
           echo "==== ADDTIONAL STATS ===="
	   echo "OS Version: $(uname -a)"
	   echo "Uptime: $(uptime -p)"
	   echo "Load Average: $(uptime | awk -F'load average:''{print $2}')"
	   echo "Logged-in Users: $(who | wc -l)"
	   echo "Failed Login Attempts:"
	   grep "failed password" /var/log/auth.log | wc -l
  }

# Display all stats
cpu_usage
memory_usage
disk_usage
top_cpu_processes
top_memory_processes
additional_stats
