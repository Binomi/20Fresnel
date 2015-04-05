reset
set terminal epslatex mono
set output 'fresnelkoeff.tex'
set xlabel 'Einfallswinkel $\alpha$ [$^\circ$]'
set ylabel 'Reflexionskoeffizient $R$'
set key top right

set xrange [0:90]

rad(x)=x*pi/180
deg(x)=x*180/pi

n=1.51
y(x)=asin(sin(x)/n)

rs(x)=-sin(x-y(x))/sin(x+y(x))
rp(x)=tan(x-y(x))/tan(x+y(x))

p rs(rad(x))**2 lw 3 t 'senkrecht',\
  rp(rad(x))**2 lw 3 t 'parallel'

set output
!epstopdf fresnelkoeff.eps
!rm fresnelkoeff.eps
