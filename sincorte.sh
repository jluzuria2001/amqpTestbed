#!/bin/bash

# ./sincorte.sh

#restablecer el broker para el inicio de la prueba
restart() {
	#killall java
        echo "restarting broker"
#	sudo /etc/init.d/rabbitmq-server restart

	echo "inicia el consum"
	sleep 60
#	bash consum.sh &
#	JVM=java
#	dirname="/home/jorlu"
#	broker=10.0.1.190

#	$JVM -jar $dirname/amqperf.jar -c -b $broker &
#	sleep 5
}

#--------------------------------funciones
export TERM=${TERM:-dumb}

echo $(date) > pruebaini.txt

#rm -r /tmp/test
mkdir /tmp/test

fileResult="/tmp/test/results.txt"
fileWaiting="/tmp/fichero.txt"
fileVector="/tmp/test/results2.txt"
fileReg="/tmp/test/pruebaini.txt"


if [ -e $fileResult ]; then
	rm $fileResult
else
	echo "-"
fi

if [ -e $fileWaiting ]; then
	rm $fileWaiting
else
	echo "--"
fi

if [ -e $fileVector ]; then
  	rm $fileVector
else
	echo "---"
fi

#--------------------------------------variables
COUNT=80
TESTLIFE=240 	#240 segundos

###------------------------------------void(main)
clear

c=1

echo "ini: " $(date) >> $fileReg

for HEARTBEAT in 580; do
	echo "----------------------------------------------------------------Welcome to new test"
	#for SIZE in 10240 51200 102400; do 		#tamaños grandes
	#for SIZE in 512 1024 3072 6144; do
	#for SIZE in 50 100 150 200; do
	#for SIZE in 51200 102400 153600 204800; do
	for SIZE in 204800; do

	#for FRECUENCY in 20 25 33 50 100; do
       	#for FRECUENCY in 10 100 500 1000; do
	#for FRECUENCY in 20 25 33 50; do
	for FRECUENCY in 20; do

			if [ $FRECUENCY = "10" ]; then
	                        COUNT=500
				wait=1
        	        else
                         	COUNT=50
				wait=5
			fi


                #while [ $c -le 100 ]	#cien pruebas
#				while [ $c -le 100 ]		#Una prueba
				while [ $c -le 1 ]
				do
#				restart
				echo "=============================================================================="
				echo "="
				echo "=  Configurations: size: $SIZE , frecuency: $FRECUENCY , heartbeat: $HEARTBEAT , test: $c "
				echo "="
				echo "=============================================================================="


				# 4.lanzamos el producer
				#bash /home/jorlu/amqt2.sh $SIZE $FRECUENCY $COUNT $HEARTBEAT &
				bash /home/jorlu/amqt2.sh $SIZE $FRECUENCY $TESTLIFE $HEARTBEAT &

				echo "---->  AMQPerf in action  <----"

				while [ ! -f $fileWaiting ]
				do
					sleep 10
					echo "--- waiting to the end ---"
				done

				rm $fileWaiting
#				restart

				echo "End of test "

				# 9. kill java hang
				#bash /home/jorlu/killjava.sh
				(( c++ ))
			done
			c=1
		done
	done
done

echo "fin: " $(date) >> $fileReg
