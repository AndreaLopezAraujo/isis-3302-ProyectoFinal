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
g('m1')=120;
g('m2')=36;
g('m3')=36;
g('m4')=55;
g('m5')=120;

parameter peso(h) peso;
peso(h)=999;
peso('t1')=1;
peso('t2')=2;
peso('t3')=3;
peso('t4')=4;
peso('t5')=5;
peso('t6')=6;
peso('t7')=7;
peso('t8')=8;
peso('t9')=9;
peso('t10')=10;
peso('t11')=11;
peso('t12')=12;
peso('t13')=13;
peso('t14')=14;
peso('t15')=15;

Variables
y(i,h)   si el paciente i esta en el hospital a la hora h
w(i,h,j) si el paciente i a la hora h le estan realizando el procedimiento j
u(j,h)   si se esta realizando el procedimiento j a la hora h
z        funcion objetivo;

Binary variable y;
Binary variable w;
Binary variable u;

Equations
funcionObjetivo     Funcion objetivo.
R1(i)               El paciente i�no puede estar en el hospital mas horas de lo que su gravedad lo permita.
R2(i)               El paciente i debe estar por lo menos el tiempo que el procedimiento j que requiere necesita.
R3(i,h)             El paciente i�esta esperando o se le esta realizando un procedimiento a la hora h
R4(h,i)             El paciente i�no puede encontrarse realizando mas de un procedimiento j�a la misma hora h.
R5(i,j)             Un paciente i�no le pueden empezar a realizar mas de una vez el procedimiento j. Esto es porque se asume que el procedimiento se tiene que hacer una unica vez.
R6(j,h)             Solo se puede hacer un procedimiento j a la hora h.
;


funcionObjetivo                      ..  z =e= sum((i,h),y(i,h)*peso(h));
R1(i)                                ..  g(i) =g= sum((h),y(i,h));
R2(i)                                ..  sum((h),y(i,h)) =g= sum((j),p(i,j));
R3(i,h)                              ..  y(i,h) =e= sum((j),w(i,h,j));
R4(h,i)                              ..  1 =g= sum((j),w(i,h,j));
R5(i,j)                              ..  p(i,j)=e= sum((h),w(i,h,j));
R6(j,h)                              ..  sum((i),w(i,h,j)) =e= u(j,h);






Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip minimizing z;

Display p;
Display g;
Display y.l;
Display u.l;
Display w.l;
Display z.l;
