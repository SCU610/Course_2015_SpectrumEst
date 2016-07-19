%FIleName: PMSE_Signal_4.m
%
%试用参数谱估计及其改进方法，由数据出发估计信号
%的功率谱，通过仿真评估其性能


clear;
%% Experiment Parameters Settings
SampleNum=20000;        %设定信号采样点数
SignalCoeffA=[1,-1.3817,1.5632,-0.8843,0.4096];
SignalCoeffB=1;

NoiseNorPow=0;          %设定噪声归一化功率dB

[RealPowSpectrum,RealFreq]=freqz(SignalCoeffB,SignalCoeffA,'whole');
RealFreq=RealFreq/(2*pi);
RealPowSpectrum=10*log10(RealPowSpectrum.*conj(RealPowSpectrum));
%% Initiation
for Iteration=1:1:200
    NoiseSig=wgn(SampleNum,1,NoiseNorPow);                      %根据样点数和噪声功率产生噪声序列
    InputSignal=filter(SignalCoeffB,SignalCoeffA,NoiseSig);
    [AR_BurgPSD_Length32(:,Iteration)]=Common_ParameterPsdEst(InputSignal,32,'ar','burg','exp',0,0.01,0);
    [AR_BurgPSD_Length64(:,Iteration)]=Common_ParameterPsdEst(InputSignal,64,'ar','burg','exp',0,0.01,0);
    [AR_BurgPSD_Length128(:,Iteration)]=Common_ParameterPsdEst(InputSignal,128,'ar','burg','exp',0,0.01,0);
    [AR_BurgPSD_Length256(:,Iteration)]=Common_ParameterPsdEst(InputSignal,256,'ar','burg','exp',0,0.01,0);
    
    [AR_BatPSD_Length32(:,Iteration)]=Common_ParameterPsdEst(InputSignal,32,'ar','bat','exp',0,0.01,0);
    [AR_BatPSD_Length64(:,Iteration)]=Common_ParameterPsdEst(InputSignal,64,'ar','bat','exp',0,0.01,0);
    [AR_BatPSD_Length128(:,Iteration)]=Common_ParameterPsdEst(InputSignal,128,'ar','bat','exp',0,0.01,0);
    [AR_BatPSD_Length256(:,Iteration)]=Common_ParameterPsdEst(InputSignal,256,'ar','bat','exp',0,0.01,0);
end
AR_BurgPSD_Length32_Mean=mean(AR_BurgPSD_Length32,2);
AR_BurgPSD_Length64_Mean=mean(AR_BurgPSD_Length64,2);
AR_BurgPSD_Length128_Mean=mean(AR_BurgPSD_Length128,2);
AR_BurgPSD_Length256_Mean=mean(AR_BurgPSD_Length256,2);

AR_BurgPSD_Length32_Std=sqrt(var(AR_BurgPSD_Length32,0,2));
AR_BurgPSD_Length64_Std=sqrt(var(AR_BurgPSD_Length64,0,2));
AR_BurgPSD_Length128_Std=sqrt(var(AR_BurgPSD_Length128,0,2));
AR_BurgPSD_Length256_Std=sqrt(var(AR_BurgPSD_Length256,0,2));

AR_BurgPSD_Length32_Div=real([10*log10(AR_BurgPSD_Length32_Mean-AR_BurgPSD_Length32_Std),10*log10(AR_BurgPSD_Length32_Mean+AR_BurgPSD_Length32_Std)]);
AR_BurgPSD_Length64_Div=real([10*log10(AR_BurgPSD_Length64_Mean-AR_BurgPSD_Length64_Std),10*log10(AR_BurgPSD_Length64_Mean+AR_BurgPSD_Length64_Std)]);
AR_BurgPSD_Length128_Div=real([10*log10(AR_BurgPSD_Length128_Mean-AR_BurgPSD_Length128_Std),10*log10(AR_BurgPSD_Length128_Mean+AR_BurgPSD_Length128_Std)]);
AR_BurgPSD_Length256_Div=real([10*log10(AR_BurgPSD_Length256_Mean-AR_BurgPSD_Length256_Std),10*log10(AR_BurgPSD_Length256_Mean+AR_BurgPSD_Length256_Std)]);

AR_BurgPSD_Length32_Mean=10*log10(AR_BurgPSD_Length32_Mean);
AR_BurgPSD_Length64_Mean=10*log10(AR_BurgPSD_Length64_Mean);
AR_BurgPSD_Length128_Mean=10*log10(AR_BurgPSD_Length128_Mean);
AR_BurgPSD_Length256_Mean=10*log10(AR_BurgPSD_Length256_Mean);


AR_BatPSD_Length32_Mean=mean(AR_BatPSD_Length32,2);
AR_BatPSD_Length64_Mean=mean(AR_BatPSD_Length64,2);
AR_BatPSD_Length128_Mean=mean(AR_BatPSD_Length128,2);
AR_BatPSD_Length256_Mean=mean(AR_BatPSD_Length256,2);

AR_BatPSD_Length32_Std=sqrt(var(AR_BatPSD_Length32,0,2));
AR_BatPSD_Length64_Std=sqrt(var(AR_BatPSD_Length64,0,2));
AR_BatPSD_Length128_Std=sqrt(var(AR_BatPSD_Length128,0,2));
AR_BatPSD_Length256_Std=sqrt(var(AR_BatPSD_Length256,0,2));

AR_BatPSD_Length32_Div=real([10*log10(AR_BatPSD_Length32_Mean-AR_BatPSD_Length32_Std),10*log10(AR_BatPSD_Length32_Mean+AR_BatPSD_Length32_Std)]);
AR_BatPSD_Length64_Div=real([10*log10(AR_BatPSD_Length64_Mean-AR_BatPSD_Length64_Std),10*log10(AR_BatPSD_Length64_Mean+AR_BatPSD_Length64_Std)]);
AR_BatPSD_Length128_Div=real([10*log10(AR_BatPSD_Length128_Mean-AR_BatPSD_Length128_Std),10*log10(AR_BatPSD_Length128_Mean+AR_BatPSD_Length128_Std)]);
AR_BatPSD_Length256_Div=real([10*log10(AR_BatPSD_Length256_Mean-AR_BatPSD_Length256_Std),10*log10(AR_BatPSD_Length256_Mean+AR_BatPSD_Length256_Std)]);

AR_BatPSD_Length32_Mean=10*log10(AR_BatPSD_Length32_Mean);
AR_BatPSD_Length64_Mean=10*log10(AR_BatPSD_Length64_Mean);
AR_BatPSD_Length128_Mean=10*log10(AR_BatPSD_Length128_Mean);
AR_BatPSD_Length256_Mean=10*log10(AR_BatPSD_Length256_Mean);