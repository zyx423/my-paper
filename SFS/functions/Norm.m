function[X, Y, C]=Norm(X, Y, Normal)
%%
    if nargin < 3
       Normal = 1;
    end
    X = double(X);
    Y = double(Y);
    if size(X,2)==size(Y, 1)
        X=X;
    else 
        X=X';
    end
    %%
    class_set = unique(Y);
    C = length(class_set);
%%
    if Normal == 1
       X = zscore(X');
       X = X';
    end
%%
end