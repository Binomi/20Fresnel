reset
set terminal epslatex color
set output 'drehung.tex'
set xlabel 'Auftreffwinkel $\alpha$ [$^\circ$]'
set ylabel 'Drehwinkel $\gamma$ [$^\circ$]'
set key top right

rad(x)=x*pi/180
deg(x)=x*180/pi

n=1.51

f(x)=m*x+b
fit f(x) 'messwerte.csv' u 2:5:(0.2) via m,b


g(x)=deg(atan(-cos(x-asin(sin(x)/n))/cos(x+asin(sin(x)/n))))-45
h(x)=(x<atan(n)) ? g(x)+180 : g(x)

i(x)=deg(atan(-cos(x-asin(sin(x)/n_1))/cos(x+asin(sin(x)/n_1))))-45
j(x)=(x<atan(n_1)) ? i(x)+180 : i(x)
fit j(rad(x)) 'messwerte.csv' u 2:5:(0.2) via n_1

p 'messwerte.csv' u 2:5:(0.2) w e t'Messwerte',\
  f(x) t 'lineare Regression',\
  h(rad(x)) t 'Theoriekurve',\
  j(rad(x)) t 'Theorie gefittet'

set output
!epstopdf drehung.eps
!rm drehung.eps
