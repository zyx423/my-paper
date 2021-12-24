function[X_label, X_unlabel, Y_label, Y_unlabel] = Data_Division(X, Y, P)
%% input��
    % X:the raw data��
    % Y:the raw label;
    % P: the number the labeled data;
%% Output:
    % X_label: the data has the label
    % X_unlabel: the data doesn't have the label;
    % Y_unlable: the true lable of the labeled data;
    % Y_unlabel: the true label of the unlabeled data;
    %% 
X = double(X);
Y = double(Y);
[D, N]=size(X);
if min(Y) == 0
    C = max(Y) + 1;
    Y = Y+1;
else
    C = max(Y);
end
%% 
Label_N_C = floor(P/C);
R_N = mod(P, C); % ����������ʣ�µļ�������ŵ�ǰ�������С�
if Label_N_C == 0
      error('the percentage of the label data is too small');  
end
%%
X_label = [];
X_unlabel = [];
Y_label = [];
Y_unlabel = [];
%%
for i = 1:C
Index = find(Y == i);
[m, ~] = size(Index); % m ��ÿ�����е������� 


if i<= R_N %����������������£���ǰR_N�����ÿ�������һ��������
    X_label_add = X(:, Index(1: Label_N_C+1));
    X_unlabel_add = X(:, Index(Label_N_C+1+1 : m));
    Y_label_add = Y(Index(1: Label_N_C+1));
    Y_unlabel_add = Y(Index(Label_N_C+1+1 : m));
else
        X_label_add = X(:, Index(1: Label_N_C));
        X_unlabel_add = X(:, Index(Label_N_C+1 : m));
        Y_label_add = Y(Index(1: Label_N_C));
        Y_unlabel_add = Y(Index(Label_N_C+1 : m));    
      
end
X_label = [X_label, X_label_add];
X_unlabel = [X_unlabel, X_unlabel_add];
Y_label = [Y_label; Y_label_add];
Y_unlabel = [Y_unlabel; Y_unlabel_add];
clear X_label_add X_unlabel_add Y_label_add Y_unlabel_add
end
end