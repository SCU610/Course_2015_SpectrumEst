function [ CoeffA,CoeffB ] = AR_SerRlsParameterEst( InputSignal,SignalLength,sOrderEstType )
%AR_SerRlsParameterEst.m 此处显示有关此函数的摘要
%   此处显示详细说明
if SignalLength<=0
    error(message('Error! Invaild SignalLength @ Function:"AR_SerRlsParameterEst.m"'));
end
Signal=InputSignal(1:SignalLength,1);
OrderNum=Assist_OrderEst(SignalLength,sOrderEstType);
Window=zeros(1,OrderNum);
P=100000*diag(ones(1,OrderNum));
A=zeros(OrderNum,1);
IterationTime=1;
while IterationTime<=SignalLength
    Window(1)=Signal(IterationTime,1);
    %K=P*Window'/(1+Window*P*Window');
    P=inv(inv(P)+Window'*Window);%P=(1-K*Window)*P;
    A=A+K*(Window(1)-Window*A);
    Window(2:OrderNum)=Window(1:OrderNum-1);
    IterationTime=IterationTime+1;
end
CoeffA(1)=1;
CoeffA(2:size(A(end,:),2)+1)=A(end,:);
CoeffB=1;
end