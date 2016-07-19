function [ PSD,Freq ] = Common_ClassicPsdEst( InputSignal,SignalLength,...
                                              sMethod,sSubMethod,sWindowType,...
                                              SampleNumPerSegment,OverlapNum,...
                                              WindowSize,sUnitType )
%Common_ClassicPsdEst.m 此处显示有关此函数的摘要
%   此处显示详细说明
if strcmp(sMethod,'Periodogram')||strcmp(sMethod,'periodogram')||strcmp(sMethod,'PG')||strcmp(sMethod,'Pg')||strcmp(sMethod,'pg')
    if strcmp(sSubMethod,'Average')||strcmp(sSubMethod,'average')||strcmp(sSubMethod,'Aver')||strcmp(sSubMethod,'aver')
        [EstPsd,EstFreq]=Classic_ImpPeriodogramAver(InputSignal,SignalLength,SampleNumPerSegment,OverlapNum,sWindowType,sUnitType);
    elseif strcmp(sSubMethod,'Smooth')||strcmp(sSubMethod,'smooth')||strcmp(sSubMethod,'Sm')||strcmp(sSubMethod,'sm')
        [EstPsd,EstFreq]=Classic_ImpPeriodogramSmooth(InputSignal,SignalLength,WindowSize,sWindowType,sUnitType);
    else
        [EstPsd,EstFreq]=Classic_Periodogram(InputSignal,SignalLength,sUnitType);
    end
elseif strcmp(sMethod,'BT')||strcmp(sMethod,'Bt')||strcmp(sMethod,'bt')
    [EstPsd,EstFreq]=Classic_BT(InputSignal,SignalLength,sUnitType);
else
    error(message('Error! Invaild Classic Estimation Method @ Function:"Common_ParameterPsdEst.m"'));
end
PSD=EstPsd;
Freq=EstFreq;
end

