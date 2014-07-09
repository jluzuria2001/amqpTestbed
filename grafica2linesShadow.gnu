## 14/07/09
## Aqui graficamos 2 lineas del umbral de saturación del protocolo 
##

set terminal jpeg medium
set output "lost.jpeg"
#set term postscript eps color blacktext "Helvetica" 16

set xlabel 'message size (KBytes)'
set ylabel 'number of messages sent per second (#)'
set key bottom left
# set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 500, 350 
# set output 'fillbetween.2.png'
set style fill 	pattern 2 border
set style data 	lines
set title "The threshold limit of message loss is reached with different message size" 
set xrange [ 52 : 135 ] noreverse nowriteback
set yrange [ 0 : 58 ] noreverse nowriteback

### la una
#plot 'silver.dat' u 4:2:1 title "zone of lost" w filledcu, '' u 4:1 lt -1 notitle, '' u 4:2 lt -1 notitle

### la dos
#plot "silver.dat" u 3:1 title "no-lost" w linespoints, \
#     "silver.dat" u 4:1 title "lost" w linespoints


### el mix
## en fondo rojo
#plot "silver.dat" u 4:2:1 title "zone of lost" w filledcu, '' u 4:1 lt -1 notitle, '' u 4:2 lt -1 notitle, \
#	"silver.dat" u 3:1 title "lost" w linespoints

## en fondo verde
plot "silver.dat" u 3:1 title "free-loss limit" w linespoints, \
	"silver.dat" u 4:2:1 title "zone of lost" w filledcu, '' u 4:1 lt -1 notitle, '' u 4:2 lt -1 notitle

set output
