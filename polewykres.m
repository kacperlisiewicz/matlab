% Przedmiot: Techniki Obliczeniowe 
% Kierunek studiów: Mechatronika 
% Semestr: 2
% Rok akademicki: 2019/2020
% Data (dzieñ-miesi¹c-rok): 05,06,2020
%
% Imiê:             Kacper
% Nazwisko:         Lisiewicz
% Numer albumu ZUT: 46758
%Indywydualna edycja graficzna wykresu
%Na wykresie zamiast t-ka rysowaæ 1/y

%Funkcje poczatkowe

f1_start = @(x)   2 + 1 ./ (1 + x.^2);
f2_start = @(x)   2 + sin(x);

%Funkcje do wyrysowania y'=1/y

f1 = @(x) 1./f1_start(x);
f2 = @(x) 1./f2_start(x);


a = 0;
b = 3.5;
N = 1000;

x = linspace(a, b, N);

figure(1);
clf;
plot(x, f1(x));
grid on;
grid minor;
hold on;
plot(x, f2(x));

% nazwanie osi i tytu³ wukresy
xlabel('x');
ylabel('y');
title({'Prezentacja pola miedzy wykresami funkcji';' 1/f1(x) i 1/f2(x)'});

f21 = @(x) f2(x) - f1(x);

for i = 1:(N-1)
    try
        xL = fzero(f21, [x(i), x(i+1)]);
        break
    catch
    end
end

for i = N:-1:2
    try
        xR = fzero(f21, [x(i-1), x(i)]);
        break
    catch
    end
end

xLR = linspace(xL, xR, N);
xRL = flip(xLR);

yLR = f2(xLR);
yRL = f1(xRL);

xi = [xLR, xRL];
yi = [yLR, yRL];

fill(xi, yi, 'y');

format long;
quadgk(f21, xL, xR)

