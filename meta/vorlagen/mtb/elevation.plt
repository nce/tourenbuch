# vim: set ft=gnuplot:
# -- [ Colors ] --
# MTB       Maroon      #AF3235
# Skitour   RoyalBlue   #006EB8
# Wandern   ForestGreen #009B55
# Alternat. Olivegreen  #3C8031
mtb         = "#AF3235"
skitour     = "#006EB8"
wandern     = "#009B55"
olivegreen  = "#3C8031"

mycolor = mtb
altcolor = olivegreen

# -- [ Scaling ] --
# MTB
mtbKM = 20
mtbHM = 0.235

# SKITOUR
skiKM = 75.2
skiHM = 0.376

# RENNRAD
rennradKM= 12.53
rennradHM = 0.313

# WANDERN
wandernKM = 44.97   # 17.99cm / 40km 
wandernHM = 0.225

myscaleKM = mtbKM
myscaleHM = mtbHM
# ---

file = 'gpxdata.txt'

reset
unset key
stats file u 3:2 nooutput
set xrange [STATS_min_x:STATS_max_x]
set yrange [STATS_min_y - 30:STATS_max_y]
set y2range [STATS_min_y - 30:STATS_max_y]

# Max Km mit Skalierungsfaktor. Den (fiktiven) Pixelwert von 300dpi auf cm umrechnen und den gesamten Skalierungsfaktor darauf mulitiplizieren.
# vielleicht nicht so ideal
w = floor(STATS_max_x * myscaleKM) * 2.54 / 300 * 2
# h = floor((STATS_max_y - STATS_min_y) * myscaleHM) * 2.54 / 300 * 2
# switch from 300 to 250 as small tours are getting dense 07.2016
h = floor((STATS_max_y - STATS_min_y) * myscaleHM) * 2.54 / 250 * 2

# -- [ Labels ] --
set label 1 '\textcolor{mtb}{TOP}' at STATS_pos_max_y,STATS_max_y point pointtype 7 ps 0.6 offset 0.3,0.3 front
# set label III '\textcolor{mtb}{NNN}' at XXX,YYY point pointtype 7 ps 0.6 offset 0.3,0.3 front
# set label III '\textcolor{mtb}{NNN}' at XXX,YYY point pointtype 7 ps 0.6 offset 0.3,0.3 front
# set label III '\textcolor{mtb}{NNN}' at XXX,YYY point pointtype 7 ps 0.6 offset 0.3,0.3 front
# set label III '\textcolor{mtb}{NNN}' at XXX,YYY point pointtype 7 ps 0.6 offset 0.3,0.3 front
# set label III '\textcolor{mtb}{NNN}' at XXX,YYY point pointtype 7 ps 0.6 offset 0.3,0.3 front
# set label III '\textcolor{mtb}{NNN}' at XXX,YYY point pointtype 7 ps 0.6 offset 0.3,0.3 front


# -- [ Terminal ] --
# epslates does not support transparency
# for mac xquartz is required to install epslatex https://xquartz.macosforge.org/landing/
# brew install gnuplot --cairo
set terminal cairolatex size w cm,h cm color
set output "elevation.tex"

# -- [ Grid and Tics ] --
set xtic 5
set xtic nomirror
unset border
set grid lt 0 dashtype 2 lw 3 lc rgb "black"
set format x "%g\\tiny\\,\\color{darkgray}{km}"

# ELEVATION SCALE ON THE RIGHT:
#set y2tics border 200
#set format y2 "%g\\tiny\\,\\color{darkgray}{m}"
# OR ON THE LEFT:
set ytics border 200 nomirror
set format y "%h\\tiny\\,\\color{darkgray}{m}"
# ---
# plot border: 1 bottom; 2 left
set border 3 lt 3 lw 3 lc rgb "#708090"

# correct the margin calculations which are based
# on the length of the format string, to a fixed value
set lmargin 4.8

set style fill transparent solid 0.45 noborder
plot file u 3:2 w filledcurve x1 lc rgb "black" , \
  file u 3:2 w lines lt 1 lw 5 lc rgb mycolor

