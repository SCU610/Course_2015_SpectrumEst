function SignalCorr = Assist_CorrEst( InputSignal,DelayIndex,sType )
%Assist_CorrEst.m 此处显示有关此函数的摘要
%   此处显示详细说明
SampleNum=size(InputSignal,1);
if abs(DelayIndex)>SampleNum
    error(message('Error! Invaild DelayIndex @ Function:"Assist_CorrEst.m"'));
end
if strcmp(sType,'biased')||strcmp(sType,'b')
    SignalCorr=(InputSignal(1:SampleNum-abs(DelayIndex),:))'*InputSignal(abs(DelayIndex)+1:SampleNum,:)/SampleNum;
elseif strcmp(sType,'unbiased')||strcmp(sType,'u')
    SignalCorr=(InputSignal(1:SampleNum-abs(DelayIndex),:))'*InputSignal(abs(DelayIndex)+1:SampleNum,:)/(SampleNum-abs(DelayIndex));
else
    error(message('Error! Invaild sType @ Function:"Assist_CorrEst.m"'));
end

end

