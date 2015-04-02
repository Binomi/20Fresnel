reset
set terminal epslatex color
set output 'drehung.tex'
set xlabel 'Einfallswinkel $\alpha$ [$^\circ$]'
set ylabel 'Drehwinkel $\gamma$ [$^\circ$]'
set key top right

set xrange [40:95]

rad(x)=x*pi/180
deg(x)=x*180/pi

n=1.51

set fit errorvariables
set fit logfile 'drehung.log'


g(x)=deg(atan(-cos(x-asin(sin(x)/n))/cos(x+asin(sin(x)/n))))-45
h(x)=(x<atan(n)) ? g(x)+180 : g(x)

i(x)=deg(atan(-cos(x-asin(sin(x)/n_1))/cos(x+asin(sin(x)/n_1))))-45
j(x)=(x<atan(n_1)) ? i(x)+180 : i(x)
fit j(rad(x)) 'messwerte.csv' u 2:5:(0.2) via n_1

p 'messwerte.csv' u 2:5:(0.2) w e t'Messwerte',\
  h(rad(x)) t 'Theoriekurve' lt -1,\
  j(rad(x)) t 'Theorie gefittet'

set output
!epstopdf drehung.eps
!rm drehung.eps

#========================================================================
reset
set terminal epslatex color
set output 'drehung_zoom.tex'
set xlabel 'Einfallswinkel $\alpha$ [$^\circ$]'
set ylabel 'Drehwinkel $\gamma$ [$^\circ$]'
set key top right

set xrange [40:95]

rad(x)=x*pi/180
deg(x)=x*180/pi

n=1.51

set fit errorvariables
set fit logfile 'drehung_zoom.log'

g(x)=deg(atan(-cos(x-asin(sin(x)/n))/cos(x+asin(sin(x)/n))))-45
h(x)=(x<atan(n)) ? g(x)+180 : g(x)

i(x)=deg(atan(-cos(x-asin(sin(x)/n_1))/cos(x+asin(sin(x)/n_1))))-45
j(x)=(x<atan(n_1)) ? i(x)+180 : i(x)
fit j(rad(x)) 'messwerte.csv' u 2:5:(0.2) via n_1

set xrange [46:61]

f(x)=m*x+b
fit f(x) 'messwerte.csv' u 2:5:(0.2) via m,b

set print 'brewster_graphisch.dat'
print m,m_err
print b,b_err
print (45-b)/m
print sqrt((b_err/m)**2+(m_err*(45-b)/m**2)**2)

set print 'brewster_punkt.dat'
print (45-b)/m,45,sqrt((b_err/m)**2+(m_err*(45-b)/m**2)**2)
set print

#set xrange [48:62]
#set yrange [38:52]

p 'messwerte.csv' u 2:5:(0.2) w e t'Messwerte',\
  f(x) t 'lineare Regression',\
  j(rad(x)) t 'Theorie gefittet',\
  h(rad(x)) t 'Theoriekurve' lt 0,\
  'brewster_punkt.dat' u 1:2:3 w xe lt -1 t 'Brewster-Winkel'

set output
!epstopdf drehung_zoom.eps
!rm drehung_zoom.eps

#========================================================================

reset
set terminal epslatex color
set output 'drehung2.tex'
set xlabel 'Einfallswinkel $\alpha$ [$^\circ$]'
set ylabel 'Drehwinkel $\gamma$ [$^\circ$]'
set key top right

set xrange [40:95]

rad(x)=x*pi/180
deg(x)=x*180/pi

n=1.51

set fit errorvariables
set fit logfile 'drehung2.log'

f(x)=m*x+b
fit f(x) 'messwerte.csv' u 2:6:(0.2) via m,b


g(x)=deg(atan(-cos(x-asin(sin(x)/n))/cos(x+asin(sin(x)/n))))-45
h(x)=(x<atan(n)) ? g(x)+180 : g(x)

i(x)=deg(atan(-cos(x-asin(sin(x)/n_1))/cos(x+asin(sin(x)/n_1))))-45
j(x)=(x<atan(n_1)) ? i(x)+180 : i(x)
fit j(rad(x)) 'messwerte.csv' u 2:6:(0.2) via n_1

p 'messwerte.csv' u 2:6:(0.2) w e t'Messwerte',\
   h(rad(x)) lt -1 t 'Theoriekurve'
# j(rad(x)) t 'Theorie gefittet'
# f(x) t 'lineare Regression',\

print m,b
print (45-b)/m

set output
!epstopdf drehung2.eps
!rm drehung2.eps
