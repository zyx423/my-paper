function [label,obj, lam, Center]=SWULDA(X,C,f) 
%X:  Dataset£»
%k£ºDimension of the subspace£»
%c£ºClass£»
%W: Projection transformation matrix;
%G:  Gard label matrix;
%% Initialization matrix
tic;
[d,n]=size(X);
%% initialization G and each row of G has only one 1£»
G=zeros(n,C);
for i=1:n
    g=randi([1,C]);
    G(i,g)=1;
end
lambda=1;
err = 1;
obj = [];
lam = [];
%% Iteration
for t = 1:40
    %% Solving W;
    temp=X*((lambda^2).*(eye(n)-G*(inv(G'*G+eps.*eye(C)))*G')-lambda.*eye(n))*X';  
    [W,~,~] = eig1(temp, f, 0);
    clear temp;     
    %% Solving F;
    F=W'*X*G*(inv(G'*G+eps.*eye(C))); 
    %% objective value;
    obj(t)=lambda*lambda*(norm(W'*X-F*G','fro')^2) - lambda*trace(W'*X*X'*W);
    if t > 2
        err=abs(obj(t)-obj(t-1));
    end
    if err < 10^-3
        break 
    end
    %% Solving G;
    G = zeros(n,C);
    for i=1:n
        for j=1:C
            z(j)=norm(W'*X(:,i)-F(:,j),2);
        end
        [~,ind]=min(z);
        G(i,ind)=1;
        clear z;
    end 
    %% Solving lamda;
    lam(t) = lambda;
    lambda=trace(W'*X*X'*W)/(2*(norm(W'*X-F*G','fro')^2));     
end
toc;
label=vec2ind(G')';
Center = [];
for i = 1:C
       Center(:, i) = mean(X(:,label == i),2);
end
end


