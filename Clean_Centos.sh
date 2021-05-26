#!/bin/bash

FreeSpaceBeforeClean=`df -k -h . | awk ' { print $4 } ' | sed -e 's/Avail//g' | tail -n 1`

function SanitiseMeasurement {
    sed s/M//g | sed s/G//g | sed s/T//g
}

echo -e "
Free Disk space prior to cleaning: $FreeSpaceBeforeClean"

# echo "Deleting Old/Archive Message Logs...
# `ls /var/log/messages-* 2>/dev/null`
# "
# rm -f /var/log/messages-* 2>/dev/null

echo "Deleting Old/Archive Cron Logs....
`ls /var/log/cron-* 2>/dev/null`
"
rm -f /var/log/cron-* 2>/dev/null

# echo "Deleting Old/Archive Secure Logs...
# `ls /var/log/secure-* 2>/dev/null`
# "
# rm -f /var/log/secure-* 2>/dev/null

echo "Deleting Old/Archive Spooler Logs...
`ls /var/log/spooler-* 2>/dev/null`
"
rm -f /var/log/spooler-* 2>/dev/null

echo "Deleting Old/Archive Maillog Logs...
`ls /var/log/maillog-* 2>/dev/null`
"
rm -f /var/log/maillog-* 2>/dev/null

echo "Deleting Old/Archive Lastlog...
`ls /var/log/lastlog-* 2>/dev/null`
"
rm -f /var/log/lastlog-* 2>/dev/null

echo "Deleting Old/Archive Exim_paniclog Logs...
`ls /var/log/exim_paniclog-* 2>/dev/null`
"
rm -f /var/log/exim_paniclog-* 2>/dev/null

echo "Deleting Old/Archive Exim_rejectlog Logs...
`ls /var/log/exim_rejectlog-* 2>/dev/null`
"
rm -f /var/log/exim_rejectlog-* 2>/dev/null

echo "Deleting Old/Archive Exim_mainlog Logs...
`ls /var/log/exim_mainlog-* 2>/dev/null`
"
rm -f /var/log/exim_mainlog-* 2>/dev/null

echo "Removing cPanel Trash Folders at /home/user/.trash/...
"
rm -rf /home*/*/.trash

echo "
Performing Yum Clean ...
"
yum clean all &>/dev/null

echo "
Clean Old Kernel ...
"
yum install yum-utils
sudo package-cleanup --oldkernels --count=2

# Checks free space after cleaning routine
FreeSpaceAfterClean=`df -k -h . | awk ' { print $4 } ' | sed -e 's/Avail//g' | tail -n 1`

# Strips the M (for MB), G (for GB) and T (for Terabyte) out of the results, just leaving a integer
BEFORE=`echo $FreeSpaceBeforeClean | SanitiseMeasurement`
AFTER=`echo $FreeSpaceAfterClean | SanitiseMeasurement`

# Calculates space free'd up
FREED=`echo "$AFTER-$BEFORE" | bc`

# Displays the amount of space free'd up
echo "Space Released: $FREED GB"

exit 0
