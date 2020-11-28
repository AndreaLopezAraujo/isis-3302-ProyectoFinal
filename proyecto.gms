* Proyecto final escenario 1
*

sets
i conjunto de pacientes /m1*m2/
j conjunto de procedimientos /n1*n6/
h conjunto de horas/t1*t15/;

*/i es pacientes, j es procedimientos/
parameter p(i,j) procedimientosA;
p(i,j)=0;
p('m1','n4')=1;
p('m1','n6')=1;
p('m2','n4')=1;

*/i es pacientes/
parameter g(i) gravedad;
g(i)=999;
g('m1')=15;
g('m2')=8;

*/j es procedimiento/
parameter d(j) duracion;
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
w(i,h,j) si el paciente i a la hora h le estan realizando el procedimiento j
u(j,h)   si se esta realizando el procedimiento j a la hora h
z        funcion objetivo;

Binary variable x;
Binary variable y;
Binary variable w;
Binary variable u;

Equations
funcionObjetivo     Funcion objetivo.
R1(i)               El paciente iÅno puede estar en el hospital mas horas de lo que su gravedad lo permita.
*R2(i)              El paciente i debe estar por lo menos el tiempo que el procedimiento j que requiere necesita.;
R3(i,h)             El paciente iÅesta esperando o se le esta realizando un procedimiento a la hora h
*R4(i,h)            El paciente i permanece horas consecutivas en el hospital desde el momento en el que llega
*R5(i,j)            Un paciente iÅno le pueden empezar a realizar mas de una vez el procedimiento j. Esto es porque se asume que el procedimiento se tiene que hacer una unica vez.
R6                  Solo se puede hacer un procedimiento j a la hora h.;


funcionObjetivo(j)                ..  z =e= sum((i,h),y(i,h));
R1(i)                             ..  g(i) =g= sum((h),y(i,h));
*R2(i)                             ..  sum((h),y(i,h)) =g= sum((j),p(i,j)*d(j));
R3(i,h)                           ..  y(i,h) =e= sum((j),w(i,h,j))+x(i,h);
*R4(j)$(ord(j) =1)                 ..  2 =l= (sum((i),h(i,j)*x(i)))/5;/
*R5(i,j)                           .. p(i,j)*d(j)=e= sum((h),w(i,h,j));
R6(j,h)                           .. sum((i),w(i,h,j))=e= u(j,h);





Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip minimizing z;

Display p;
Display g;
Display d;
Display x.l;
Display y.l;
Display u.l;
Display w.l;
Display z.l;
