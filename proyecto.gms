* Proyecto final escenario 1
*

sets
i conjunto de pacientes /m1*m5/
j conjunto de procedimientos /n1*n6/
h conjunto de horas/t1*t24/;

*/i es pacientes, j es procedimientos/
parameter p(i,j) procedimientosA;
p(i,j)=0;
p('m1','n1')=1;
p('m1','n2')=1;
p('m1','n5')=1;
p('m1','n6')=1;
p('m2','n1')=1;
p('m2','n2')=1;
p('m2','n3')=1;
p('m2','n6')=1;
p('m3','n2')=1;
p('m3','n3')=1;
p('m3','n4')=1;
p('m3','n5')=1;
p('m3','n6')=1;
p('m4','n1')=1;
p('m4','n4')=1;
p('m5','n3')=1;

*/i es pacientes/
parameter g(i) gravedad;
g(i)=999;
g('m1')=15;
g('m2')=15;
g('m3')=15;
g('m4')=10;
g('m5')=8;

*/j es procedimiento/
parameter d(j) gravedad;
d(j)=999;
d('n1')=1;
d('n2')=5;
d('n3')=3;
d('n4')=1;
d('n5')=1;
d('n5')=3;

Variables
x(i,h)   si el paciente i esta esperando a que le realicen un procedimiento a la hora h
y(i,h)   si el paciente i esta en el hospital a la hora h
a(i,h,j) si el paciente i a la hora h le estan realizando el procedimiento j
u(j,h)   si se esta realizando el procedimiento j a la hora h
w(i,j)   cantidad de horas que ha estado el paciente i en el procedimiento  j
z        funcion objetivo;

Binary variable x;
Binary variable y;
Binary variable a;
Binary variable u;

Equations
funcionObjetivo     funcion objetivo.;



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
