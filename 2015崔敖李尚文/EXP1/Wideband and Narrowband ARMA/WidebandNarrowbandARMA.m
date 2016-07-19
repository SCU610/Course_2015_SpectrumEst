%FIleName: WidebandNarrowbandARMA.m
%
%试用经典谱估计及其改进方法，由数据出发估计信号
%的功率谱，通过仿真评估其性能


clear;
%% Experiment Parameters Settings
SampleNum=20000;        %设定信号采样点数
WidebandCoeffA=[1,-1.3817,1.5632,-0.8843,0.4096];
WidebandCoeffB=[1,0.3544,0.3508,0.1736,0.2401];
NarrowbandCoeffA=[1,-1.6408,2.2044,-1.4808,0.8145];
NarrowbandCoeffB=[1,1.5857,0.9604];
NoiseNorPow=0;          %设定噪声归一化功率dB
%% Initiation
NoiseSig=wgn(SampleNum,1,NoiseNorPow);                      %根据样点数和噪声功率产生噪声序列

InputWidebandSignal=filter(WidebandCoeffB,WidebandCoeffA,NoiseSig);
InputNarrowbandSignal=filter(NarrowbandCoeffB,NarrowbandCoeffA,NoiseSig);

[RealWidebandPowSpectrum,RealWidebandFreq]=freqz(WidebandCoeffB,WidebandCoeffA,'whole',4096);
RealWidebandFreq=RealWidebandFreq/(2*pi);
RealWidebandPowSpectrum=10*log10(RealWidebandPowSpectrum.*conj(RealWidebandPowSpectrum));
[RealNarrowbandPowSpectrum,RealNarrowbandFreq]=freqz(NarrowbandCoeffB,NarrowbandCoeffA,'whole',4096);
RealNarrowbandFreq=RealNarrowbandFreq/(2*pi);
RealNarrowbandPowSpectrum=10*log10(RealNarrowbandPowSpectrum.*conj(RealNarrowbandPowSpectrum));

%% Windeband Classic Method with different signal length
[W_CPD_PSD64,W_CPD_Freq64]=ClassicPeriodogram(InputWidebandSignal,64,'db');
[W_CPD_PSD256,W_CPD_Freq256]=ClassicPeriodogram(InputWidebandSignal,256,'db');
[W_CPD_PSD512,W_CPD_Freq512]=ClassicPeriodogram(InputWidebandSignal,512,'db');
[W_CPD_PSD2048,W_CPD_Freq2048]=ClassicPeriodogram(InputWidebandSignal,2048,'db');

[W_BT_PSD64,W_BT_Freq64]=ClassicBT(InputWidebandSignal,64,'db');
[W_BT_PSD256,W_BT_Freq256]=ClassicBT(InputWidebandSignal,256,'db');
[W_BT_PSD512,W_BT_Freq512]=ClassicBT(InputWidebandSignal,512,'db');
[W_BT_PSD2048,W_BT_Freq2048]=ClassicBT(InputWidebandSignal,2048,'db');

%% Wideband Improved Periodogram Aver. Method with different windows and signal length
[W_IPDA_RECT_NOOL_PSD64,W_IPDA_RECT_NOOL_Freq64]=ImpPeriodogramAver(InputWidebandSignal,64,8,0,0,'db');
[W_IPDA_RECT_NOOL_PSD256,W_IPDA_RECT_NOOL_Freq256]=ImpPeriodogramAver(InputWidebandSignal,256,16,0,0,'db');
[W_IPDA_RECT_NOOL_PSD512,W_IPDA_RECT_NOOL_Freq512]=ImpPeriodogramAver(InputWidebandSignal,512,32,0,0,'db');
[W_IPDA_RECT_NOOL_PSD2048,W_IPDA_RECT_NOOL_Freq2048]=ImpPeriodogramAver(InputWidebandSignal,2048,64,0,0,'db');

[W_IPDA_RECT_PSD64,W_IPDA_RECT_Freq64]=ImpPeriodogramAver(InputWidebandSignal,64,8,4,0,'db');
[W_IPDA_RECT_PSD256,W_IPDA_RECT_Freq256]=ImpPeriodogramAver(InputWidebandSignal,256,16,8,0,'db');
[W_IPDA_RECT_PSD512,W_IPDA_RECT_Freq512]=ImpPeriodogramAver(InputWidebandSignal,512,32,16,0,'db');
[W_IPDA_RECT_PSD2048,W_IPDA_RECT_Freq2048]=ImpPeriodogramAver(InputWidebandSignal,2048,64,32,0,'db');

