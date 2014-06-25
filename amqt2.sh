#!/bin/bash

# lanzamos la prueba
# Producer recibe los parametros:
# $1 = tamaño del mensaje en este caso 1Kb
# $2 = frecuency
######### $3 = count
# $3 = testlife
# $4 = heartbeat

ssh usuario-grc@10.0.1.175 "bash amqp_ini.sh $1 $2 $3 $4"
#para ejecutarlo en local
#bash amqp_ini.sh $1 $2 $3 $4
