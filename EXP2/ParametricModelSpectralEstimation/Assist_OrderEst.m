function OrderNum = Assist_OrderEst( DataLength,Type )
%Assist_OrderEst.m 此处显示有关此函数的摘要
%   此处显示详细说明
if isstr(Type)==1
    if strcmp(Type,'Exp')||strcmp(Type,'exp')
        if mod(DataLength,2)==0&&mod(DataLength,3)~=0
            OrderNum=DataLength/2;
        elseif mod(DataLength,3)==0&&mod(DataLength,2)~=0
            OrderNum=DataLength/3;
        elseif mod(DataLength,2)==0&&mod(DataLength,3)==0
            OrderNum=DataLength/2;
        else
            error(message('Error! Invaild DataLength or Type @ Function:"Assist_OrderEst.m"'));
        end
    elseif strcmp(Type,'Inf')||strcmp(Type,'inf')
        OrderNum=inf;
    else
        error(message('Error! Unsurpport Type @ Function:"Assist_OrderEst.m"'));
    end
elseif isstr(Type)==0
    if Type>0
        OrderNum=Type;
    else
        error(message('Error! Invaild Order @ Function:"Assist_OrderEst.m"'));
    end
else
    error(message('Error! Internal Error @ Function:"Assist_OrderEst.m"'));
end
end

