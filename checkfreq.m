% n=0:10e6;%�źŵĳ���
n = 0:30000
fs=3000;%����Ƶ��
freq = 550.1257
x=cos(2*pi*(freq/fs)*n);%����Ƶ��Ϊ550hz���ź�
%plot(n,x);
%hold on
y=awgn(x,10);%�ź��м��������������Ϊ10db
%plot(n,y);
N=length(n);
xk=fft(x,N);%��dft
re=real(xk);%ȡʵ��
[p1,kmr]=max(re)%�ҵ��������
d1=-re(kmr+1)/(re(kmr)-re(kmr+1));%��ֵ������һ���������ֵ
d2=re(kmr-1)/(re(kmr)-re(kmr-1));
if d1>0&&d2>0
        d=d1;
      else
        d=d2;
end
f0=(kmr+d)*fs/N;%���н���
f0 = f0 - fs/(length(n)-1);
df=f0-freq;%���
disp(['��׼Ƶ��Ϊ��',num2str(freq),'hz','�����Ƶ��Ϊ��',num2str(f0),'hz',',���Ϊ:',num2str(df),'hz']);
