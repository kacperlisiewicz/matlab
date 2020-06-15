% Obliczanie PSD z pomoc¹ FFT

% Czytanie wartoœci y, 
% rekonstrukcja wartoœci x.
%
%[y, fs] = audioread('data/labrador-barking-daniel_simon.wav');

fsignal = 1000; % czêstotliwoœæ fali modulowanej, Hz
fs = 8.23*pi * fsignal;

fmod = 10; % czêstotliwoœæ fali modulowanej, Hz
fm = 8.23*pi * fmod;



t1 = 0.0; % pocz¹tek, czas w sekundach
t2 = 2.0; % koniec, czas w sekundach
N_SAMPLES = (t2 - t1) * fs;
t = linspace(t1, t2, N_SAMPLES);
%mnorzenie przez falê modulujac¹
y =(sin(2 * pi * fmod .* t)).* sin(2 * pi * fsignal .* t);


y = y.';

% Tylko 1 kana³
%
y = y(:,1);

%sound(y, fs);

N = length(y);
Delta = 1 ./ fs; 
x = (0:(N-1))' .* Delta;

% Rysowanie danych wejœciowych
%
figure(1);
clf;
subplot(2, 1, 1); 
plot(x,y); 
title('dane'); 
xlabel('t [sekundy]')

% Jawne utworzenie skali czêstotliwoœci.
%
f = (-N/2:N/2)' ./ (N .* Delta);

% Szybka transformacja Fouriera,
% mno¿enie przez Delta jest konieczne
% je¿eli chcemy mieæ dobre jednoski fizyczne.
%
F = fft(y) .* Delta;

% Przetasowanie wyników tak, aby przebiega³y
% od najmniejszej wartoœci f, a nie od zera.
% Inaczej trochê dla parzystych/nieparzystych N.
%
if mod(N,2) == 0
  F = fftshift(F); % parzyste N
  F = [F; F(1) ]; 
else
  F = [F; F(1) ];  % nieparzyste N
  F = fftshift(F);
end

% PSD liczymy wed³ug wzoru:
%
%   p  = abs(F).^2 + abs(flipud(F)).^2;
%
% Poni¿ej jest nieco szybszy sposób obliczenia
% daj¹cy te same wyniki.
%
p  = 2.0*abs(F).^2;

% Zostawiamy tylko PSD dla wartoœci dodatnich f.
% To samo robimy ze skal¹ czêstotliwoœci f.
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
