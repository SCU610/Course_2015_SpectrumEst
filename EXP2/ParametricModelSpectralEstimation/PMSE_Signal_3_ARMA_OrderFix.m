%FIleName: PMSE_Signal_3.m
%
%试用参数谱估计及其改进方法，由数据出发估计信号
%的功率谱，通过仿真评估其性能


clear;
%% Experiment Parameters Settings
SampleNum=20000;        %设定信号采样点数
SignalCoeffA=[1,-1.6408,2.2044,-1.4808,0.8145];
SignalCoeffB=[1,1.5857,0.9604];
NoiseNorPow=0;          %设定噪声归一化功率dB

[RealPowSpectrum,RealFreq]=freqz(SignalCoeffB,SignalCoeffA,'whole');
RealFreq=RealFreq/(2*pi);
RealPowSpectrum=10*log10(RealPowSpectrum.*conj(RealPowSpectrum));

%% Initiation
for Iteration=1:1:200
    NoiseSig=wgn(SampleNum,1,NoiseNorPow);                      %根据样点数和噪声功率产生噪声序列
    InputSignal=filter(SignalCoeffB,SignalCoeffA,NoiseSig);
    
    [ARMA_IDE_Length32(:,Iteration),~,~,~,ArOrder32,MaOrder32]=Common_ParameterPsdEst(InputSignal,32,'arma','ideburg','exp',0,4,2);
    [ARMA_IDE_Length64(:,Iteration),~,~,~,ArOrder64,MaOrder64]=Common_ParameterPsdEst(InputSignal,64,'arma','ideburg','exp',0,4,2);
    [ARMA_IDE_Length128(:,Iteration),~,~,~,ArOrder128,MaOrder128]=Common_ParameterPsdEst(InputSignal,128,'arma','ideburg','exp',0,4,2);
    [ARMA_IDE_Length256(:,Iteration),~,~,~,ArOrder256,MaOrder256]=Common_ParameterPsdEst(InputSignal,256,'arma','ideburg','exp',0,4,2);
    
    [ARMA_Yule_Length32(:,Iteration)]=Common_ParameterPsdEst(InputSignal,32,'arma','yule',NoiseSig,0,ArOrder32,MaOrder32);
    [ARMA_Yule_Length64(:,Iteration)]=Common_ParameterPsdEst(InputSignal,64,'arma','yule',NoiseSig,0,ArOrder64,MaOrder64);
    [ARMA_Yule_Length128(:,Iteration)]=Common_ParameterPsdEst(InputSignal,128,'arma','yule',NoiseSig,0,ArOrder128,MaOrder128);
    [ARMA_Yule_Length256(:,Iteration)]=Common_ParameterPsdEst(InputSignal,256,'arma','yule',NoiseSig,0,ArOrder256,MaOrder256);
end
ARMA_IDE_Length32_Mean=mean(ARMA_IDE_Length32,2);
ARMA_IDE_Length64_Mean=mean(ARMA_IDE_Length64,2);
ARMA_IDE_Length128_Mean=mean(ARMA_IDE_Length128,2);
ARMA_IDE_Length256_Mean=mean(ARMA_IDE_Length256,2);

ARMA_IDE_Length32_Std=sqrt(var(ARMA_IDE_Length32,0,2));
ARMA_IDE_Length64_Std=sqrt(var(ARMA_IDE_Length64,0,2));
ARMA_IDE_Length128_Std=sqrt(var(ARMA_IDE_Length128,0,2));
ARMA_IDE_Length256_Std=sqrt(var(ARMA_IDE_Length256,0,2));

ARMA_IDE_Length32_Div=real([10*log10(ARMA_IDE_Length32_Mean-ARMA_IDE_Length32_Std),10*log10(ARMA_IDE_Length32_Mean+ARMA_IDE_Length32_Std)]);
ARMA_IDE_Length64_Div=real([10*log10(ARMA_IDE_Length64_Mean-ARMA_IDE_Length64_Std),10*log10(ARMA_IDE_Length64_Mean+ARMA_IDE_Length64_Std)]);
ARMA_IDE_Length128_Div=real([10*log10(ARMA_IDE_Length128_Mean-ARMA_IDE_Length128_Std),10*log10(ARMA_IDE_Length128_Mean+ARMA_IDE_Length128_Std)]);
ARMA_IDE_Length256_Div=real([10*log10(ARMA_IDE_Length256_Mean-ARMA_IDE_Length256_Std),10*log10(ARMA_IDE_Length256_Mean+ARMA_IDE_Length256_Std)]);

ARMA_IDE_Length32_Mean=10*log10(ARMA_IDE_Length32_Mean);
ARMA_IDE_Length64_Mean=10*log10(ARMA_IDE_Length64_Mean);
ARMA_IDE_Length128_Mean=10*log10(ARMA_IDE_Length128_Mean);
ARMA_IDE_Length256_Mean=10*log10(ARMA_IDE_Length256_Mean);

ARMA_Yule_Length32_Mean=mean(ARMA_Yule_Length32,2);
ARMA_Yule_Length64_Mean=mean(ARMA_Yule_Length64,2);
ARMA_Yule_Length128_Mean=mean(ARMA_Yule_Length128,2);
ARMA_Yule_Length256_Mean=mean(ARMA_Yule_Length256,2);

ARMA_Yule_Length32_Std=sqrt(var(ARMA_Yule_Length32,0,2));
ARMA_Yule_Length64_Std=sqrt(var(ARMA_Yule_Length64,0,2));
ARMA_Yule_Length128_Std=sqrt(var(ARMA_Yule_Length128,0,2));
ARMA_Yule_Length256_Std=sqrt(var(ARMA_Yule_Length256,0,2));

ARMA_Yule_Length32_Div=real([10*log10(ARMA_Yule_Length32_Mean-ARMA_Yule_Length32_Std),10*log10(ARMA_Yule_Length32_Mean+ARMA_Yule_Length32_Std)]);
ARMA_Yule_Length64_Div=real([10*log10(ARMA_Yule_Length64_Mean-ARMA_Yule_Length64_Std),10*log10(ARMA_Yule_Length64_Mean+ARMA_Yule_Length64_Std)]);
ARMA_Yule_Length128_Div=real([10*log10(ARMA_Yule_Length128_Mean-ARMA_Yule_Length128_Std),10*log10(ARMA_Yule_Length128_Mean+ARMA_Yule_Length128_Std)]);
ARMA_Yule_Length256_Div=real([10*log10(ARMA_Yule_Length256_Mean-ARMA_Yule_Length256_Std),10*log10(ARMA_Yule_Length256_Mean+ARMA_Yule_Length256_Std)]);

ARMA_Yule_Length32_Mean=10*log10(ARMA_Yule_Length32_Mean);
ARMA_Yule_Length64_Mean=10*log10(ARMA_Yule_Length64_Mean);
ARMA_Yule_Length128_Mean=10*log10(ARMA_Yule_Length128_Mean);
ARMA_Yule_Length256_Mean=10*log10(ARMA_Yule_Length256_Mean);