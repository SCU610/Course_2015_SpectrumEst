%FIleName: PMSE_Signal_5.m
%
%试用参数谱估计及其改进方法，由数据出发估计信号
%的功率谱，通过仿真评估其性能


clear;
%% Experiment Parameters Settings
SampleNum=20000;        %设定信号采样点数
SignalCoeffA=[1,-1.6408,2.2044,-1.4808,0.8145];
SignalCoeffB=1;
NoiseNorPow=0;          %设定噪声归一化功率dB
%% Initiation
[RealPowSpectrum,RealFreq]=freqz(SignalCoeffB,SignalCoeffA,'whole');
RealFreq=RealFreq/(2*pi);
RealPowSpectrum=10*log10(RealPowSpectrum.*conj(RealPowSpectrum));

for Iteration=1:1:200
    NoiseSig=wgn(SampleNum,1,NoiseNorPow);                      %根据样点数和噪声功率产生噪声序列
    InputSignal=filter(SignalCoeffB,SignalCoeffA,NoiseSig);
    [AR_BurgPSD_Order2(:,Iteration)]=Common_ParameterPsdEst(InputSignal,256,'ar','burg',2,0,-2,0);
    [AR_BurgPSD_Order4(:,Iteration)]=Common_ParameterPsdEst(InputSignal,256,'ar','burg',4,0,-4,0);
    [AR_BurgPSD_Order8(:,Iteration)]=Common_ParameterPsdEst(InputSignal,256,'ar','burg',8,0,-8,0);
    [AR_BurgPSD_Order16(:,Iteration)]=Common_ParameterPsdEst(InputSignal,256,'ar','burg',16,0,-16,0);
    
    [AR_BatPSD_Order2(:,Iteration)]=Common_ParameterPsdEst(InputSignal,256,'ar','bat',2,0,-2,0);
    [AR_BatPSD_Order4(:,Iteration)]=Common_ParameterPsdEst(InputSignal,256,'ar','bat',4,0,-4,0);
    [AR_BatPSD_Order8(:,Iteration)]=Common_ParameterPsdEst(InputSignal,256,'ar','bat',8,0,-8,0);
    [AR_BatPSD_Order16(:,Iteration)]=Common_ParameterPsdEst(InputSignal,256,'ar','bat',16,0,-16,0);
end
AR_BurgPSD_Order2_Mean=mean(AR_BurgPSD_Order2,2);
AR_BurgPSD_Order4_Mean=mean(AR_BurgPSD_Order4,2);
AR_BurgPSD_Order8_Mean=mean(AR_BurgPSD_Order8,2);
AR_BurgPSD_Order16_Mean=mean(AR_BurgPSD_Order16,2);

AR_BurgPSD_Order2_Std=sqrt(var(AR_BurgPSD_Order2,0,2));
AR_BurgPSD_Order4_Std=sqrt(var(AR_BurgPSD_Order4,0,2));
AR_BurgPSD_Order8_Std=sqrt(var(AR_BurgPSD_Order8,0,2));
AR_BurgPSD_Order16_Std=sqrt(var(AR_BurgPSD_Order16,0,2));

AR_BurgPSD_Order2_Div=real([10*log10(AR_BurgPSD_Order2_Mean-AR_BurgPSD_Order2_Std),10*log10(AR_BurgPSD_Order2_Mean+AR_BurgPSD_Order2_Std)]);
AR_BurgPSD_Order4_Div=real([10*log10(AR_BurgPSD_Order4_Mean-AR_BurgPSD_Order4_Std),10*log10(AR_BurgPSD_Order4_Mean+AR_BurgPSD_Order4_Std)]);
AR_BurgPSD_Order8_Div=real([10*log10(AR_BurgPSD_Order8_Mean-AR_BurgPSD_Order8_Std),10*log10(AR_BurgPSD_Order8_Mean+AR_BurgPSD_Order8_Std)]);
AR_BurgPSD_Order16_Div=real([10*log10(AR_BurgPSD_Order16_Mean-AR_BurgPSD_Order16_Std),10*log10(AR_BurgPSD_Order16_Mean+AR_BurgPSD_Order16_Std)]);

AR_BurgPSD_Order2_Mean=10*log10(AR_BurgPSD_Order2_Mean);
AR_BurgPSD_Order4_Mean=10*log10(AR_BurgPSD_Order4_Mean);
AR_BurgPSD_Order8_Mean=10*log10(AR_BurgPSD_Order8_Mean);
AR_BurgPSD_Order16_Mean=10*log10(AR_BurgPSD_Order16_Mean);


AR_BatPSD_Order2_Mean=mean(AR_BatPSD_Order2,2);
AR_BatPSD_Order4_Mean=mean(AR_BatPSD_Order4,2);
AR_BatPSD_Order8_Mean=mean(AR_BatPSD_Order8,2);
AR_BatPSD_Order16_Mean=mean(AR_BatPSD_Order16,2);

AR_BatPSD_Order2_Std=sqrt(var(AR_BatPSD_Order2,0,2));
AR_BatPSD_Order4_Std=sqrt(var(AR_BatPSD_Order4,0,2));
AR_BatPSD_Order8_Std=sqrt(var(AR_BatPSD_Order8,0,2));
AR_BatPSD_Order16_Std=sqrt(var(AR_BatPSD_Order16,0,2));

AR_BatPSD_Order2_Div=real([10*log10(AR_BatPSD_Order2_Mean-AR_BatPSD_Order2_Std),10*log10(AR_BatPSD_Order2_Mean+AR_BatPSD_Order2_Std)]);
AR_BatPSD_Order4_Div=real([10*log10(AR_BatPSD_Order4_Mean-AR_BatPSD_Order4_Std),10*log10(AR_BatPSD_Order4_Mean+AR_BatPSD_Order4_Std)]);
AR_BatPSD_Order8_Div=real([10*log10(AR_BatPSD_Order8_Mean-AR_BatPSD_Order8_Std),10*log10(AR_BatPSD_Order8_Mean+AR_BatPSD_Order8_Std)]);
AR_BatPSD_Order16_Div=real([10*log10(AR_BatPSD_Order16_Mean-AR_BatPSD_Order16_Std),10*log10(AR_BatPSD_Order16_Mean+AR_BatPSD_Order16_Std)]);

AR_BatPSD_Order2_Mean=10*log10(AR_BatPSD_Order2_Mean);
AR_BatPSD_Order4_Mean=10*log10(AR_BatPSD_Order4_Mean);
AR_BatPSD_Order8_Mean=10*log10(AR_BatPSD_Order8_Mean);
AR_BatPSD_Order16_Mean=10*log10(AR_BatPSD_Order16_Mean);