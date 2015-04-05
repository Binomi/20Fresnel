reset
set terminal epslatex mono
set output 'drehung_disk.tex'
set xlabel 'Einfallswinkel $\alpha$ [$^\circ$]'
set ylabel 'Drehwinkel $\gamma$ [$^\circ$]'
set key top right

set xrange [40:95]

rad(x)=x*pi/180
deg(x)=x*180/pi

n=1.51
n_1=1.51
a=48.6807 #50

set fit logfile 'drehung_disk.log'

g(x)=deg(atan(-tan(rad(a))*cos(x-asin(sin(x)/n))/cos(x+asin(sin(x)/n))))-a
h(x)=(x<atan(n)) ? g(x)+180 : g(x)

i(x)=deg(atan(-tan(rad(a))*cos(x-asin(sin(x)/n_1))/cos(x+asin(sin(x)/n_1))))-a
j(x)=(x<atan(n_1)) ? i(x)+180 : i(x)
fit j(rad(x)) 'messwerte.csv' u 2:5:(0.2) via a


p 'messwerte.csv' u 2:5:(0.2) w e t'Messwerte',\
  h(rad(x)) t 'Theoriekurve' lt -1
  #j(rad(x)) t 'Fit'

set output
!epstopdf drehung_disk.eps
!rm drehung_disk.eps
