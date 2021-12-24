function [A, L, Ln] = Laplacian_KNN(X, k)
% each column is a data

    if nargin < 2
          k = 9;
    end


    [nFea, nSmp] = size(X);
    D = L2_distance_1(X,X);
    W = spalloc(nSmp,nSmp,20*nSmp);

    [dumb idx] = sort(D, 2); % sort each row

    for i = 1 : nSmp
        W(i,idx(i,2:k+1)) = 1;         
    end
    W = (W+W')/2;
    
    D = diag(sum(W,2));
    L = D - W;
    A = W;
    
    %% 标准化后的拉普拉斯矩阵
    Dd = diag(D)+10^-12;
    Dn=diag(sqrt(1./Dd)); 
    Dn = sparse(Dn);
    An = Dn*W*Dn; 
    An = (An+An')/2;
    Ln=speye(size(W,1)) - An;
end
    
    
    
    