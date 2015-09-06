% ARMA模型参数估计，已知噪声信号。p为AR阶数，q为MA阶数
function [B_est,A_est2] = ARMA_YuleEst(p,q,InputSignal,InputNoise,SignalLength)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    X=InputSignal(1:SignalLength,1);
    X=X';
    Noise=InputNoise(1:SignalLength,1);
    Noise=Noise';
    N=length(X);
    R=xcorr(X,'biased');
    Rxx=zeros(p,p);
    for k=0:p-1
        Rxx(:,k+1)=R(q+1-k+N:q+p-k+N);
    end
    R_right=-R(q+2+N:q+p+1+N);
    A_est=inv(Rxx)*R_right';
    R_nx=xcorr(Noise,X,'biased');
    R_4=zeros(1,q+1);
    for L=0:q
        for k=1:p
            R_4(L+1)=A_est(k)*R(L-k+N)+R_4(L+1);
        end
    end
    R_5=R(N:N+q)+R_4;
    Rxx_2=zeros(q+1,q+1);
    for L=0:q
       Rxx_2(:,L+1)=R_nx(N-L:N-L+q);
    end
    B_est=inv(Rxx_2)*R_5';
    A_est2(1)=1;
    A_est2(2:p+1)=A_est;
end