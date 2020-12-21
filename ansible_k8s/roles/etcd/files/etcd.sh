etcdctl mkdir /atomic.io/network
etcdctl mk /atomic.io/network/config '{"Network":"172.17.0.0/16", "SubnetMin": "172.17.1.0", "SubnetMax": "172.17.254.0"}'