[W_IPDA_HANN_PSD64,W_IPDA_HANN_Freq64]=ImpPeriodogramAver(InputWidebandSignal,64,8,4,'Hann','db');
[W_IPDA_HANN_PSD256,W_IPDA_HANN_Freq256]=ImpPeriodogramAver(InputWidebandSignal,256,16,8,'Hann','db');
[W_IPDA_HANN_PSD512,W_IPDA_HANN_Freq512]=ImpPeriodogramAver(InputWidebandSignal,512,32,16,'Hann','db');
[W_IPDA_HANN_PSD2048,W_IPDA_HANN_Freq2048]=ImpPeriodogramAver(InputWidebandSignal,2048,64,32,'Hann','db');

[W_IPDA_HAMM_PSD64,W_IPDA_HAMM_Freq64]=ImpPeriodogramAver(InputWidebandSignal,64,8,4,'Hamm','db');
[W_IPDA_HAMM_PSD256,W_IPDA_HAMM_Freq256]=ImpPeriodogramAver(InputWidebandSignal,256,16,8,'Hamm','db');
[W_IPDA_HAMM_PSD512,W_IPDA_HAMM_Freq512]=ImpPeriodogramAver(InputWidebandSignal,512,32,16,'Hamm','db');
[W_IPDA_HAMM_PSD2048,W_IPDA_HAMM_Freq2048]=ImpPeriodogramAver(InputWidebandSignal,2048,64,32,'Hamm','db');

[W_IPDA_TRI_PSD64,W_IPDA_TRI_Freq64]=ImpPeriodogramAver(InputWidebandSignal,64,8,4,'Tri','db');
[W_IPDA_TRI_PSD256,W_IPDA_TRI_Freq256]=ImpPeriodogramAver(InputWidebandSignal,256,16,8,'Tri','db');
[W_IPDA_TRI_PSD512,W_IPDA_TRI_Freq512]=ImpPeriodogramAver(InputWidebandSignal,512,32,16,'Tri','db');
[W_IPDA_TRI_PSD2048,W_IPDA_TRI_Freq2048]=ImpPeriodogramAver(InputWidebandSignal,2048,64,32,'Tri','db');

%% Wideband Improved Periodogram Smooth Method with different windows and signal length
[W_IPDS_RECT_PSD64,W_IPDS_RECT_Freq64]=ImpPeriodogramSmooth(InputWidebandSignal,64,4,0,'db');
[W_IPDS_RECT_PSD256,W_IPDS_RECT_Freq256]=ImpPeriodogramSmooth(InputWidebandSignal,256,16,0,'db');
[W_IPDS_RECT_PSD512,W_IPDS_RECT_Freq512]=ImpPeriodogramSmooth(InputWidebandSignal,512,32,0,'db');
[W_IPDS_RECT_PSD2048,W_IPDS_RECT_Freq2048]=ImpPeriodogramSmooth(InputWidebandSignal,2048,128,0,'db');

[W_IPDS_HANN_PSD64,W_IPDS_HANN_Freq64]=ImpPeriodogramSmooth(InputWidebandSignal,64,4,'Hann','db');
[W_IPDS_HANN_PSD256,W_IPDS_HANN_Freq256]=ImpPeriodogramSmooth(InputWidebandSignal,256,16,'Hann','db');
[W_IPDS_HANN_PSD512,W_IPDS_HANN_Freq512]=ImpPeriodogramSmooth(InputWidebandSignal,512,32,'Hann','db');
[W_IPDS_HANN_PSD2048,W_IPDS_HANN_Freq2048]=ImpPeriodogramSmooth(InputWidebandSignal,2048,128,'Hann','db');

[W_IPDS_HAMM_PSD64,W_IPDS_HAMM_Freq64]=ImpPeriodogramSmooth(InputWidebandSignal,64,4,'Hamm','db');
[W_IPDS_HAMM_PSD256,W_IPDS_HAMM_Freq256]=ImpPeriodogramSmooth(InputWidebandSignal,256,16,'Hamm','db');
[W_IPDS_HAMM_PSD512,W_IPDS_HAMM_Freq512]=ImpPeriodogramSmooth(InputWidebandSignal,512,32,'Hamm','db');
[W_IPDS_HAMM_PSD2048,W_IPDS_HAMM_Freq2048]=ImpPeriodogramSmooth(InputWidebandSignal,2048,128,'Hamm','db');

