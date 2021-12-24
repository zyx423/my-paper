load('COIL20');
load('Y_COIL20_2');
P = 8;
C = 1;
Graph = zeros((32+2*P)*10,(32+2*P)*10);
for i = 1:10
    for j = 1:10
    index(i,j) = Y_pred_OS((i-1)*72+j*7+2+C*72); 
    index_1(i,j) = (index(i,j)-1)*72+(j-1)*7+1;
    sample = reshape(X(:,index_1(i,j)),32, 32);
    Graph((32+2*P)*(i-1)+P:(32+2*P)*(i-1)+P+31,(32+2*P)*(j-1)+P:(32+2*P)*(j-1)+P+31) = sample;
     
%     subplot(10,10,(i-1)*10+j);
%     set(gca,'position',[0.08+(j-1)*0.1, 0.08+(i-1)*0.1, 0.1, 0.1]);
%     hold on;
%     imshow(sample);   
    end
end
%imshow(Graph);
% 增强对比度；
figure;
Graph = Graph*1.2;
imshow(Graph);



