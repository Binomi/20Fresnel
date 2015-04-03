reset
set terminal epslatex color
set output 'drehung_correlation.tex'
set xlabel 'Einfallswinkel $\alpha$ [$^\circ$]'
set ylabel 'Drehwinkel $\gamma$ [$^\circ$]'
set key top right

#set xrange [40:95]

rad(x)=x*pi/180
deg(x)=x*180/pi

n=1.51
n_1=1.51
a=48.6807 #50
b=a

set fit logfile 'drehung_correlation.log'

g(x)=deg(atan(-tan(rad(a))*cos(x-asin(sin(x)/n))/cos(x+asin(sin(x)/n))))-a
h(x)=(x<atan(n)) ? g(x)+180 : g(x)

i(x)=deg(atan(-tan(rad(b))*cos(x-asin(sin(x)/n_1))/cos(x+asin(sin(x)/n_1))))-b
j(x)=(x<atan(n_1)) ? i(x)+180 : i(x)
fit j(rad(x)) 'messwerte.csv' u 2:5:(0.2) via b,n_1


p 'messwerte.csv' u (h(rad($2))):5 t'$n=1.51$, $\delta$ gefittet',\
  'messwerte.csv' u (j(rad($2))):5 t'beide Parameter gefittet',\
  x

stats 'messwerte.csv' u (j(rad($2))):5

set output
!epstopdf drehung_correlation.eps
!rm drehung_correlation.eps
