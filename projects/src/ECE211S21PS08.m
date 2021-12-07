% Simon Yoon ECE211S21PS08 

clc
clear
close all

%% Q1


alpha = 0.544;
nu = 5;
N = 1e6;
scale = nu/(nu-2)
students = scale*trnd(nu,1,N);
gaussian = 1*randn(1,N);
cauchy = alpha*tan(pi*randn(1,N));
gaussianFrac = comp(gaussian, "Gaussian")
cauchyFrac = comp(cauchy, "Cauchy")
studentsFract = comp(students, "Students' T")

%% Q2


num = [2 0.2 -0.84];
den = [1 -0.95 0.9];
N2 = 1e5
v = 1*randn(1,N2);
m0 = 5;
x = filter(num,den,v);
Nlen = 1000;
h = impz(num,den, Nlen);
r = conv(h,flipud(h));
r = r(Nlen:Nlen+m0);

%% Q3


zplane(num,den)
freqz(num,den)

%% Q4


M = m0 + 1;
C = x(1:M);
R = x(1:N2);
A = toeplitz(C,R);

%% Q5


R = 1/(N2-m0)*(A*A');
[eigVec,eigVal0] = eig(R);
[eigVal, idx] = sort(diag(eigVal0), 'descend');
Q = eigVec(:,idx);

%% Q6


[s_est,w] = pwelch(x, hamming(512),256,512);
s_est = mag2db(s_est/mean(s_est));
H = freqz(num,den,length(w));
s = abs(H).^2;
s = mag2db(s/mean(s));

plot(w./pi,s_est)
hold on
plot(w./pi,s)
hold off
xlim([0,1]);
title("Theoretical vs Actual PSD of WSS Signal");
legend("s_{est}", "S_x(\omega)");
xlabel("w/\pi");
ylabel("PSD (dB)");

%% Q7


poleAngles = angle(roots(den))
[peak,idx2] = max(s);
freqPeak = w(idx2);
freqPeak

%% Q8


C = x(m0+1:-1:1);
R = x(m0+1:1e5);
A = toeplitz(C,R);
[U,S,V] = svd(A,'econ');
S = diag(S);

%% Q9


R = 1/(N-m0)*(A*A.');
eigenValR = 1/(N-m0)*(S.^2);
QU = abs(Q'*U)
err = QU - eye(m0+1,m0+1);
errmax= max(abs(err(:)))

%%
function frac = comp(distrib, name)
    g = abs(distrib)>=4;
    count = distrib(g);
    frac = length(count)/length(distrib);
    figure 
    plot(distrib);
    yline(-4, 'LineStyle', '--')
    yline(4, 'LineStyle', '--');
    title(name + " " + "Distribution")
    xlabel("N samples")
    ylabel("Distribution Values")
end