#/ansible_k8s/ssh.sh ${PASS} ${SSH_IP}
log_name=${LOG_TIMESTAMP}.log
log_dir=/tmp/log
hosts_dir=/tmp/hosts_dir
log=${log_dir}/${log_name}

echo "------==" >> ${log}
echo ${NODE_PASS} >> ${log}
echo ${NODE_IP} >> ${log}
echo ${MASTER_IP} >> ${log}
master_ip_list="${MASTER_IP}"
echo ${master_ip_list} >> ${log}

passwordlist="${NODE_PASS}"
iplist="${NODE_IP}"
master_ip_list="${MASTER_IP}"

echo ${master_ip_list} >> ${log}

arrpasswd=(`echo $passwordlist | tr '_' ' '`)
arrip=(`echo $iplist | tr '_' ' '`)

echo ${#arrpasswd[@]}
echo ${#arrip[@]}
if [ ${#arrpasswd[@]} == ${#arrip[@]} ] ; then

for (( i=0; i<${#arrpasswd[@]}; i++))
do
echo ${arrpasswd[$i]} ${arrip[$i]} >> ${log}
/ansible_k8s/ssh.sh ${arrpasswd[$i]} ${arrip[$i]} 

done


else

echo "password and ipaddress number is not match" >> ${log}
fi

#arr_master_ip=(`echo $master_ip_list | tr '_' ' '`)
arr_master_ip=`echo $master_ip_list | sed 's/_/ /g'`
echo "==============1" >>${log}
echo ${master_ip_list} >> ${log}
echo ${arr_master_ip} >> ${log}
echo "==============2" >>${log}
for (( i=0; i<${#arr_master_ip[@]}; i++))
do
echo ${arr_master_ip[$i]} ${arr_master_ip[$i]} >> ${log}
echo "1----------------" >>${log}
echo ${MASTER_PASS} >> ${log}
echo ${arr_master_ip} >> ${log}
echo "2----------------" >>${log}
/ansible_k8s/ssh.sh ${MASTER_PASS} ${arr_master_ip} >> ${log}
done

echo ${ADMIN_SERVER_IP} >> ${log}
echo ${ADMIN_SERVER_PORT} >> ${log}
echo ${INSTALL_FILE} >> ${log}
echo ${HOSTS_FILE} >> ${log}
echo ${LOG_ID} >>${log}
echo ${TOKEN} >>${log}

echo ${MASTER_IP} >>${log}

cd /ansible_k8s
ansible-playbook -i $hosts_dir/${HOSTS_FILE} ${INSTALL_FILE}.yml >> ${log}

#ADMIN_SERVER_IP=10.110.25.227
#ADMIN_SERVER_PORT=8080
#LOG_ID=5
#NODE_IP=192.168.122.10
#HOSTS_FILE=test
#log_name=1584435991.log
result=$?

echo curl -X PUT \
  http://$ADMIN_SERVER_IP:$ADMIN_SERVER_PORT/v1/admin/node/callback \
  -H ''token:${TOKEN}'' \
  -H 'Content-Type: application/json' \
  -d '{"log_id": '$LOG_ID', "ip": "'"$NODE_IP"'", "install_file": "'"$INSTALL_FILE"'","log_file": "'"$log_name"'","success": '$result'}' 

curl -X PUT \
  http://$ADMIN_SERVER_IP:$ADMIN_SERVER_PORT/v1/admin/node/callback \
  -H ''token:${TOKEN}'' \
  -H 'Content-Type: application/json' \
  -d '{"log_id": '$LOG_ID', "ip": "'"$NODE_IP"'", "install_file": "'"$INSTALL_FILE"'","log_file": "'"$log_name"'","success": '$result'}'
