* Proyecto final escenario 1
*

sets
i conjunto de pacientes /m1*m5/
j conjunto de procedimientos /n1*n6/
h conjunto de horas/t1*t15/;

*/i es pacientes, j es procedimientos/
parameter p(i,j) procedimientosA;
p(i,j)=0;
p('m1','n4')=1;
p('m1','n6')=1;
p('m2','n4')=1;
p('m3','n3')=1;
p('m4','n1')=1;
p('m4','n4')=1;
p('m4','n5')=1;
p('m5','n3')=1;
p('m5','n4')=1;
p('m5','n5')=1;

*/i es pacientes/
parameter g(i) gravedad;
g(i)=999;
g('m1')=15;
g('m2')=8;
g('m3')=8;
g('m4')=10;
g('m5')=15;

Variables
x(i,h)   si el paciente i esta esperando a que le realicen un procedimiento a la hora h
y(i,h)   si el paciente i esta en el hospital a la hora h
w(i,h,j) si el paciente i a la hora h le estan realizando el procedimiento j
u(j,h)   si se esta realizando el procedimiento j a la hora h
v(i)     se realizaron todos los procedimientos
z        funcion objetivo;

Binary variable x;
Binary variable y;
Binary variable w;
Binary variable u;
Binary variable v;

Equations
funcionObjetivo     Funcion objetivo.
R1(i)               El paciente iÅno puede estar en el hospital mas horas de lo que su gravedad lo permita.
R2(i)               El paciente i debe estar por lo menos el tiempo que el procedimiento j que requiere necesita.
R3(i,h)             El paciente iÅesta esperando o se le esta realizando un procedimiento a la hora h
R4(i,h)             El paciente i permanece horas consecutivas en el hospital desde el momento en el que llega
R5(h,i)             El paciente iÅno puede encontrarse realizando mas de un procedimiento jÅa la misma hora h.
R6(i,j)             Un paciente iÅno le pueden empezar a realizar mas de una vez el procedimiento j. Esto es porque se asume que el procedimiento se tiene que hacer una unica vez.
R7(j,h)             Solo se puede hacer un procedimiento j a la hora h.;


funcionObjetivo                      ..  z =e= sum((i,h),y(i,h));
R1(i)                                ..  g(i) =g= sum((h),y(i,h));
R2(i)                                ..  sum((h),y(i,h)) =g= sum((j),p(i,j));
R3(i,h)                              ..  y(i,h) =e= sum((j),w(i,h,j))+x(i,h);
R4(i,h)$(ord(h)<>1 or ord(h)<>15)    ..  y(i,h-1)+y(i,h+1) =l= x(i,h)+1;
R5(h,i)                              ..  1 =g= sum((j),w(i,h,j));
R6(i,j)                              ..  p(i,j)=e= sum((h),w(i,h,j));
R7(j,h)                              ..  sum((i),w(i,h,j)) =e= u(j,h);






Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip minimizing z;

Display p;
Display g;
Display x.l;
Display y.l;
Display u.l;
Display w.l;
Display z.l;
