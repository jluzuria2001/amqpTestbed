#!/bin/bash

#  recibe 1 parametro
#       $1 nombre del AP (e.g., Tplink o Alix) que vamos a apagar en primera instancia
#
# el comando completo seria por ejemplo: [$./amqtest.sh Tplink]
#     El mismo que apagaria el AP Tplink

# ./amqptest.sh Tplink
#                 $1


#--------------------------------funciones
echo $(date) > pruebaini.txt

fileResult="/tmp/results.txt"
fileWaiting="/tmp/fichero.txt"
fileVector="/tmp/results2.txt"

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


UpAlix() {
        echo "Starting up Alix"
        ssh root@10.0.1.2 "bash updown.sh UP"
}
DownAlix() {
        echo "Shutting down Alix"
        ssh root@10.0.1.2 "bash updown.sh DOWN"
}
UpTplink() {
        echo "Starting up Tplink"
        ssh root@10.0.1.1 "bash updown.sh UP"
}
DownTplink() {
        echo "Shutting down Tplink"
        ssh root@10.0.1.1 "bash updown.sh DOWN"
}


#--------------------------------------variables
COUNT=80
TESTLIFE=20

###------------------------------------void(main)
clear
# Apagamos todo
DownTplink
DownAlix

if [ "$1" = Alix ]; then
	ap1=Alix
	ap2=Tplink
else
	ap1=Tplink
	ap2=Alix
fi

c=1

for HEARTBEAT in 580; do
	echo "----------------------------------------------------------------Welcome to new test"
	for SIZE in 512 1024 3072 6144; do
       		for FRECUENCY in 10 100 500 1000; do

				if [ $FRECUENCY = "10" ]; then
                                        COUNT=500
					wait=1
                                else
                                        if [ $FRECUENCY = "100" ]; then
                                                COUNT=100        #para pruebas 100 mensajes de 512k
						wait=5
                                        else
                                                COUNT=50
						wait=10
                                        fi
                                fi


                        while [ $c -le 5 ]
			do
				echo "=============================================================================="
				echo "="
				echo "=  Configurations: size: $SIZE , frecuency: $FRECUENCY , heartbeat: $HEARTBEAT , test: $c "
				echo "="
				echo "=============================================================================="

#			        Down"$ap2"		# 1.apaga2
#			        Up"$ap1"		# 2.encender1
#			        sleep 5			# 3.esperar 5seg.

				# 4.lanzamos el producer
				#bash /home/jorlu/amqt2.sh $SIZE $FRECUENCY $COUNT $HEARTBEAT &

				bash /home/jorlu/amqt2.sh $SIZE $FRECUENCY $TESTLIFE $HEARTBEAT &

				echo "---->  AMQPerf in action  <----"

				#sleep 3	        # 5.esperar n-2 seg.
#				Up"$ap2"	        # 6.encender2
#				sleep $wait	        # 7.esperar 2 seg.
#				Down"$ap1"	        # 8.apaga1

				while [ ! -f $fileWaiting ]
	                     	do
					sleep 10
					echo "--- waiting to the end ---"
				done

				rm $fileWaiting

				echo "End of test "

				# 9. kill java hang
#				bash /home/jorlu/killjava.sh
				(( c++ ))
			done
			c=1
		done
	done
done

echo $(date) >> pruebaini.txt