[W_IPDS_TRI_PSD64,W_IPDS_TRI_Freq64]=ImpPeriodogramSmooth(InputWidebandSignal,64,4,'Tri','db');
[W_IPDS_TRI_PSD256,W_IPDS_TRI_Freq256]=ImpPeriodogramSmooth(InputWidebandSignal,256,16,'Tri','db');
[W_IPDS_TRI_PSD512,W_IPDS_TRI_Freq512]=ImpPeriodogramSmooth(InputWidebandSignal,512,32,'Tri','db');
[W_IPDS_TRI_PSD2048,W_IPDS_TRI_Freq2048]=ImpPeriodogramSmooth(InputWidebandSignal,2048,128,'Tri','db');



%% Narrowband Classic Method with different signal length
[N_CPD_PSD64,N_CPD_Freq64]=ClassicPeriodogram(InputNarrowbandSignal,64,'db');
[N_CPD_PSD256,N_CPD_Freq256]=ClassicPeriodogram(InputNarrowbandSignal,256,'db');
[N_CPD_PSD512,N_CPD_Freq512]=ClassicPeriodogram(InputNarrowbandSignal,512,'db');
[N_CPD_PSD2048,N_CPD_Freq2048]=ClassicPeriodogram(InputNarrowbandSignal,2048,'db');

[N_BT_PSD64,N_BT_Freq64]=ClassicBT(InputNarrowbandSignal,64,'db');
[N_BT_PSD256,N_BT_Freq256]=ClassicBT(InputNarrowbandSignal,256,'db');
[N_BT_PSD512,N_BT_Freq512]=ClassicBT(InputNarrowbandSignal,512,'db');
[N_BT_PSD2048,N_BT_Freq2048]=ClassicBT(InputNarrowbandSignal,2048,'db');

%% Narrowband Improved Periodogram Aver. Method with different windows and signal length
[N_IPDA_RECT_NOOL_PSD64,N_IPDA_RECT_NOOL_Freq64]=ImpPeriodogramAver(InputNarrowbandSignal,64,32,0,0,'db');
[N_IPDA_RECT_NOOL_PSD256,N_IPDA_RECT_NOOL_Freq256]=ImpPeriodogramAver(InputNarrowbandSignal,256,64,0,0,'db');
[N_IPDA_RECT_NOOL_PSD512,N_IPDA_RECT_NOOL_Freq512]=ImpPeriodogramAver(InputNarrowbandSignal,512,128,0,0,'db');
[N_IPDA_RECT_NOOL_PSD2048,N_IPDA_RECT_NOOL_Freq2048]=ImpPeriodogramAver(InputNarrowbandSignal,2048,256,0,0,'db');

[N_IPDA_RECT_PSD64,N_IPDA_RECT_Freq64]=ImpPeriodogramAver(InputNarrowbandSignal,64,32,16,0,'db');
[N_IPDA_RECT_PSD256,N_IPDA_RECT_Freq256]=ImpPeriodogramAver(InputNarrowbandSignal,256,64,32,0,'db');
[N_IPDA_RECT_PSD512,N_IPDA_RECT_Freq512]=ImpPeriodogramAver(InputNarrowbandSignal,512,128,64,0,'db');
[N_IPDA_RECT_PSD2048,N_IPDA_RECT_Freq2048]=ImpPeriodogramAver(InputNarrowbandSignal,2048,256,128,0,'db');

[N_IPDA_HANN_PSD64,N_IPDA_HANN_Freq64]=ImpPeriodogramAver(InputNarrowbandSignal,64,32,16,'Hann','db');
[N_IPDA_HANN_PSD256,N_IPDA_HANN_Freq256]=ImpPeriodogramAver(InputNarrowbandSignal,256,64,32,'Hann','db');
[N_IPDA_HANN_PSD512,N_IPDA_HANN_Freq512]=ImpPeriodogramAver(InputNarrowbandSignal,512,128,64,'Hann','db');
[N_IPDA_HANN_PSD2048,N_IPDA_HANN_Freq2048]=ImpPeriodogramAver(InputNarrowbandSignal,2048,256,128,'Hann','db');

