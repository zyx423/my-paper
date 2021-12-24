function [X]=SF(X)
for i=1:size(X,2)
    A=reshape(X(:,i),sqrt(size(X,1)),sqrt(size(X,1)));
    B=imresize(A,32/sqrt(size(X,1)));
    C(:,i)=reshape(B,1024,1);
end
X=C;
end