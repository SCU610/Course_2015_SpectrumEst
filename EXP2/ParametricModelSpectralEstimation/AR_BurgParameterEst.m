function [ CoeffA,CoeffB,ArOrder,MaOrder ] = AR_BurgParameterEst( InputSignal,SignalLength,OrderEstType,Threshold )
%AR_BurgParameterEst.m 此处显示有关此函数的摘要
%   此处显示详细说明
if SignalLength<=0
    error(message('Error! Invaild SignalLength @ Function:"AR_BurgParameterEst.m"'));
end
ArOrder=double.empty;
Signal=InputSignal(1:SignalLength,1);
OrderNum=Assist_OrderEst(SignalLength,OrderEstType);
Index=1;
while Index<=OrderNum
    if Index==1
        P=mse(Signal);
        ForwardError=Signal;
        BackwardError=Signal;
    end
    ErrorSqr=abs(ForwardError).^2+abs(BackwardError).^2;
    ReflectCoeff=-2*(ForwardError(Index+1:SignalLength,1))'*conj(BackwardError(Index:SignalLength-1,1))...
                            /sum(ErrorSqr(Index+1:SignalLength,1));
    A(Index,Index)=ReflectCoeff;
    for SubIndex=1:1:Index-1
            A(Index,SubIndex)=A(Index-1,SubIndex)+ReflectCoeff*conj(A(Index-1,Index-SubIndex));
    end
    PreP=P;
    P=(1-abs(ReflectCoeff)^2)*P;
    PrevForwardError=ForwardError;
    PrevBackwardError=BackwardError;
    for TimeIndex=1:1:SignalLength
        if TimeIndex==1
            ForwardError(TimeIndex,1)=PrevForwardError(TimeIndex,1);
            BackwardError(TimeIndex,1)=conj(ReflectCoeff)*PrevForwardError(TimeIndex,1);
        else
            ForwardError(TimeIndex,1)=PrevForwardError(TimeIndex,1)+ReflectCoeff*PrevBackwardError(TimeIndex-1,1);
            BackwardError(TimeIndex,1)=conj(ReflectCoeff)*PrevForwardError(TimeIndex,1)+PrevBackwardError(TimeIndex-1,1);
        end
    end
    if abs(PreP)-abs(P)<Threshold&&Threshold>0;
        break;
    elseif abs(PreP)-abs(P)<abs(Threshold)&&isempty(ArOrder)
        ArOrder=Index-1;
    elseif Threshold<0&&fix(Threshold)==Threshold
        ArOrder=-Threshold;
%     elseif Index==OrderNum+1&&isempty(ArOrder)
%         ArOrder=OrderNum;
    end
    Index=Index+1;
end
if Threshold<0
    if ArOrder>=SignalLength/2&&Threshold<0
            ArOrder=floor(SignalLength/2-1);
    end
end
CoeffA(1)=1;
CoeffA(2:size(A(end,:),2)+1)=A(end,:);
CoeffB=1;
MaOrder=0;
end



