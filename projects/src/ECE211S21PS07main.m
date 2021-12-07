% Simon Yoon ECE211S21PS07
clc
clear
close all
%% Part II

PdB = [0,-2,-4];

[S,L,B,v,A] = matGen(100,200,10,PdB, -15);

[U,sval,V] = svd(A);
sval = diag(sval);
    
R = (1/200)*(A*transpose(A));
    
[eigvec, eigval0] = eig(R);
[eigval, idx] = sort(diag(eigval0),'descend');
eigvec = eigvec(:, idx);

figure
stem(sval);
title('Singular Values of A')
    
ps = U(:,1:3)*(U(:,1:3))';
pn = eye(size(ps)) - ps; 
 
smusic = zeros(1,3);
smvdr = zeros(1,3);

   for m = 1:3 
       smusic(:,m) = 1/(transpose(S(:,m))*(pn)*S(:,m));
       smvdr(:,m) = 1/(transpose(S(:,m))*(inv(R))*S(:,m));
   end
   
test = 20;
   
   for n = 1:test
        i = randperm(100,10);
        stheta(i,n) = 1/sqrt(10); 
   end

pstheta = U(:, 1:test)*(U(:,1:test))';
pntheta = eye(size(pstheta)) - pstheta;

randsmusic = zeros(1, test);
randsmvdr = zeros(1,test);

    for j = 1:test
        randsmusic(:,j) = 1/(transpose(stheta(:,j))*(pntheta)*stheta(:,j));
    end

    for j = 1:L
        smvdr(:,j) = 1/(transpose(stheta(:,j))*(inv(R))*stheta(:,j));
    end

disp(sym('S_MUSIC'))
smusic
disp(sym('S_MUSIC_max_med'))
maxsmusic = max(randsmusic)
mediansmusic = median(randsmusic)

disp(sym('S_MVDR'))
smvdr
disp(sym('S_MVDR_max_med'))
maxsmvdr = max(randsmvdr)
mediansmvdr = median(randsmvdr)
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