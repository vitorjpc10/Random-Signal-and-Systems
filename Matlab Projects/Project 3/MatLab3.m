clear all; 
close all;
clc;

N = 32;
N2 = N * 2; 

omega = -pi:(2*pi/1000):pi;

Numerator = 1;
Denominator = 1+(0.5)*exp(-j.*omega) + 0.2*exp(-2*j*omega);

H=Numerator./Denominator;
h=ifft(H,32);

clf
stem(-3:N-1, [ 0 0 0 h(1:N) ], 'k')
hold on
plot([ -5 35], [0 0], 'k')

xlabel('Time in samples')
ylabel('Magnitude')
title('Impulse Response')

figure
plot(omega, H, 'k')
axis ([ -4 4 0 2] )

xlabel('Normalized Frequency in rad')
ylabel('Magnitude')
title('Maginitude of the Frequency Response')