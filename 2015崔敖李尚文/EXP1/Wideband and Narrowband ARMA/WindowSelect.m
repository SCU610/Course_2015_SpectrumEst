function WindowCoeff = WindowSelect( WindowType,Length )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if Length<1   
    error(message('Error! Invaild Input Length @ Function:"WindowSelect.m"'));
end
if strcmp(WindowType,'Hanning')||strcmp(WindowType,'hanning')||strcmp(WindowType,'Hann')||strcmp(WindowType,'hann')
    WindowCoeff=hann(Length);
elseif strcmp(WindowType,'Hamming')||strcmp(WindowType,'hamming')||strcmp(WindowType,'Hamm')||strcmp(WindowType,'hamm')
    WindowCoeff=hamming(Length);
elseif strcmp(WindowType,'Rectwin')||strcmp(WindowType,'rectwin')||strcmp(WindowType,'Rect')||strcmp(WindowType,'rect')
    WindowCoeff=rectwin(Length);
elseif strcmp(WindowType,'Triang')||strcmp(WindowType,'triang')||strcmp(WindowType,'Tri')||strcmp(WindowType,'tri')
    WindowCoeff=triang(Length);
elseif strcmp(WindowType,'Bartlett')||strcmp(WindowType,'bartlett')||strcmp(WindowType,'Bart')||strcmp(WindowType,'bart')
    WindowCoeff=bartlett(Length);
elseif strcmp(WindowType,'Parzen')||strcmp(WindowType,'parzen')||strcmp(WindowType,'Parz')||strcmp(WindowType,'parz')
    WindowCoeff=parzenwin(Length);
else
    WindowCoeff=rectwin(Length);
end

end

