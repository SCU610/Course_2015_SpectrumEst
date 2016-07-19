function [PowSpectrum,NorFreq,SegmentNum] = ImpPeriodogramAver( SignalIn,SignalLength,SampleNumPerSegment,OverlapNum,WindowType,UnitType )
%FileName: ImpPeriodogramAver.m
%Description: 用平均法改进的周期图法
if size(SignalIn,2)>1   %输入信号列数大于1报错
    error(message('Error! Invaild Input Signal Demension @ Function:"ImpPeriodogramAver.m"'));
end
if SignalLength<=0||SampleNumPerSegment<=0||OverlapNum<0
    error(message('Error! Window Size or Sample Number per Segment or Overlap Number @ Function:"ImpPeriodogramAver.m"'));
end
InputSignal=SignalIn(1:SignalLength,1);
if OverlapNum==0
   if mod(SignalLength,SampleNumPerSegment)~=0
       error(message('Error! WindowSize and SampleNumPerSegment are not match to each other @ Function:"ImpPeriodogramAver.m"'));
   end
   SegmentNum=SignalLength/SampleNumPerSegment;
else
    SegmentNum=fix(SignalLength/SampleNumPerSegment);
    SegmentNum=SegmentNum+fix((SignalLength-OverlapNum)/SampleNumPerSegment);
end
if fix(SampleNumPerSegment/OverlapNum)>2
    SegmentNum=SegmentNum-1;
end
if OverlapNum==0
    Index=1;
    while Index<=SegmentNum
        SegmentSignal(:,Index)=InputSignal((Index-1)*SampleNumPerSegment+1:Index*SampleNumPerSegment,1);
        Index=Index+1;
    end
else
    Index=1;
    OddIndex=1;
    EvenIndex=2;
    while Index<=SegmentNum
        if mod(Index,2)~=0
            SegmentSignal(:,Index)=InputSignal((OddIndex-1)*SampleNumPerSegment+1:OddIndex*SampleNumPerSegment,1);
            OddIndex=OddIndex+1;
        else
            SegmentSignal(:,Index)=InputSignal((EvenIndex-1)*SampleNumPerSegment-OverlapNum+1:EvenIndex*SampleNumPerSegment-OverlapNum,1);
            EvenIndex=EvenIndex+1;
        end
        Index=Index+1;
    end
end
WindowCoeff=WindowSelect(WindowType,SampleNumPerSegment);
Index=1;
while Index<=SegmentNum
    SegmentPowerSpectrum(:,Index)=ClassicPeriodogram(SegmentSignal(:,Index).*WindowCoeff,SampleNumPerSegment,0);
    Index=Index+1;
end
PowSpectrum=(sum((SegmentPowerSpectrum')))'/(SegmentNum.*mse(WindowCoeff));
NorFreq=0:1/(2^nextpow2(SampleNumPerSegment)):(1-1/(2^nextpow2(SampleNumPerSegment)));        %计算归一化频率
NorFreq=NorFreq';
if strcmp(UnitType,'dB')||strcmp(UnitType,'d')||strcmp(UnitType,'db')
    PowSpectrum=10*log10(PowSpectrum);
end
end

