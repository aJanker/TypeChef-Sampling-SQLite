#!/bin/bash
echo "Start make..."
./configure
timeout 600 make 

RETVAL=$?
echo $RETVAL
[ $RETVAL -eq 0 ] && echo "Success_Build"
[ $RETVAL -eq 124 ] && echo "Failure_Timeout"
[ $RETVAL -ne 0 ] && echo "Failure_Build"

exit


