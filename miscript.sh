#!/bin/bash

HOST=(192.168.1.10 192.168.1.20)
command=('uname -a; uptime')
user='-l username'
# p='-p 2222'

for i in ${HOST[@]} ; do ssh $user $i $p $command ; done
