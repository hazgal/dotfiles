#! /bin/bash

date_time=$(date "+%H:%M:%S")
date_date=$(date "+%A  %d %B %G")
battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)
mode=$(cat /sys/firmware/acpi/platform_profile)

echo $mode "mode"  " | " $battery_capacity"%" $battery_status  " | "  $date_time  " | "  $date_date
