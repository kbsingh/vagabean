#!/bin/bash

atomic install projectatomic/helloapache
if [ $? -ne 0 ]; then echo "atomic install failed" ; exit 1 ; fi

atomic run projectatomic/helloapache
if [ $? -ne 0 ]; then echo "atomic run failed" ; exit 1 ; fi

#waiting for pod to come up
podup=$(kubectl get pod | grep -qE 'apache.*Running' ; echo $?)
timer=0
echo 'Waiting for upto 4 minutes for the app to launch...'
while [ $timer -lt 120 ] && [ $podup -ne 0 ]; do
  echo -n '+'
  sleep 2
  podup=$(kubectl get pod | grep -qE 'apache.*Running' ; echo $?)
  timer=$((timer+1))
done
echo ' '
if [ $timer -gt 119 ]; then
  echo 'Gave up waiting for app to start'
  exit 1
fi

# This is really our assert...
curl http://localhost/ | grep -q Apache
if [ $? -eq 0 ]; then
  echo "Sucess!"
  exit 0
else
 echo 'Returned value now what we expected'
 exit 1
fi
