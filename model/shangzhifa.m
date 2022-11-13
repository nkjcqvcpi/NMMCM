clear;clc
load shuweibei.mat
% 正向化处理
[n,m] = size(shuweibei);
disp(['共有' num2str(n) '个评价对象, ' num2str(m) '个评价指标']) 
v_z=1./(shuweibei(:,1));   %对第一个指标进行正向化处理
shuweibei_z=[v_z,shuweibei(:,2)];
% 对正向化后的矩阵进行标准化
Z = shuweibei_z./ repmat(sum(shuweibei_z.*shuweibei_z) .^ 0.5, n, 1);
% 计算所有指标的权重
weight = Entropy_Method(Z);
weight=[0.275,0.725];  %加法集成赋权法后的结果
% 利用topsis方法对所有样本进行评价
D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;  
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;  
S = D_N ./ (D_P+D_N);    % 未归一化的得分
disp('最后的得分为：')
stand_S = S / sum(S)
[sorted_S,index] = sort(stand_S ,'descend')

%% 引入新的配送速度
x=input('请输入骑行速度:')
a=1.375;
b=3.068;
c=-0.857;
if x<3.3
    f=0
elseif 3.3<=x<=5.5
    f=a*(x-b).^(1/3)+c
else 
    f=1
end
x=1/x;  % 正向化处理
Z = [shuweibei_z;[x,f]]./ repmat(sum([shuweibei_z;[x,f]].*[shuweibei_z;[x,f]]) .^ 0.5, n+1, 1);
D_P = sum([(Z - repmat(max(Z),n+1,1)) .^ 2 ] .* repmat(weight,n+1,1) ,2) .^ 0.5;  
D_N = sum([(Z - repmat(min(Z),n+1,1)) .^ 2 ] .* repmat(weight,n+1,1) ,2) .^ 0.5;  
S = D_N ./ (D_P+D_N);    % 未归一化的得分
disp('最后的得分为：')
stand_S = S / sum(S)
[sorted_S,index] = sort(stand_S ,'descend')

