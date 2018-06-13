X = imread('1.jpg');
X = rgb2gray(X);
% X = imresize(X,[256 256]);
X = double(X);   
%��ͼ����С�����в�С���ֽ�  
[C,S]=wavedec2(X,2,'bior3.7');  
Y=wcodemat(X);   %��ͼ�����ֵ�������α��ɫ����
thr=20;      %������ֵ
[Xcompress1,cxd,lxd,perf0,perfl2]=wdencmp('gbl',C,S,'db4',2,thr,'h',1);
%��ͼ�����ȫ��ѹ��
Y1=wcodemat(Xcompress1);    %��ͼ�����ݽ���α��ɫ����
set(0,'defaultFigurePosition',[100,100,1000,500]);  
%�޸�ͼ��ͼ��λ�õ�Ĭ������
set(0,'defaultFigureColor',[1 1 1])        %�޸�ͼ�α�����ɫ������
figure                 %����ͼ����ʾ����
% colormap(gray(nbc));       %����ӳ����ͼ�ȼ�
X = uint8(X);
Y = uint8(Y);
Y1 = uint8(Y1);
% Y = immultiply(Y, 15);
% Y1 = immultiply(Y1, 25);
subplot(221),imshow(X,[]),axis square      %��ʾ
subplot(222),imshow(Y,[]),axis square      %��ʾ
subplot(223);imshow(Y1,[]),axis square
imwrite(X,'com_1.jpg')
imwrite(Y,'com_2.jpg')
imwrite(Y1,'com_3.jpg')
MSE_caculate(X,Y);
MSE_caculate(X,Y1);
start_info = imfinfo('H:\matlab\GUI_STUDY\GUI_sum\com_1.jpg');
start_size = start_info.FileSize;
s1_info = imfinfo('H:\matlab\GUI_STUDY\GUI_sum\com_2.jpg');
s1_size = s1_info.FileSize;
end_info = imfinfo('H:\matlab\GUI_STUDY\GUI_sum\com_3.jpg');
end_size = end_info.FileSize;


function mse = MSE_caculate(RGB,RGBI)
%% ��MSE��RGBΪѹ��ǰͼƬ��RGB1Ϊѹ����ͼƬ
D=RGB-RGBI;
mse = sum(D(:).*D(:))/prod(size(RGB));
end