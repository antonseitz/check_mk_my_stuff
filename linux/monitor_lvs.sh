#!/bin/bash
export LVM_SUPPRESS_FD_WARNINGS=1
prozent=$(lvs | grep "twi"  | awk '{print $5}' )
size=$(lvs | grep "twi"  | awk '{print $4}' )
echo "P LVS_Thin_HDD Prozent=$prozent%;80;90;0;100 LVM thin HDD Belegung in Prozent. Size: $size"

 