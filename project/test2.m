clear all
%������Ϣ
% load mtlb
% mtlb = [1.000000000000000 2.133333333333 3 4 5 6 7 8 9 0 10];
% mtlb = floor(1000*mtlbo0)
message='when i was a boy,my mother told me "you will finish a great thing!" ';
% message = '[1 2 3 4  5 6 7 8  9 0 10]';
% message = mat2str(mtlb);
%�����źţ��ź���2���Ƶ�bit��
%ѵ������
trainingdata=randi(1,100);
%��Ϣ����
info=getsignal(message);
%��ѵ������ת����2pam˫���Ե��ź�
xn=dan2shuang(trainingdata);
%����ģ���ŵ�
K=5;
%�ŵ�����
delta=0.1;
actual=[0.05 -0.063 0.088 -0.126 -0.25 0.9047 0.25 0 0.126 0.038 0.088];
%ѵ������
y=filter(actual,1,xn);
y=awgn(y,20);
%�о�
N=length(y);
%�������
estimated_c=[0 0 0 0 0 1 0 0 0 0 0];
for k=1:N-2*K
    y_k=y(k:k+2*K);
    z_k=estimated_c*y_k';
    e_k=xn(k)-z_k;
    estimated_c=estimated_c+delta*e_k*y_k
    mes(k)=e_k^2;
    z(k)=z_k;
end
%%
%ֱ���о�����
xn=dan2shuang(info);
y=filter(actual,1,xn);
y=awgn(y,20);
%�о�
yn=decison(y);%û�о�����������
y=[y zeros(1,2*K)];%Ϊ�˾��������
N=length(y);
%�������
for k=1:N-2*K
    y_k=y(k:k+2*K);  
    z_k=estimated_c*y_k';
    sel=decison(z_k);
    sel2=dan2shuang(sel);
    e_k=sel2-z_k;
    estimated_c=estimated_c+delta*e_k*y_k;
    temp(k)=sel;
    mes(k)=e_k^2;
    
end
%�о�
figure
subplot(1,2,1);
stem(info,'red');title('ԭ���δ���������������ĶԱ�ͼ');
hold on;
stem(yn,'blue');
subplot(1,2,2)
stem(info,'red');title('Դ��;����������������ĶԱ�ͼ');
hold on;
stem(temp,'blue');
%���룺
temp=temp(1:end-7);
recieve=decode(temp);

disp(['�����õ�����Ϣ��',recieve]);
mesav=mean(mes);
disp(['�������ƽ��ֵ��',num2str(mesav)]);

radio = strcat(recieve,']')
leng=length(radio)
s=ones(1,floor(leng/2-1));
for i=2:floor(leng/2-1)
   s(i-1)=str2double(radio(2*i-2));
end
% for i=1:floor((leng)/2)
%     2*i
%    str2num(radio(2*i))
% end

% radio = char(radio)
% radio = str2double(radio)
% sound(s,Fs)
