#!/bin/bash

#./amqp_ini.sh 125 1000 100 0.05
# -t $1 bytes
# -f $2 miliseconds
# -r $3 messages
# -h $4 heartbeat time

filename=$(date +"%Y%m%d_%H%M")

#HOST="10.0.1.190"

if [ $# -gt 0 ]; then
        SIZE=$1
        FRECUENCY=$2
        #COUNT=$3
        TESTLIFE=$3
        HEARTBEAT=$4
else
        echo "Without arguments, using default values."
        SIZE=1
        FRECUENCY=200
        COUNT=100
        HEARTBEAT=580   #default time
fi

#resfile="/result.res"
resfile=$filename"_HandoverTest.txt"
summaryFile=$filename"_AmqpingSummary.txt"

echo $resfile
tempfile=$(mktemp)
rm -f $resfile

# Is associated to an AP?
iw dev wlan0 link | grep "Connected"

ap1=`iwconfig wlan0 | grep "Mode" | awk -F "Point: " '{print$2}'`
echo $ap1 >> $summaryFile

# ----------------------------------------------------------
JVM=java
dirnameRemote="/home/usuario-grc"
broker=10.0.1.190

#$JVM -jar $dirnameRemote/amqperf.jar -p -b $broker -t $SIZE -f $FRECUENCY -r $COUNT -h $HEARTBEAT >> $resfile
$JVM -jar $dirnameRemote/amqperf.jar -p -b $broker -t $SIZE -f $FRECUENCY -d $TESTLIFE -h $HEARTBEAT >> $resfile

#-----------------------------------------------------------

ap2=`iwconfig wlan0 | grep "Mode" | awk -F "Point: " '{print$2}'`
echo $ap2 >> $summaryFile

#-----------------------------------------------------------

ap2=`iwconfig wlan0 | grep "Mode" | awk -F "Point: " '{print$2}'`
echo $ap2 >> $summaryFile


if [ "$ap1" == "$ap2" ]; then
        echo "No se ha efectuado cambio de AP"
        echo "No se ha efectuado cambio de AP" >> $summaryFile
else
        echo "Se ha producido un cambio de AP"
        echo "Se ha producido un cambio de AP" >> $summaryFile
fi

