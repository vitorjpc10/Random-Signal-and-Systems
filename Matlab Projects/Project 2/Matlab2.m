clear

N = 1000;
xvar = 5; %variance of x
lag = 10;

randn('state',140);
x = sqrt(xvar)*randn(1, N+2); %i.i.d. Gaussian random variable

xn = x(3:N+2); %x(n)
xn1 = x(2:N+1); %x(n-1)
xn2 = xn1(1:N); %x(n-2)

y = xn + 0.5*xn1 + 0.2*xn2;

Ryy = zeros(1,2*N-1); %initialize

for k = -N+1:N-1
    ndx1 = max([1 1+k]) :min([N+k N]);
    ndx2 = max([1 1-k]) :min([N-k N]);
    Ryy(N+k) = sum(y(ndx1).*y(ndx2))./N; %autocorrelation
end

Rtrue = xvar*[0 0 1/5 3/5 129/100 3/5 1/5 0 0]; %true value of Ryy

M = 2*N-1;
w = -pi+pi/M:2*pi/M:pi; %frequency vector

Strue = xvar*((129/100)+(6/5)*cos(w)+(2/5)*cos(2*w));%true value of Syy
Syy_noisy = abs(fftshift(fft(Ryy))); %power spectral estimate

stp=100; %number of points to average
Syy = zeros(1,(M+1)/stp);

for i = 1:stp:M %smooth power spectrum estimate
    if i<(M+1)/2
        Syy((i-1)/stp+1) = mean(Syy_noisy(i:i+stp-1));
    else
        Syy((i-1)/stp+1) = mean(Syy_noisy(i-1:1+stp-2));
    end
end

clf
plot ([lag -3:3 lag], Rtrue, 'k')
hold
stem(-lag:lag,Ryy(N-lag:N+lag),'k')

xlabel('Lag')
ylabel('Magnitute')
title('Autocorrelation')

figure
plot(w,Syy_noisy(1:M),'k')
xlabel('Normalized Frequency(rad)')
ylabel('Magnitude')
title('Power Spectrum')

figure
plot(w(round(stp/2):stp:length(w)),Syy,'--k',w,Strue,'k')
xlabel('Normalized Frequency(rad)')
ylabel('Magnitude')
title('Power Spectrum')