%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% IMPORTANTE                                                      %%%%% 
%%%%%                                                                 %%%%%
%%%%% Leer:                                                           %%%%%
%%%%% En la cantidad de iteraciones hemos hecho que sean 4            %%%%%
%%%%% debido a que si sobrepasa este numero el programa               %%%%%
%%%%% se empieza a demorar cada vez mas por iteracion                 %%%%%
%%%%%                                                                 %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clf
syms o p 

x0 = -1; y0 = 1;
veces = 4;
i = 1;

[x,y]= meshgrid(-1:0.1:1);
z = (x-1).^2 + 10*(x.^2 - y ).^2;
%mesh (x,y,z) %con este codigo se grafica la funcion en 3 dimensiones
%hold on

contourf (x,y,z,60)
hold on


while norma(x0,y0) >= 10^-5 && veces > 0 
    % Agregar los datos de cada iteracion para crear la tabla
    VariableX(i,1)=x0;
    VariableY(i,1)=y0;
    Gradiente(i,1)=norma(x0,y0);
    funcionhes = (o-1)^2 + 10*(o^2 - p )^2;
%     funcionhes(o,p) = inv(hessian(funcionhes,[o,p]));
%     funcionHesEval = funcionhes(x0,y0);
    funcionhes = (hessian(funcionhes,[o,p]));
    matrizAux(1,1)=funcionhes(2,2);matrizAux(1,2)=-funcionhes(1,2);matrizAux(2,1)=-funcionhes(2,1);matrizAux(2,2)=funcionhes(1,1);
    invHes(o,p) = (1/(funcionhes(1,1)*funcionhes(2,2)-funcionhes(1,2)*funcionhes(2,1)))*matrizAux;
    funcionHesEval = invHes(x0,y0);
    gradF(1,1) = fprimax(x0,y0);
    gradF(2,1) = fprimay(x0,y0);
    resHxG = funcionHesEval*gradF;
    tk=fminbnd(@(x)(((x0-x*resHxG(1,1))-1).^2 + 10*((x0-x*resHxG(1,1)).^2 - (y0-x*resHxG(2,1))).^2),0,0.1);
    x0 = x0 - tk * resHxG(1,1);
    y0 = y0 - tk * resHxG(2,1);
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