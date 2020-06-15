% Przedmiot: Techniki Obliczeniowe 
% Kierunek studiów: Mechatronika 
% Semestr: 2
% Rok akademicki: 2019/2020
% Data (dzień-miesiąc-rok): 15,06,2020
%
% Imię:             Kacper
% Nazwisko:         Lisiewicz
% Numer albumu ZUT: 46758

% Polecenie
% Modulacja AM

% Obliczanie PSD z pomocą FFT

% Czytanie wartości y, 
% rekonstrukcja wartości x.


fsignal = 1000; % częstotliwość fali modulowanej, Hz
fs = 8.23*pi * fsignal;

fmod = 10; % częstotliwość fali modulowanej, Hz
fm = 8.23*pi * fmod;



t1 = 0.0; % początek, czas w sekundach
t2 = 2.0; % koniec, czas w sekundach
N_SAMPLES = (t2 - t1) * fs;
t = linspace(t1, t2, N_SAMPLES);
%mnorzenie przez falę modulujacą
y =(sin(2 * pi * fmod .* t)).* sin(2 * pi * fsignal .* t);


y = y.';

% Tylko 1 kanał
%
y = y(:,1);

%sound(y, fs);

N = length(y);
Delta = 1 ./ fs; 
x = (0:(N-1))' .* Delta;

% Rysowanie danych wejściowych
%
figure(1);
clf;
subplot(2, 1, 1); 
plot(x,y); 
title('dane'); 
xlabel('t [sekundy]')

% Jawne utworzenie skali częstotliwości.
%
f = (-N/2:N/2)' ./ (N .* Delta);

% Szybka transformacja Fouriera,
% mnożenie przez Delta jest konieczne
% jeżeli chcemy mieć dobre jednoski fizyczne.
%
F = fft(y) .* Delta;

% Przetasowanie wyników tak, aby przebiegały
% od najmniejszej wartości f, a nie od zera.
% Inaczej trochę dla parzystych/nieparzystych N.
%
if mod(N,2) == 0
  F = fftshift(F); % parzyste N
  F = [F; F(1) ]; 
else
  F = [F; F(1) ];  % nieparzyste N
  F = fftshift(F);
end

% PSD liczymy według wzoru:
%
%   p  = abs(F).^2 + abs(flipud(F)).^2;
%
% Poniżej jest nieco szybszy sposób obliczenia
% dający te same wyniki.
%
p  = 2.0*abs(F).^2;

% Zostawiamy tylko PSD dla wartości dodatnich f.
% To samo robimy ze skalą częstotliwości f.
%
p  = p(f >= 0);
pf = f(f >= 0);

% Rysujemy PSD po transformacji.
%
subplot(2, 1, 2); 
semilogx(pf, p, '-ro'); 
title('PSD'); 
xlabel('f [Hz]'); 
xlim([1, 10000]);
grid on;
grid minor;