[N_IPDA_HAMM_PSD64,N_IPDA_HAMM_Freq64]=ImpPeriodogramAver(InputNarrowbandSignal,64,32,16,'Hamm','db');
[N_IPDA_HAMM_PSD256,N_IPDA_HAMM_Freq256]=ImpPeriodogramAver(InputNarrowbandSignal,256,64,32,'Hamm','db');
[N_IPDA_HAMM_PSD512,N_IPDA_HAMM_Freq512]=ImpPeriodogramAver(InputNarrowbandSignal,512,128,64,'Hamm','db');
[N_IPDA_HAMM_PSD2048,N_IPDA_HAMM_Freq2048]=ImpPeriodogramAver(InputNarrowbandSignal,2048,256,128,'Hamm','db');

[N_IPDA_TRI_PSD64,N_IPDA_TRI_Freq64]=ImpPeriodogramAver(InputNarrowbandSignal,64,32,16,'Tri','db');
[N_IPDA_TRI_PSD256,N_IPDA_TRI_Freq256]=ImpPeriodogramAver(InputNarrowbandSignal,256,64,32,'Tri','db');
[N_IPDA_TRI_PSD512,N_IPDA_TRI_Freq512]=ImpPeriodogramAver(InputNarrowbandSignal,512,128,64,'Tri','db');
[N_IPDA_TRI_PSD2048,N_IPDA_TRI_Freq2048]=ImpPeriodogramAver(InputNarrowbandSignal,2048,256,128,'Tri','db');

%% Narrowband Improved Periodogram Smooth Method with different windows and signal length
[N_IPDS_RECT_PSD64,N_IPDS_RECT_Freq64]=ImpPeriodogramSmooth(InputNarrowbandSignal,64,4,0,'db');
[N_IPDS_RECT_PSD256,N_IPDS_RECT_Freq256]=ImpPeriodogramSmooth(InputNarrowbandSignal,256,4,0,'db');
[N_IPDS_RECT_PSD512,N_IPDS_RECT_Freq512]=ImpPeriodogramSmooth(InputNarrowbandSignal,512,8,0,'db');
[N_IPDS_RECT_PSD2048,N_IPDS_RECT_Freq2048]=ImpPeriodogramSmooth(InputNarrowbandSignal,2048,8,0,'db');

[N_IPDS_HANN_PSD64,N_IPDS_HANN_Freq64]=ImpPeriodogramSmooth(InputNarrowbandSignal,64,4,'Hann','db');
[N_IPDS_HANN_PSD256,N_IPDS_HANN_Freq256]=ImpPeriodogramSmooth(InputNarrowbandSignal,256,4,'Hann','db');
[N_IPDS_HANN_PSD512,N_IPDS_HANN_Freq512]=ImpPeriodogramSmooth(InputNarrowbandSignal,512,8,'Hann','db');
[N_IPDS_HANN_PSD2048,N_IPDS_HANN_Freq2048]=ImpPeriodogramSmooth(InputNarrowbandSignal,2048,8,'Hann','db');

[N_IPDS_HAMM_PSD64,N_IPDS_HAMM_Freq64]=ImpPeriodogramSmooth(InputNarrowbandSignal,64,4,'Hamm','db');
[N_IPDS_HAMM_PSD256,N_IPDS_HAMM_Freq256]=ImpPeriodogramSmooth(InputNarrowbandSignal,256,4,'Hamm','db');
[N_IPDS_HAMM_PSD512,N_IPDS_HAMM_Freq512]=ImpPeriodogramSmooth(InputNarrowbandSignal,512,8,'Hamm','db');
[N_IPDS_HAMM_PSD2048,N_IPDS_HAMM_Freq2048]=ImpPeriodogramSmooth(InputNarrowbandSignal,2048,8,'Hamm','db');

[N_IPDS_TRI_PSD64,N_IPDS_TRI_Freq64]=ImpPeriodogramSmooth(InputNarrowbandSignal,64,4,'Tri','db');
[N_IPDS_TRI_PSD256,N_IPDS_TRI_Freq256]=ImpPeriodogramSmooth(InputNarrowbandSignal,256,4,'Tri','db');
[N_IPDS_TRI_PSD512,N_IPDS_TRI_Freq512]=ImpPeriodogramSmooth(InputNarrowbandSignal,512,8,'Tri','db');
[N_IPDS_TRI_PSD2048,N_IPDS_TRI_Freq2048]=ImpPeriodogramSmooth(InputNarrowbandSignal,2048,8,'Tri','db');