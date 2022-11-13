clear;clc
load shuweibei.mat
% ���򻯴���
[n,m] = size(shuweibei);
disp(['����' num2str(n) '�����۶���, ' num2str(m) '������ָ��']) 
v_z=1./(shuweibei(:,1));   %�Ե�һ��ָ��������򻯴���
shuweibei_z=[v_z,shuweibei(:,2)];
% �����򻯺�ľ�����б�׼��
Z = shuweibei_z./ repmat(sum(shuweibei_z.*shuweibei_z) .^ 0.5, n, 1);
% ��������ָ���Ȩ��
weight = Entropy_Method(Z);
weight=[0.275,0.725];  %�ӷ����ɸ�Ȩ����Ľ��
% weight=[0.25,0.75];  %���۸�Ȩ���¸���10%
% weight=[0.3,0.7];    %���۸�Ȩ���ϸ���10%
% ����topsis����������������������
D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;  
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;  
S = D_N ./ (D_P+D_N);    % δ��һ���ĵ÷�
stand_S = S / sum(S);
[sorted_S,index] = sort(stand_S ,'descend');
Max=sorted_S(1);
v_max=1/v_z(index(1));
for i=2:0.01:5.6
    [Max,v_max]=Xun(i,shuweibei_z,Max,n,weight,v_max);
end