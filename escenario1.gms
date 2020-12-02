* Proyecto final escenario 1
* Andrea Carolina López-201531591 y Gabriel Cubillos Bolivar-201729365

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

* Duración
parameter d(j) duración;
d(j) = 1;

* Cantidad máxima de procedimientos en simultáneo
parameter u(j) núm máximo de procedimientos j en J que se pueden realizar de manera simultánea en el hospital.;
u(j)=2; 

Variables
y(i,h)   si el paciente i esta en el hospital a la hora h
z(i,h,j) si el paciente i a la hora h le estan realizando el procedimiento j
f        funcion objetivo;

Binary variable y;
Binary variable z;

Equations
funcionObjetivo     Funcion objetivo.
R1(i)               El paciente i∈I no puede estar en el hospital más horas de lo que su gravedad lo permita.
R2(i)               El paciente i∈I debe estar por lo menos el tiempo que el procedimiento j∈J que requiere necesita.
R3(i,h)             El paciente i∈I no le pueden realizar un procedimiento j∈J a la hora h∈H si no se encuentra en el hospital.
R4(h,i)             El paciente i∈I no puede encontrarse realizando más de un procedimiento j∈J a la misma hora h∈H.
R5(i,j)             Cada paciente i∈I debe durar en el procedimiento j∈J la duración correspondiente al procedimiento.
R6(j,h)             Indica el número límite de veces que el procedimiento j∈J se puede realizar de manera simultánea en el hospital.
;


funcionObjetivo                      ..  f =e= sum((i,h),y(i,h));
R1(i)                                ..  sum((h),y(i,h)) =l= g(i);
R2(i)                                ..  sum((h),y(i,h)) =g= sum((j),p(i,j)*d(j));
R3(i,h)                              ..  sum((j),z(i,h,j)) =l= y(i,h);
R4(h,i)                              ..  sum((j),z(i,h,j)) =l= 1;
R5(i,j)                              ..  p(i,j)*d(j) =e= sum((h),z(i,h,j));
R6(j,h)                              ..  sum((i),z(i,h,j)) =l= u(j);






Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip minimizing f;

Display p;
Display g;
Display y.l;
Display z.l;
Display f.l;
