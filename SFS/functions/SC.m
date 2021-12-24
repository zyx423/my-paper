function [M] =SC(X, C, S, k)
    if S == 1
        [~,temp, ~] = Laplacian_CAN(X, k);
    else
         [~,~,temp] = Laplacian_KNN(X, k);
    end;
    M=eig1(full(temp),C,0);
    M=M';
end
