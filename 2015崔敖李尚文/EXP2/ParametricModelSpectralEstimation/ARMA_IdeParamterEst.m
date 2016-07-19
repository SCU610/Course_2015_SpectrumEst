function [ CoeffA,CoeffB,ArOrder,MaOrder ] = ARMA_IdeParamterEst( InputSignal,SignalLength,ArThreshold,MaThreshold,sArEstType )
%ARMA_IdeParamterEst.m 此处显示有关此函数的摘要
%   此处显示详细说明
if SignalLength<=0
    error(message('Error! Invaild SignalLength @ Function:"ARMA_IdeParamterEst.m"'));
end
if ArThreshold<1&&ArThreshold>0
    if strcmp(sArEstType,'bat')||strcmp(sArEstType,'batch')
        [AR_EstC,~,ArOrder]=AR_BatchParameterEst(InputSignal,SignalLength,SignalLength-2,-abs(ArThreshold));
    elseif strcmp(sArEstType,'bu')||strcmp(sArEstType,'burg')
        [AR_EstC,~,ArOrder]=AR_BurgParameterEst(InputSignal,SignalLength,SignalLength-2,-abs(ArThreshold));
    else
        error(message('Error! Invaild sArEstType @ Function:"ARMA_IdeParamterEst.m"'));
    end
elseif ArThreshold==fix(ArThreshold)&&ArThreshold>0
    ArOrder=ArThreshold;
    if strcmp(sArEstType,'bat')||strcmp(sArEstType,'batch')
        [AR_EstC,~]=AR_BatchParameterEst(InputSignal,SignalLength,SignalLength-2,-abs(ArThreshold));
    elseif strcmp(sArEstType,'bu')||strcmp(sArEstType,'burg')
        [AR_EstC,~]=AR_BurgParameterEst(InputSignal,SignalLength,SignalLength-2,-abs(ArThreshold));
    else
        error(message('Error! Invaild sArEstType @ Function:"ARMA_IdeParamterEst.m"'));
    end
else
    error(message('Error! Invaild ArThreshold @ Function:"ARMA_IdeParamterEst.m"'));
end

if MaThreshold<1&&MaThreshold>0
    [~,~,MaOrder]=MA_MovAverParameterEst(InputSignal,SignalLength,'exp',abs(MaThreshold));
elseif MaThreshold==fix(MaThreshold)&&MaThreshold>0
    MaOrder=MaThreshold;
else
    error(message('Error! Invaild MaThreshold @ Function:"ARMA_IdeParamterEst.m"'));
end
if MaOrder>ArOrder
    ArOrder=MaOrder;
end

for Index=1:1:MaOrder
    EstC1Matrix(Index,:)=AR_EstC(1,ArOrder+Index:-1:ArOrder+Index+1-MaOrder);
end
Window=zeros(1,MaOrder+1);
Window(1)=1;
for Index=1:1:ArOrder
    Window(2:end)=Window(1:end-1);
    Window(1)=AR_EstC(Index+1);
    EstC2Matrix(Index,:)=Window;
end
EstCVect=AR_EstC(1,ArOrder+1+1:ArOrder+1+MaOrder);
EstCVect=EstCVect';
CoeffB=[1,(inv(EstC1Matrix)*EstCVect)'];
CoeffA=[1,(EstC2Matrix*CoeffB')'];
end

