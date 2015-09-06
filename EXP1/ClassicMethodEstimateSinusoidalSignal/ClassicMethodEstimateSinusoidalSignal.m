%FIleName: ClassicMethodEstimateSinusoidalSignal.m
%
%试用经典谱估计及其改进方法，由数据出发估计信号
%的功率谱，通过仿真评估其性能

%信号1：被高斯白噪声污染的两个正弦信号
%f1=0.21        SNR1=10dB
%f2=0.23        SNR2=15dB
%xk=a1*sin(2*pi*f1*k+p1)+a2*sin(2*pi*f2*k+p2)+wk
%p1,p2为[0,2*pi]均匀分布的随机数，wk为高斯白噪声
clear;
%% Experiment Parameters Settings
SampleNum=20000;        %设定信号采样点数
SineSigFreq1=0.21;      %设定正弦信号1的数字频率
SineSigSNR1=10;         %设定正弦信号1的信噪比dB
SineSigFreq2=0.23;      %设定正弦信号2的数字频率
SineSigSNR2=15;         %设定正弦信号2的信噪比dB
NoiseNorPow=0;          %设定噪声归一化功率dB
%% Initiation
SineSigAmp1=sqrt(10^((SineSigSNR1+NoiseNorPow)/10)/0.5);    %根据设定好的信噪比计算正弦信号1的幅度
SineSigAmp2=sqrt(10^((SineSigSNR2+NoiseNorPow)/10)/0.5);    %根据设定好的信噪比计算正弦信号2的幅度
PhaseShift1=2*pi*rand;
PhaseShift2=2*pi*rand;
NoiseSig=wgn(SampleNum,1,NoiseNorPow);                      %根据样点数和噪声功率产生噪声序列
Index=1;
while (Index<=SampleNum)                                    %根据正弦信号幅度，数字频率产生纯净信号
    InputPureSignal(Index,:)=SineSigAmp1*sin(2*pi*SineSigFreq1*(Index-1)+PhaseShift1) ...
                                    +SineSigAmp2*sin(2*pi*SineSigFreq2*(Index-1)+PhaseShift2);
    Index=Index+1;
end
InputSignal=InputPureSignal+NoiseSig;           %加入噪声产生实际信号
PowReal=mse(InputSignal);                       %实际信号功率

[P_IPDA_HANN_OL_64_PSD,P_IPDA_HANN_OL_64_FREQ,Num64]=ImpPeriodogramAver(InputSignal,64,16,8,'hann','db');
[P_IPDA_HANN_OL_256_PSD,P_IPDA_HANN_OL_256_FREQ,Num256]=ImpPeriodogramAver(InputSignal,256,32,16,'hann','db');
[P_IPDA_HANN_OL_512_PSD,P_IPDA_HANN_OL_512_FREQ,Num512]=ImpPeriodogramAver(InputSignal,512,64,32,'hann','db');
[P_IPDA_HANN_OL_2048_PSD,P_IPDA_HANN_OL_2048_FREQ,Num2048]=ImpPeriodogramAver(InputSignal,2048,256,128,'hann','db');

Index=1;
Ang=0;
while Ang<=1
    if fix(Ang*100)==SineSigFreq1*100||fix(Ang*100)==(1-SineSigFreq1)*100
        PSDStd(Index,1)=SineSigSNR1+NoiseNorPow;
    elseif fix(Ang*100)==SineSigFreq2*100||fix(Ang*100)==(1-SineSigFreq2)*100
        PSDStd(Index,1)=SineSigSNR2+NoiseNorPow;
    else
        PSDStd(Index,1)=NoiseNorPow;
    end
    WStd(Index,1)=Ang;
    Ang=Ang+0.01;
    Index=Index+1;
end