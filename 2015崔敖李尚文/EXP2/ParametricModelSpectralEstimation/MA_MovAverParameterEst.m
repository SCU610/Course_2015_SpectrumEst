function [ CoeffA,CoeffB,MaOrder ] = MA_MovAverParameterEst( InputSignal,SignalLength,OrderEstType,Threshold )
%MA_MovAverParameterEst.m 此处显示有关此函数的摘要
%   此处显示详细说明
if SignalLength<=0
    error(message('Error! Invaild SignalLength @ Function:"MA_MovAverParameterEst.m"'));
end
Signal=InputSignal(1:SignalLength,1);
OrderNum=Assist_OrderEst(SignalLength,OrderEstType);
Index=1;
while Index<=OrderNum+1
    if Index>1
        CorrVar(Index)=var(CorrEst(1:end,:));
    else
        CorrVar(Index)=0;
    end;
    CorrEst(Index,:)=Assist_CorrEst(Signal,Index-1,'unbiased');
    if abs(CorrEst(Index,:))-CorrVar(Index)<0&&abs(CorrEst(Index,:))<Threshold
        OrderNum=Index-1;
        break;
    end
%     E(Index)=abs(CorrEst(Index,:))-CorrVar(Index);
    Index=Index+1;
end
% for Index=1:1:size(CorrEst,1)
%     ForwardVar(Index,1)=var(CorrEst(1:Index,1));
%     BackwardVar(Index,1)=var(CorrEst(Index:end,1));
% end
%plot(abs(E));
% OrderNum=find(diff(sign(diff(BackwardVar)))==2,1,'first')+1+1;
% plot(BackwardVar);
CorrInOrder=CorrEst(1:OrderNum+1,1);


MaOrder=OrderNum;
if MaOrder>=SignalLength/2
    MaOrder=SignalLength/2-1;
end

CoeffB=1;
CoeffA=1;
end

