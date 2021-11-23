clc, clear, close;
% Equipo 1:

% Integrantes:
% Carlos David Sandoval Vargas / A00834448
% Eliezer Cavazos Rochin / A00835194
% Jorge Alejandro Nuñez Gurrola / A00833455
% Irving Yael Agramón Leal / A00833135
% Daniel Noé Salinas Sánchez / A01704062

%-----------------------------------------------------------------
% Solución defunción cubica a partir de 4 puntos
%-----------------------------------------------------------------

% Puntos: (10, 290), (79, 316), (164, 160), (260, 180)

% Creamos la matriz que contiene los coeficientes elevados a su respectiva
% potencia según la función cubica
Matriz_X = [1000, 100, 10, 1; 493039, 6241, 79, 1; 4410944, 26896, 164, 1; 17576000, 67600, 260, 1];

% Creamos otra matriz que contiene todos los valores de Y
Matriz_Y = [290; 316; 160; 180];

% Usamos la función linsolve() para obtener los valores de las variables
Matriz_Resuelta = linsolve(Matriz_X, Matriz_Y);

%Almacenamos cada uno de los valores en variables separadas
a = Matriz_Resuelta(1);
b = Matriz_Resuelta(2);
c = Matriz_Resuelta(3);
d = Matriz_Resuelta(4);

% Desplegar la función
disp(['Valor de a = ', num2str(a)]);
disp(['Valor de b = ', num2str(b)]);
disp(['Valor de c = ', num2str(c)]);
disp(['Valor de d = ', num2str(d)]);

funcion = 'Y = ' + string(a) + 'x^3 + ' + string(b) + 'x^2 + ' + string(c) + 'x + ' + string(d);
disp(funcion);

%-----------------------------------------------------------------
% Máximos y Mínimos
%-----------------------------------------------------------------

%funcion
f1 = @(x) a * x.^3 + b * x.^2 + c * x + d;

%Primera derivada
f2 = @(x) 3 * a * x.^2 + 2 * b*x + c;

%Segunda derivada
f3 = @(x) 6 * a * x + 2 * b;

%Puntos maximos y minimo
xMax = (- b - sqrt(b^2 - 3  *a *c)) / (3 * a);
xMin = (- b + sqrt(b^2 - 3 * a*c)) / (3 * a);

yMax = f1(xMax);
yMin = f1(xMin);

% Desplegar los valores del punto máximo y mínimo
disp(' ')
disp(['Punto máximo = ', '(', num2str(xMax), ', ', num2str(yMax), ')']);
disp(['Punto mínimo = ', '(', num2str(xMin), ', ', num2str(yMin), ')']);

%-----------------------------------------------------------------
% Longitud de la curva
%-----------------------------------------------------------------

% Calculamo la longitud de la curva utilizando la siguiente función
len = @(x) sqrt(1 + f2(x).^2);
longitudCurva = integral(len, 10, 260);

% Desplegar el resultado de la longitud de curva
disp(' ');
disp(['Longitud de la curva:  ', num2str(longitudCurva)]);


%-----------------------------------------------------------------
% Radio de la curvatura
%-----------------------------------------------------------------

%Radio de la curvatura
r_curv = @(x) ((1 + (f2(x).^2)).^(3/2))/abs(f3(x));

%Calculamos la curvatura en el máximo y mínimo
c_max = r_curv(xMax);
c_min = r_curv(xMin);

% Desplegamos los valores de ambos radios
disp(' ');
disp(['Radio en el punto máximo = ', num2str(c_max)]);
disp(['Radio en el punto mínimo = ', num2str(c_min)]);

%-----------------------------------------------------------------
% Graficación
%-----------------------------------------------------------------

figure('Name', ' Función cúbicca', 'NumberTitle', 'off');
xlabel('Eje x (m)');
ylabel('Eje y (m)');

%Graficamos los círculos y radios
viscircles([xMax (f1(xMax)-c_max)], c_max);
viscircles([xMin (f1(xMin)+c_min)], c_min);
line([xMin xMin], [f1(xMin) (f1(xMin)+c_min)]);
line([xMax xMax], [f1(xMax) (f1(xMax)-c_max)]);

% Graficamos las 3 funciones que obtuvimos 
hold on;
fplot(f1); 
fplot(f2); 
fplot(f3);

% Grafica el punto máximo y el punto mínimo
plot(xMax, yMax, '*')
plot(xMin, yMin, '*')

% Graficamos los puntos iniciales
plot(10, 290, 'o');
plot(79, 316, 'o');
plot(164, 160, 'o');
plot(260, 180, 'o');

%Intervalos de la zona critica
i_crit = [0];
for i = 0:1:280
   if (r_curv(i) > 50 && r_curv(i+1) < 50) || (r_curv(i) < 50 && r_curv(i+1) > 50)
       disp("Intervalo critico: " + i)
       i_crit = [i_crit, i];
   end
end
i_crit = [i_crit, 280];
sw = 0;

%Ploteamos los intervalos
for i = 1:1:size(i_crit,2)-1
   if sw == 1
       fplot(f1, [(i_crit(i)) (i_crit(i+1))], Color='#0000FF')
   end
   if sw == 0
       fplot(f1, [(i_crit(i)) (i_crit(i+1))], Color='#FF0000')
   end
   plot(i_crit(i), f1(i_crit(i)),'o',Color='#0000FF')
   sw = 1 - sw;
end

% %Recta tangnete
xpendmin = 3 * a * xMin^2 + 2 * b*xMin + c;
ytang = @(x) xpendmin .* (x - xMin) + yMin;
hold on;
fplot(ytang);

xpendmax = 3 * a * xMax^2 + 2 * b*xMax + c;
ytang = @(x) xpendmax .* (x - xMax) + yMax;
hold on;
fplot(ytang);


% % Ubicacion de las gradas 
%Coordenadas de las gradas en el punto mínimo
gInicioMin = [xMin - 40,yMin - 20];
gFinMin = [xMin + 40, yMin - 20];

%Coordenadas de las gradas en el punto máximo
gInicioMax = [xMax - 40,yMax + 20];
gFinMax = [xMax + 40, yMax + 20];

%Gráfica de las gradas
hold on;
plot([gInicioMin(1),gFinMin(1)],[gInicioMin(2),gFinMin(2)],'r');
hold on;
plot([gInicioMax(1),gFinMax(1)],[gInicioMax(2),gFinMax(2)],'r');