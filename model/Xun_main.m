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
% weight=[0.25,0.75];  %主观赋权向下浮动10%
% weight=[0.3,0.7];    %主观赋权向上浮动10%
% 利用topsis方法对所有样本进行评价
D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;  
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;  
S = D_N ./ (D_P+D_N);    % 未归一化的得分
stand_S = S / sum(S);
[sorted_S,index] = sort(stand_S ,'descend');
Max=sorted_S(1);
v_max=1/v_z(index(1));
for i=2:0.01:5.6
    [Max,v_max]=Xun(i,shuweibei_z,Max,n,weight,v_max);
end