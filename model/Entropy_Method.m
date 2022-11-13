function [W] = Entropy_Method(Z)
    [n,m] = size(Z);
    D = zeros(1,m);  % ��ʼ��������ϢЧ��ֵ��������
    for i = 1:m
        x = Z(:,i);  % ȡ����i�е�ָ��
        p = x / sum(x);
        e = -sum(p .* mylog(p)) / log(n); % ������Ϣ��
        D(i) = 1- e; % ������ϢЧ��ֵ
    end
    W = D ./ sum(D);  % ����ϢЧ��ֵ��һ�����õ�Ȩ��    
end