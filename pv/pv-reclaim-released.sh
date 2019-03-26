#!/bin/bash
# Run with sudo
oc login -u cluster-admin
released_pvs=$(oc get pv|grep Released|awk {'print $1'})
for pv in $released_pvs
do
  echo "$pv";
  rm -rf /var/lib/origin/openshift.local.volumes/pv/$pv/*
  oc patch pv/$pv --type json -p $'- op: remove\n  path: /spec/claimRef'
done
echo "Done"
oc get pv
