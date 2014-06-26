#!/bin/bash

file="/tmp/test/rates.txt"


while [ 0 -lt 1 ]
do
	date >> $file
	rabbitmqadmin list queues vhost name node messages message_stats.publish_details.rate >> $file
	sleep 30
done



#obtener el rate que se alcanzo en la prueba
less /tmp/test/rates.txt | grep amq.gen | awk '{print $10}'


