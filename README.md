henk52-nfsserver
================

Pupper module for administrating an NFS server.
nfsserver

Supports Centos 6.5 and Fedora 20.

This is the nfsserver module.


Verify installation:
  showmount -e localhost

# The directories are expected to have been created.

$szDefaultNfsOptionList =  'ro,no_root_squash'
$szDefaultNfsClientList = hiera ( 'DefaultNfsClientList', '10.1.2.0/255.255.255.0' )
$szBaseDirectory = '/var'

$hNfsExports = {
 "$szBaseDirectory/configs" => {
             'NfsOptionList' => "$szDefaultNfsOptionList",
             'NfsClientList' => "$szDefaultNfsClientList",
                               }, 
 "$szBaseDirectory/files" => {
             'NfsOptionList' => "$szDefaultNfsOptionList",
             'NfsClientList' => "$szDefaultNfsClientList",
                             }, 
}

class { 'nfsserver':
   hohNfsExports => $hNfsExports,
}



Troubleshooting
---------------

Could not find kernel image: fedora_20_x86_64/vmlinuz

fix: sudo chown -R nobody /var/tftp/fedora_20_x86_64

s -l /var/tftp/
total 36
drwxr-xr-x. 2 root   root  4096 Aug 11 23:09 fedora_20_x86_64
-r--r--r--. 1 nobody root 26460 Aug  7 00:13 pxelinux.0
dr-xr-xr-x. 2 nobody root  4096 Aug 12 14:38 pxelinux.cfg


Warning: Couldn't mount nfs:,nfsvers=3:10.1.2.3:/var/ks/images/fedora_20_x86_64





---
Solution: http://maazanjum.com/2014/02/17/starting-nfs-quotas-cannot-register-service-rpc-unable-to-receive-errno-connection-refused/
Start portmap.

Error: Could not start Service[nfs]: Execution of '/sbin/service nfs start' returned 1: Starting NFS services:  [  OK  ]
Starting NFS quotas: Cannot register service: RPC: Unable to receive; errno = Connection refused
rpc.rquotad: unable to register (RQUOTAPROG, RQUOTAVERS, udp).
[FAILED]
Starting NFS mountd: [FAILED]
Starting NFS daemon: rpc.nfsd: writing fd to kernel failed: errno 111 (Connection refused)
rpc.nfsd: unable to set any sockets for nfsd
[FAILED]
Wrapped exception:
Execution of '/sbin/service nfs start' returned 1: Starting NFS services:  [  OK  ]
Starting NFS quotas: Cannot register service: RPC: Unable to receive; errno = Connection refused
rpc.rquotad: unable to register (RQUOTAPROG, RQUOTAVERS, udp).
[FAILED]
Starting NFS mountd: [FAILED]
Starting NFS daemon: rpc.nfsd: writing fd to kernel failed: errno 111 (Connection refused)
rpc.nfsd: unable to set any sockets for nfsd
[FAILED]
Error: /Stage[main]/Nfsserver/Service[nfs]/ensure: change from stopped to running failed: Could not start Service[nfs]: Execution of '/sbin/service nfs start' returned 1: Starting NFS services:  [  OK  ]
Starting NFS quotas: Cannot register service: RPC: Unable to receive; errno = Connection refused
rpc.rquotad: unable to register (RQUOTAPROG, RQUOTAVERS, udp).
[FAILED]
Starting NFS mountd: [FAILED]
Starting NFS daemon: rpc.nfsd: writing fd to kernel failed: errno 111 (Connection refused)
rpc.nfsd: unable to set any sockets for nfsd
[FAILED]


License
-------


Contact
-------


Support
-------

Please log tickets and issues at our [Projects site](http://projects.example.com)
