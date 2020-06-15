% Obliczanie PSD z pomoc� FFT

% Czytanie warto�ci y, 
% rekonstrukcja warto�ci x.
%
%[y, fs] = audioread('data/labrador-barking-daniel_simon.wav');

fsignal = 1000; % cz�stotliwo�� fali modulowanej, Hz
fs = 8.23*pi * fsignal;

fmod = 10; % cz�stotliwo�� fali modulowanej, Hz
fm = 8.23*pi * fmod;



t1 = 0.0; % pocz�tek, czas w sekundach
t2 = 2.0; % koniec, czas w sekundach
N_SAMPLES = (t2 - t1) * fs;
t = linspace(t1, t2, N_SAMPLES);
%mnorzenie przez fal� modulujac�
y =(sin(2 * pi * fmod .* t)).* sin(2 * pi * fsignal .* t);


y = y.';

% Tylko 1 kana�
%
y = y(:,1);

%sound(y, fs);

N = length(y);
Delta = 1 ./ fs; 
x = (0:(N-1))' .* Delta;

% Rysowanie danych wej�ciowych
%
figure(1);
clf;
subplot(2, 1, 1); 
plot(x,y); 
title('dane'); 
xlabel('t [sekundy]')

% Jawne utworzenie skali cz�stotliwo�ci.
%
f = (-N/2:N/2)' ./ (N .* Delta);

% Szybka transformacja Fouriera,
% mno�enie przez Delta jest konieczne
% je�eli chcemy mie� dobre jednoski fizyczne.
%
F = fft(y) .* Delta;

% Przetasowanie wynik�w tak, aby przebiega�y
% od najmniejszej warto�ci f, a nie od zera.
% Inaczej troch� dla parzystych/nieparzystych N.
%
if mod(N,2) == 0
  F = fftshift(F); % parzyste N
  F = [F; F(1) ]; 
else
  F = [F; F(1) ];  % nieparzyste N
  F = fftshift(F);
end

% PSD liczymy wed�ug wzoru:
%
%   p  = abs(F).^2 + abs(flipud(F)).^2;
%
% Poni�ej jest nieco szybszy spos�b obliczenia
% daj�cy te same wyniki.
%
p  = 2.0*abs(F).^2;

% Zostawiamy tylko PSD dla warto�ci dodatnich f.
% To samo robimy ze skal� cz�stotliwo�ci f.
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
