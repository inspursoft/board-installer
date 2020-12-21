1. Download rpm package from here: **[Download rpm package](http://10.110.13.73/_layouts/15/start.aspx#/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2FShared%20Documents%2FContainer%20Service%2Fkubernetes%20rpm%20package&FolderCTID=0x01200097BD792FCDCA314591C60C2E8182BBA0&View=%7B84ACE000%2D5ACD%2D4A83%2DBA13%2D0990224E3589%7D)**
2. Create yum source: copy the rpm package to /var/www/html, start httpd service
3. Etdit the .repo file, you can named the repo file as k8s.repo
4. Replace the k8s.repo in the directory ansible
5. Please modify hosts file, here define the master/node/etcd 
6. Config ssh without key
   edit hosts-key, add all hosts that need config host ip, usename and password to this file
   run the command line to config ssh with key: ansible-playbook -i hosts-key rsync_key.yml
7. set up kubernetes evironment with the following command line:
   ansible-playbook -i hosts r.yml
