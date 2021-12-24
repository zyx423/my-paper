img=imread('dog.jpg');
%img=imread('./cherry.jpg');
subplot(2,3,1);
imshow(img);
C = makecform('srgb2lab');       %����ת����ʽ
img_lab = applycform(img, C);
 
ab = double(img_lab(:,:,2:3));    %ȡ��lab�ռ��a������b����
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2); % ÿһ����һ������������ά��
 
nColors = 3;        %�ָ���������Ϊ3
[cluster_idx cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',3);  %�ظ�����3��
pixel_labels = reshape(cluster_idx,nrows,ncols);
subplot(2,3,2);
imshow(pixel_labels,[]), title('������');
 
 
%��ʾ�ָ��ĸ�������
segmented_images = cell(1,nColors);
rgb_label = repmat(pixel_labels,[1 1 nColors]);
 
for k = 1:nColors
    color = img;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end
subplot(2,3,3);
imshow(segmented_images{1},[]), title('�ָ�����������1');
subplot(2,3,4);
imshow(segmented_images{2}), title('�ָ�����������2');
subplot(2,3,5);
imshow(segmented_images{3}), title('�ָ�����������3');
