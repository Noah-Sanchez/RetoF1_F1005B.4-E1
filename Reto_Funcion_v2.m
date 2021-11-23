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

%fplot(f1);hold on;
%fplot(f2);hold on;
%fplot(f3);hold on;

%Puntos maximos y minimo
xmax = (-b - sqrt(b^2-3*a*c))/(3*a);
xmin = (-b + sqrt(b^2-3*a*c))/(3*a);

display("La posicion x del maximo es "+xmax);
display("La posicion x del minimo es "+xmin);

%Longitud de la curva

long = @(x) sqrt(1 + f2(x).^2);
longitud = integral(long,0,3);
display("La longitud de la curva es de: " + longitud);

%Radio de la curvatura
radio = @(x) (long(x).^3)/abs(f3(x));
r_max = radio(xmax);

display("El radio de la curvatura en el punto maximo es: "+ r_max);

%fplot(radio);hold on;
axis equal;
% Graficamos los puntos iniciales
%plot(10, 290, 'o');
%plot(79, 316, 'o');
%plot(164, 160, 'o');
%plot(260, 180, 'o');

%Graficamos el maximo y minimo
plot(xmax, f1(xmax), 'o');
plot(xmin, f1(xmin), 'o');


%Radio de la curvatura
r_curv = @(x) ((1 + (f2(x).^2)).^(3/2))/abs(f3(x));

%Calculamos la curvatura en el maximo y minimo
c_max = r_curv(xmax);
c_min = r_curv(xmin);

%Graficamos los circulos y radios
%viscircles([xmax (f1(xmax)-c_max)], c_max);
%viscircles([xmin (f1(xmin)+c_min)], c_min);

%line([xmin xmin], [f1(xmin) (f1(xmin)+c_min)]);
%line([xmax xmax], [f1(xmax) (f1(xmax)-c_max)]);

%Intervalos de la zona critica
i_crit = [0];
for i = 0:1:280
    if (r_curv(i) > 50 && r_curv(i+1) < 50)
        disp("Intervalo critico empieza: (" + i + ", " + f1(i) + ")")
        i_crit = [i_crit, (i+1)];
    elseif (r_curv(i) < 50 && r_curv(i+1) > 50)
        disp("Intervalo critico termina: (" + i + ", " + f1(i) + ")")
        disp(" ")
        i_crit = [i_crit, (i+1)];
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

xlabel("Eje X")
ylabel("Eje Y")


%Recta Tangente
g_x = [];
g_y = [];
for i = 0:1:280
m = f2(i);
tang = @(x) (m*(x-i)) + f1(i);
di=0;
d = 0;
while d < 20
    di = di + 0.1;
    d = sqrt(((i-(i+di))^2)+((f1(i)-tang(i+di)))^2);
end
g_x = [g_x, i+di];
g_y = [g_y, tang(i+di)];
end
plot(g_x, g_y)

