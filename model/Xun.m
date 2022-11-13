function [y,v_max] = Xun(x,shuweibei_z,Max,n,weight,v_max)
a=1.375;
b=3.068;
c=-0.857;
if x<3.3
    f=0;
elseif x>5.5
    f=1;
else 
    f=a*(x-b).^(1/3)+c;
end
x=1./x;  % 正向化处理
Z = [shuweibei_z;[x,f]]./ repmat(sum([shuweibei_z;[x,f]].*[shuweibei_z;[x,f]]).^0.5, n+1, 1);
D_P = sum([(Z - repmat(max(Z),n+1,1)) .^ 2 ] .* repmat(weight,n+1,1) ,2) .^ 0.5;  
D_N = sum([(Z - repmat(min(Z),n+1,1)) .^ 2 ] .* repmat(weight,n+1,1) ,2) .^ 0.5;  
S = D_N ./ (D_P+D_N);    % 未归一化的得分
stand_S = S / sum(S);
[sorted_S,index] = sort(stand_S ,'descend');
Max1=sorted_S(1);
if Max1>Max
    Max=Max1;
    v_max=1/x;
end
y=Max;
v_max=1/x;
end

