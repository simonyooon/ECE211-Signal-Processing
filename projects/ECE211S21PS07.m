% Simon Yoon ECE211S21PS07
clc
clear
close all
%% Part II

M = 100;
K = 10;
L = 3;
N = 200;
PdB = [0,-2,-4];
noisevar = -15;

[S,L,B,v,A] = matGen(M,N,K,PdB, noisevar);

     [U,sval,V] = svd(A);
     sval = diag(sval);
    
     R = (1/N)*(A*transpose(A));
    
     [eigvec, eigval0] = eig(R);
     [eigval, idx] = sort(diag(eigval0),'descend');
     eigvec = eigvec(:, idx);
   
     stem(sval);
     ps = U(:,1:L)*(U(:,1:L))';
     pn = eye(size(ps)) - ps; 
     Rinv = inv(R);
        
   smusic = zeros(1,L);
   smvdr = zeros(1,L);
   for m = 1:L 
       smusic(:,m) = 1/(transpose(S(:,m))*(pn)*S(:,m));
       smvdr(:,m) = 1/(transpose(S(:,m))*(Rinv)*S(:,m));
   end
   
   testCount = 20;
   
   for n = 1:testCount 
       i = randperm(M,K);
       Stheta(i,k) = 1/sqrt(K);
   end
   
   randSmusic  = zeroes
%% Part I

function [S,L,B,v,A] = matGen(M,N,K,PdB,noisevar)
    
    L = length(PdB);
    S = zeros(M,L);
    
        for j = 1:L 
            i = randperm(M,K);
            S(i,j)= 1/sqrt(K);
        end
        
    P = transpose(10.^(PdB./10));
    B = sqrt(P).*randn(L,N);
    
    noise = 10^(noisevar/10);
    v = sqrt(noise)*randn(M,N);
    
    A = S*B + v;
end