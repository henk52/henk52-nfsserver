henk52-nfsserver
================

Pupper module for administrating an NFS server.
nfsserver

This is the nfsserver module.


Verify installation:
  showmount -e localhost



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
License
-------


Contact
-------


Support
-------

Please log tickets and issues at our [Projects site](http://projects.example.com)
