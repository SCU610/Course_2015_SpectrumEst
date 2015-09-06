function [ CoeffA,CoeffB,ArOrder,MaOrder ] = AR_BatchParameterEst( InputSignal,SignalLength,OrderEstType,Threshold )
%AR_BatchParameterEst.m 此处显示有关此函数的摘要
%   此处显示详细说明
if SignalLength<=0
    error(message('Error! Invaild SignalLength @ Function:"AR_BatchParameterEst.m"'));
end
ArOrder=double.empty;
Signal=InputSignal(1:SignalLength,1);
OrderNum=Assist_OrderEst(SignalLength,OrderEstType);
Index=1;
while Index<=OrderNum
    if Index==1
        A(Index,Index)=-Assist_CorrEst(Signal,Index,'biased')/Assist_CorrEst(Signal,0,'biased');
        Sigma2=(1-(abs(A(Index,Index)))^2)*Assist_CorrEst(Signal,0,'biased');
    else
        for AssIndex=1:1:Index-1
            CorrVect(AssIndex,Index)=Assist_CorrEst(Signal,Index-AssIndex,'biased');
        end
        A(Index,Index)=-(Assist_CorrEst(Signal,Index,'biased')+A(Index-1,1:Index-1)*CorrVect(1:Index-1,Index))/Sigma2;
        PrevSigma2=Sigma2;
        Sigma2=(1-(abs(A(Index,Index)))^2)*Sigma2;
        for SubIndex=1:1:Index-1
            A(Index,SubIndex)=A(Index-1,SubIndex)+A(Index,Index)*A(Index-1,Index-SubIndex);
        end
        if abs(PrevSigma2)-abs(Sigma2)<Threshold&&Threshold>0;
            break;
        elseif abs(PrevSigma2)-abs(Sigma2)<abs(Threshold)&&isempty(ArOrder)
            ArOrder=Index-1;
        elseif Threshold<0&&fix(Threshold)==Threshold
            ArOrder=-Threshold;
%         elseif Index==OrderNum+1&&isempty(ArOrder)
%             ArOrder=OrderNum-1;
        end
    end
    Index=Index+1;
end
if ArOrder>=SignalLength/2
    ArOrder=floor(SignalLength/2-1);
end
CoeffA(1)=1;
CoeffA(2:size(A(end,:),2)+1)=A(end,:);
CoeffB=1;
MaOrder=0;
end

