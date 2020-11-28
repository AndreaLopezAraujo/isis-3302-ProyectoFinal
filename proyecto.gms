* Proyecto final escenario 1
*

sets
i conjunto de pacientes /m1*m10/
j conjunto de procedimientos /t1*t4/
k conjunto de rol/r1*r3/;

*/i es jugadores, j es habilidades/
parameter h(i,j) habilidades;
h(i,j)=999;
h('m1','t1')=3;
h('m1','t2')=3;
h('m1','t3')=1;
h('m1','t4')=3;
h('m2','t1')=2;
h('m2','t2')=1;
h('m2','t3')=3;
h('m2','t4')=2;
h('m3','t1')=2;
h('m3','t2')=3;
h('m3','t3')=2;
h('m3','t4')=2;
h('m4','t1')=1;
h('m4','t2')=3;
h('m4','t3')=3;
h('m4','t4')=1;
h('m5','t1')=3;
h('m5','t2')=3;
h('m5','t3')=3;
h('m5','t4')=3;
h('m6','t1')=3;
h('m6','t2')=1;
h('m6','t3')=2;
h('m6','t4')=3;
h('m7','t1')=3;
h('m7','t2')=2;
h('m7','t3')=2;
h('m7','t4')=1;

*/i es jugadores, k es el rol/
parameter r(i,k) habilidades;
r(i,k)=999;
r('m1','r1')=1;
r('m1','r2')=0;
r('m1','r3')=0;
r('m2','r1')=0;
r('m2','r2')=1;
r('m2','r3')=0;
r('m3','r1')=1;
r('m3','r2')=0;
r('m3','r3')=1;
r('m4','r1')=0;
r('m4','r2')=1;
r('m4','r3')=1;
r('m5','r1')=1;
r('m5','r2')=0;
r('m5','r3')=1;
r('m6','r1')=0;
r('m6','r2')=1;
r('m6','r3')=1;
r('m7','r1')=1;
r('m7','r2')=0;
r('m7','r3')=1;

Variables
x(i) indica si el jugador i va a jugar o no
z      funcion objetivo;

Binary variable x;

Equations
funcionObjetivo(j) funcion objetivo.
R1                 El equipo titular debe tener 5 jugadores.
R2(k)              Por lo menos cuatro miembros deben ser capaces de jugar en la defensiva.
R3(k)              Por lo menos dos jugadores deben jugar como atacantes.
R4(k)              Al menos uno debe jugar en el centro.
R5(j)              El nivel promedio de control del bal?n del equipo titular tiene que ser por lo menos de dos.
R6(j)              El nivel promedio de disparo del equipo titular tiene que ser por lo menos de dos.
R7(j)              El nivel promedio de rebotes del equipo titular tiene que ser por lo menos de dos.
R8                 En el equipo titular debe estar el jugador dos o el jugador tres.;



funcionObjetivo(j)$(ord(j) =4)    ..  z =e= sum((i),h(i,j)*x(i));
R1                                ..  5 =e= sum((i),x(i));
R2(k)$(ord(k) =3)                 ..  4 =l= sum((i),r(i,k)*x(i));
R3(k)$(ord(k) =1)                 ..  2 =l= sum((i),r(i,k)*x(i));
R4(k)$(ord(k) =2)                 ..  1 =l= sum((i),r(i,k)*x(i));
R5(j)$(ord(j) =1)                 ..  2 =l= (sum((i),h(i,j)*x(i)))/5;
R6(j)$(ord(j) =2)                 ..  2 =l= (sum((i),h(i,j)*x(i)))/5;
R7(j)$(ord(j) =3)                 ..  2 =l= (sum((i),h(i,j)*x(i)))/5;
R8                                ..  1 =e= x('m2')+x('m3');




Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip maximizing z;

Display h;
Display r;
Display x.l;
Display z.l;
