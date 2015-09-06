function [PSD,Freq,CoeffA,CoeffB,ArOrder,MaOrder] = Common_ParameterPsdEst( InputSignal,SignalLength,...
                                                            sModel,sMethod,sOrderEstType,...
                                                            sUnitType,ArThreshold,MaThreshold)
%Common_ParameterPsdEst.m 此处显示有关此函数的摘要
%   此处显示详细说明
if strcmp(sModel,'AR')||strcmp(sModel,'Ar')||strcmp(sModel,'ar')
    if strcmp(sMethod,'Batch')||strcmp(sMethod,'batch')||strcmp(sMethod,'Bat')||strcmp(sMethod,'bat')
        [A,B,ArOrder,MaOrder]=AR_BatchParameterEst( InputSignal,SignalLength,sOrderEstType,ArThreshold );
    elseif strcmp(sMethod,'Burg')||strcmp(sMethod,'burg')||strcmp(sMethod,'Bu')||strcmp(sMethod,'bu')
        [A,B,ArOrder,MaOrder]=AR_BurgParameterEst(InputSignal,SignalLength,sOrderEstType,ArThreshold);
    elseif strcmp(sMethod,'SerRls')||strcmp(sMethod,'serrls')||strcmp(sMethod,'Rls')||strcmp(sMethod,'rls')
        
    elseif strcmp(sMethod,'GradLMS')||strcmp(sMethod,'gradlms')||strcmp(sMethod,'LMS')||strcmp(sMethod,'lms')
        
    else
        error(message('Error! Invaild AR Estimation Method @ Function:"Common_ParameterPsdEst.m"'));
    end
elseif strcmp(sModel,'MA')||strcmp(sModel,'Ma')||strcmp(sModel,'ma')
    ArOrder=0;
elseif strcmp(sModel,'ARMA')||strcmp(sModel,'Arma')||strcmp(sModel,'arma')
    if strcmp(sMethod,'IDEBAT')||strcmp(sMethod,'Idebat')||strcmp(sMethod,'idebat')
        [A,B,ArOrder,MaOrder]=ARMA_IdeParamterEst(InputSignal,SignalLength,ArThreshold,MaThreshold,'bat');
    elseif strcmp(sMethod,'IDEBURG')||strcmp(sMethod,'Ideburg')||strcmp(sMethod,'ideburg')
        [A,B,ArOrder,MaOrder]=ARMA_IdeParamterEst(InputSignal,SignalLength,ArThreshold,MaThreshold,'burg');
    elseif strcmp(sMethod,'Yule')||strcmp(sMethod,'yule')||strcmp(sMethod,'yu')
        [B,A]=ARMA_YuleEst(ArThreshold,MaThreshold,InputSignal,sOrderEstType,SignalLength);   %此处sOrderEstType为噪声序列
        ArOrder=ArThreshold;
        MaOrder=MaThreshold;
    else
        error(message('Error! Invaild ARMA Estimation Method @ Function:"Common_ParameterPsdEst.m"'));
    end
else
    error(message('Error! Invaild Signal Model @ Function:"Common_ParameterPsdEst.m"'));
end

[EstPSD,EstFreq]=freqz(B,A,'whole');
EstPSD=EstPSD.*conj(EstPSD);
EstFreq=EstFreq/(2*pi);
if strcmp(sUnitType,'db')||strcmp(sUnitType,'dB')
    EstPSD=10*log10(EstPSD.*conj(EstPSD));
end
CoeffA=A;
CoeffB=B;
PSD=EstPSD;
Freq=EstFreq;
end

