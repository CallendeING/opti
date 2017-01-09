%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% IMPORTANTE                                                      %%%%% 
%%%%%                                                                 %%%%%
%%%%% Leer:                                                           %%%%%
%%%%% En el grafico no se aprecian las curvas de nivel                %%%%%
%%%%% que pasan por el punto 1,-3 (segunda iteracion),                %%%%%
%%%%% pues al extender el tamaño del plano, no se alcanzan            %%%%%
%%%%% a apreciar, ya que son muy pequeñas.                            %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clf
syms o p 
format long

x0 = -1; y0 = 1;
veces = 100;
i = 1;

%[x,y]= meshgrid(-1.1:0.1:1.1); % para poder ver todas las curvas borrar esta linea y usar la siguiente (21)
[x,y]= meshgrid(-3.1:0.1:3.1);
z = (x-1).^2 + 10*(x.^2 - y ).^2;

%mesh (x,y,z) %con este codigo se grafica la funcion en 3 dimensiones
%hold on

contourf (x,y,z,60)
hold on

while norma (x0,y0) >= 10^-5 && veces > 0 
    % Agregar los datos de cada iteracion
    VariableX(i,1)=x0;
    VariableY(i,1)=y0;
    Gradiente(i,1)=norma(x0,y0);
    funcionhes = (o-1)^2 + 10*(o^2 - p )^2;
    funcionhes(o,p) = inv(hessian(funcionhes,[o,p]));
    funcionHesEval = funcionhes(x0,y0);
    gradF(1,1) = fprimax(x0,y0);
    gradF(2,1) = fprimay(x0,y0);
    resHxG = funcionHesEval*gradF;
    x0 = x0 - resHxG(1,1);
    y0 = y0 - resHxG(2,1);
    veces = veces - 1;
    i = i+1;
end
% Agregar el ultimo valor
VariableX(i,1)=x0;
VariableY(i,1)=y0;
Gradiente(i,1)=norma(x0,y0);
% Graficar
plot(VariableX,VariableY,'y')
Punto=[1:i]';
table(Punto,VariableX,VariableY,Gradiente)
