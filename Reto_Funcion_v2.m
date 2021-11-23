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

% Dibujamos las funciónes en una gráfica
figure('Name', ' Función cúbicca', 'NumberTitle', 'off');
hold on;
%funcion
f1 = @(x) a * x.^3 + b * x.^2 + c * x + d;

%Primera derivada
f2 = @(x) 3 * a * x.^2 + 2 * b*x + c;

%Segunda derivada
f3 = @(x) 6 * a * x + 2 * b;

fplot(f1);hold on;
fplot(f2);hold on;
fplot(f3);hold on;

%Puntos maximos y minimo
xmax = (-b - sqrt(b^2-3*a*c))/(3*a);
xmin = (-b + sqrt(b^2-3*a*c))/(3*a);

display("La posicion x del maximo es "+xmax);
display("La posicion x del minimo es "+xmin);

%Longitud de la curva

% Calculamos la longitud de la curva utilizando la siguiente función
len = @(x) sqrt(1 + f2(x).^2);
longitudCurva = integral(len, 10, 260); 

% Metodo del rectangulo
lim_inf = 10;
lim_sup = 260;

iteraciones = 1000;
ancho = (lim_sup - lim_inf) / iteraciones;
longitud = 0;

% Algoritmo rectángulo
for i = 0:(iteraciones - 1)
    longitud = longitud + ancho * sqrt(1 + f2(a + i * ancho)^2);
end

% Desplegar el resultado de la longitud de curva
disp(' ');
disp(['Longitud de la curva:  ', num2str(longitudCurva)]);

% Desplegar el resultado de la longitud de curva usando método del
% rectangulo
disp(['Longitud de la curva (método del rectángulo):  ', num2str(longitud)]);

% Calcular y desplegar la diferencia
diff = abs(longitudCurva - longitud);
disp(['Diferencia entre métodos: ', num2str(diff)]);


%Radio de la curvatura
radio = @(x) (len(x).^3)/abs(f3(x));
r_max = radio(xmax);

display("El radio de la curvatura en el punto maximo es: "+ r_max);

fplot(radio);hold on;

%Recta Tangente
pendienteMin =  3 * a * xmin^2 + 2 * b*xmin + c;
MinY = @(x) pendienteMin .* (x - xmin) + ymin;
hold on;
fplot(MinY);

pendienteMax = 3 * a * xmax^2 + 2 * b*xmax + c;
MaxY = @(x) pendienteMax .* (x - xmax) + ymax;
hold on;
fplot(MaxY);

% Ubicacion de las gradas 
%Coordenadas de las gradas en el punto mínimo
gInicioMin = [xmin - 40,yMin - 20];
gFinMin = [xmin + 40, yMin - 20];

%Coordenadas de las gradas en el punto máximo
gInicioMax = [xmax - 40,yMax + 20];
gFinMax = [xmax + 40, yMax + 20];

%Gráfica de las gradas
hold on;
plot([gInicioMin(1),gFinMin(1)],[gInicioMin(2),gFinMin(2)],'r');
hold on;
plot([gInicioMax(1),gFinMax(1)],[gInicioMax(2),gFinMax(2)],'r');

% Graficamos los puntos iniciales
plot(10, 290, 'o');
plot(79, 316, 'o');
plot(164, 160, 'o');
plot(260, 180, 'o');


