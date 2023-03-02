#!/bin/bash

FILNAVN=/var/log/ufw.log.1
FILNAVN=/var/log/ufw.log
SERVERNAME=`hostname`
echo $SERVERNAME

lookup () {
while  read n1 n2 n3 n4
do
NR=`dig -x $n2 +short`
echo "$n1\t $n2\t $n3\t $n4 $NR"
done
}

echo "\n------ Last blocked -------\n"
sed -n -e "s/\(.*\)$SERVERNAME.*BLOCK.*\(SRC.*\)DST.*\(PROTO.*\)\(DPT=.* \)/\1\2\t\3\t\4/p" $FILNAVN |tail -33

SIZE=`wc -l <$FILNAVN`

echo "\n---------------------------------\n\nNumber of entries: $SIZE"
echo "\n------ Blocked Ports -------\n"
echo " Antal\tPort"
sed -n -e 's/.*BLOCK.*DPT=\(.*\) [LW].*/\1/p' $FILNAVN  |sort  | uniq -c | sort -n -r -k 1  |head -n 10

echo "\n------ LIMIT Blocked Ports -------\n"

sed -n -e "s/\(.*\)$SERVERNAME.*LIMIT.*\(SRC.*\)DST.*\(PROTO.*\)\(DPT=.* \)/\1\2\t\3\t\4/p" $FILNAVN |tail -10

echo "\n Antal\tPort"
sed -n -e 's/.*LIMIT.*DPT=\(.*\) [LW].*/\1/p' $FILNAVN  |sort  | uniq -c | sort -n -r -k 1  |head -n 10


echo "\n------- OUTGOING ------\n"
sed -n -e 's/.*ALLOW.* DST=\(.*\) LEN.*DF PROTO=\(.*\) SPT.* DPT=\(.*\) [LEN|WIN].*/\1 \2 \3/p' $FILNAVN |sort -k 5 | uniq -c | lookup | sort -k 4
#grep "UFW ALLOW" $FILNAVN |tail



