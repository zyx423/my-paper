img=imread('dog.jpg');
%img=imread('./cherry.jpg');
subplot(2,3,1);
imshow(img);
C = makecform('srgb2lab');       %设置转换格式
img_lab = applycform(img, C);
 
ab = double(img_lab(:,:,2:3));    %取出lab空间的a分量和b分量
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2); % 每一行是一个样本，两个维度
 
nColors = 3;        %分割的区域个数为3
[cluster_idx cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',3);  %重复聚类3次
pixel_labels = reshape(cluster_idx,nrows,ncols);
subplot(2,3,2);
imshow(pixel_labels,[]), title('聚类结果');
 
 
%显示分割后的各个区域
segmented_images = cell(1,nColors);
rgb_label = repmat(pixel_labels,[1 1 nColors]);
 
for k = 1:nColors
    color = img;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end
subplot(2,3,3);
imshow(segmented_images{1},[]), title('分割结果——区域1');
subplot(2,3,4);
imshow(segmented_images{2}), title('分割结果——区域2');
subplot(2,3,5);
imshow(segmented_images{3}), title('分割结果——区域3');
