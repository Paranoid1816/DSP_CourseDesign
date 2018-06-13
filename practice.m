X = imread('uestc.jpg') ;
X = rgb2gray(X);
X = imresize(X,[256 256]);
X = double(X);
subplot(2,2,1);image(X); 
colormap(map);
xlabel('(a) ԭʼͼ��');
axis square    
disp('ѹ��ǰͼ��X�Ĵ�С');       % ��ʾ����
whos('X')                         % ��ʾͼ������
%��ͼ����С�����в�С���ֽ�
[c,s]=wavedec2(X,2,'bior3.7');    %��ȡС���ֽ�ṹ�е�һ��ĵ�Ƶϵ���͸�Ƶϵ��
cal=appcoef2(c,s,'bior3.7',1);   %ˮƽ����
ch1=detcoef2('h',c,s,1);         %��ֱ����
cv1=detcoef2('v',c,s,1);         %б�߷���
cd1=detcoef2('d',c,s,1);
%��Ƶ�ʳɷ��ع�
a1=wrcoef2('a',c,s,'bior3.7',1);
h1=wrcoef2('h',c,s,'bior3.7',1);
v1=wrcoef2('v',c,s,'bior3.7',1);
d1=wrcoef2('d',c,s,'bior3.7',1);
c1=[a1,h1;v1,d1];
%��ʾ��Ƶ��Ϣ
subplot(2,2,2);image(c1); 
colormap(jet)                     % ����ɫ������ͼ
axis square;                      % ������ʾ����
xlabel ('(b) �ֽ���Ƶ�͸�Ƶ��Ϣ');
ca1=appcoef2(c,s,'bior3.7',1);
ca1=wcodemat(ca1,440,'mat',0);
%�ı�ͼ��߶Ȳ���ʾ
ca1=0.5*ca1;
subplot(2,2,3);image(ca1); 
colormap(map);                    % ����ɫ������ͼ
axis square;                      % ������ʾ����
xlabel('(c) ��һ��ѹ��ͼ��');
disp('��һ��ѹ��ͼ��Ĵ�СΪ��'); % ��ʾ����
whos('ca1')                       % ��ʾͼ������
%����С���ֽ�ڶ����Ƶ��Ϣ����ѹ��
ca2=appcoef2(c,s,'bior3.7',2);
%���ȶԵڶ�����Ϣ������������
ca2=wcodemat(ca2,440,'mat',0);
%�ı�ͼ��߶Ȳ���ʾ
ca2=0.25*ca2;
subplot(2,2,4);image(ca2);  
colormap(map);                    % ����ɫ������ͼ
axis square;                      % ������ʾ����
xlabel('(d) �ڶ���ѹ��ͼ��');  
disp('�ڶ���ѹ��ͼ��Ĵ�СΪ��'); % ��ʾ����
whos('ca2')                       % ��ʾͼ������