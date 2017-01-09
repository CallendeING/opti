clear all
clf

format long

x0 = -1; y0 = 1;
veces = 100;
syms t;

[x,y]= meshgrid(-1:0.1:1);
z = (x-1).^2 + 10*(x.^2 - y ).^2;
%mesh (x,y,z) %con este codigo se grafica la funcion en 3 dimensiones
%hold on
contourf (x,y,z)
hold on

i = 1;
while norma(x0,y0) >= 10^-5 && veces > 0 
    % Agregar los datos de cada iteracion para crear la tabla
    VariableX(i,1)=x0;
    VariableY(i,1)=y0;
    Gradiente(i,1)=norma(x0,y0);    
    tk=fminbnd(@(x)((x0-x*fprimax(x0,y0)-1).^2 + 10*((x0-x*fprimax(x0,y0)).^2 - (y0-x*fprimay(x0,y0))).^2),0,0.1);
    x0 = x0 - tk * fprimax(x0,y0);
    y0 = y0 - tk * fprimay(x0,y0);
    veces = veces - 1;
    i = i+1;
end

% Agregar el ultimo dato
VariableX(i,1)=x0;
VariableY(i,1)=y0;
Gradiente(i,1)=norma(x0,y0);
% Graficar
plot(VariableX,VariableY,'y')
Punto=[1:i]';
table(Punto,VariableX,VariableY,Gradiente)