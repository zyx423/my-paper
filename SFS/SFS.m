
function [Index,F_u_C, J]=SFS(X_label,X_unlabel,Y_label,S,beta,lambda)
%% Input
% X_label：d * n_label;
%X_unlabel: d * n_unlabel;
% Y_label: n_lable * C;
% S: similarity_matrix
% beta
% lambda
%% 全局相似度矩阵
X_train = [X_label, X_unlabel];
[d, n] = size(X_train);
Label_n = size(Y_label,1);
C = size(Y_label,2);
%% 加入先验信息
g=[randi([1,n]),randi([1,n]),randi([1,n])];
h=[randi([1,n]),randi([1,n]),randi([1,n])];
S(g,h)=1;
S(h,g)=1;
clear g h;
g=[randi([1,n]),randi([1,n]),randi([1,n])];
h=[randi([1,n]),randi([1,n]),randi([1,n])];
S(g,h)=0;
S(h,g)=0;
clear g h;
%% 构造度矩阵和拉普拉斯矩阵
S=(S+S')/2;
Du=diag(sum(S,2));
LP=Du-S;
%% 拉普拉斯矩阵分块；
LP_ll=LP(1:Label_n,1:Label_n);
LP_lu=LP(1:Label_n,(Label_n+1):n);
LP_ul=LP((Label_n+1):n,1:Label_n);
LP_uu=LP((Label_n+1):n,(Label_n+1):n);
%% 指示矩阵(先随机初始化一个F_u)
F_label=Y_label;
% 对F_u做一个虚拟的矩阵；
F_unlabel=zeros(n-Label_n,C);
% for i = 1: (n - L)
%     F_unlabel(i, randperm(C,1)) = 1;
% end
F=[F_label; F_unlabel];
Z = rand(d, C);
%% 目标函数和参数求解
t = 1;
alpha = 1;
err = 1;
D = eye(d); %初始化D
while t < 50
    %% 求解Z
    S_td = X_train*X_train' + lambda*D;
    N =((S_td)^(-1/2))*X_train*F; % 对N奇异值分解；
    [U,~,V] = svd(N, 0);
    M = U*V';
    Z = S_td^(-1/2)*M;
    D = diag(1./(2*sqrt((sum(Z.^2,2)+eps))));  
    
    %%  求解F_u;
    F_unlabel = (inv(alpha^2*eye(n-Label_n) + beta*LP_uu)) * (alpha*X_unlabel'*Z - beta*LP_ul*F_label); 
    F = [F_label; F_unlabel];    

    %%  求解 α
    alpha = trace(Z'*X_train*F)/trace(F'*F); 
   
    %% 目标函数
    J(t) = (norm((X_train'*Z - alpha*F), 'fro'))^2  + beta*trace(F'*LP*F) + lambda*sum(sqrt(sum(Z.*Z,2)+eps));
    J_1(t) = (norm((X_train'*Z - alpha*F), 'fro'))^2;
    J_2(t) = beta*trace(F'*LP*F);
    %J(t)=trace(Z'*X_train*X_train'*Z - alpha*Z'*X_train*F - alpha*F'*X_train'*Z + alpha*alpha*F'*F + beta*(F'*L*F) + lambda*(Z'*D*Z));
    %% 收敛判断
    if t>1
       err = abs(J(t)-J(t-1));
    end
    if err < 10^(-4)
        break;
    end
    t = t+1;
end
 %% 提取后的样本
z=sqrt(sum(Z.^2,2));
[~,Index] = sort(z,'descend');
[~, F_u_C] = max(F_unlabel, [], 2);
end