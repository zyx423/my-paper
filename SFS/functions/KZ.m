function Y=KZ(Y)
if size(Y,2)==1
    [n]=size(Y,1);
    if min(Y)==0
        C=max(Y)+1;
    else 
        C=max(Y);
    end
    T=zeros(n,C);
    for i=1:n
        T(i,Y(i,1))=1;
    end
    Y=T;
end
