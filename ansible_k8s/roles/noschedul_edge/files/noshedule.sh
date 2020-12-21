#!/bin/bash

edge_hostname=`kubectl get node|grep edge|awk '{print $1}'`
edge_status=`kubectl get node|grep edge|awk '{print $2}'`
for i in $edge_hostname;
do
status=`kubectl get node|grep $i|awk '{print $2}'`
if [ ${status} == 'Unknown' ] || [ ${status} == 'NotReady' ]; then
echo edge status is $status
echo "please call the command to unschedule: ansible-playbook -i hosts noschedul_edge.yml"
fi
kubectl taint nodes $i edge=$i:NoExecute
done

