#!/bin/sh
#       generate trace file in tmp
#
HOSTNAME=`hostname`
FILENAME=/tmp/$HOSTNAME.pcap

echo "trace on normal interface $FILENAME"

rm -f $FILENAME
#touch $FILENAME
#chown plhazure $FILENAME
#chmod 666 $FILENAME

echo starting tcpdump 

#tcpdump -s 0 -w $FILENAME # host not 62.116.221.100 port not 122
#tcpdump -s 0 -w $FILENAME  port not 122
tcpdump -s 0 -Z plhazure -w $FILENAME host not 168.63.129.16 and host not 169.254.169.254
