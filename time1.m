function varargout = time1(varargin)
% TIME1 MATLAB code for time1.fig
%      TIME1, by itself, creates a new TIME1 or raises the existing
%      singleton*.
%
%      H = TIME1 returns the handle to a new TIME1 or the handle to
%      the existing singleton*.
%
%      TIME1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIME1.M with the given input arguments.
%
%      TIME1('Property','Value',...) creates a new TIME1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before time1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to time1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help time1

% Last Modified by GUIDE v2.5 22-May-2017 13:44:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @time1_OpeningFcn, ...
                   'gui_OutputFcn',  @time1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before time1 is made visible.
function time1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to time1 (see VARARGIN)
%   Timer properties.
%     AveragePeriod    - Average number of seconds between TimerFcn executions.
%     BusyMode         - Action taken when TimerFcn executions are in progress.
%     ErrorFcn         - Callback function executed when an error occurs.
%     ExecutionMode    - Mode used to schedule timer events.
%     InstantPeriod    - Elapsed time between the last two TimerFcn executions. 
%     Name             - Descriptive name of the timer object.
%     Period           - Seconds between TimerFcn executions.
%     Running          - Timer object running status.
%     StartDelay       - Delay between START and the first scheduled TimerFcn execution.
%     StartFcn         - Callback function executed when timer object starts.
%     StopFcn          - Callback function executed after timer object stops.
%     Tag              - Label for object.
%     TasksExecuted    - Number of TimerFcn executions that have occurred.
%     TasksToExecute   - Number of times to execute the TimerFcn callback.
%     TimerFcn         - Callback function executed when a timer event occurs.
%     Type             - Object type.
%     UserData         - User data for timer object.

global Fs
Fs = 8000;         %����Ƶ��




% Choose default command line output for time1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes time1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = time1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop1
stop1 = 1
num = 0;
while(stop1)
% Plot the waveform.
    % Record your voice for 5 seconds.
    recObj = audiorecorder;
%     disp('Start speaking.')
    recordblocking(recObj, 0.1);

    % Play back the recording.
%     play(recObj);

    % Store data in double-precision array.
    myRecording = getaudiodata(recObj);
%     x = 0
    axes(handles.axes1)
    plot(myRecording);
    ylim([-1,1])
    xlabel('ʵʱ����')
    ylabel('����')
    title('¼������')
    fft_x = fftshift(fft(myRecording));
    w = linspace(-4000, 4000, 800);
    axes(handles.axes2)
    plot(w,abs(fft_x));
%     xlim([x,x+300])
    xlabel('HZ')
    ylabel('����')
    title('Ƶ�׷���')
    %% ��ʾƵ��
    if(num>5)
        result = []
        num = 0
        for freq =1:1:length(fft_x)
            if (fft_x(freq) > 30) & (freq > 0.5*length(fft_x))
                freq = (freq - 0.5*length(fft_x) -1)*10.005;
                result = [result freq]
            end
        end
        set(handles.listbox1,'string',result);
    end
    num = num+1
end

    
    
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop1
stop1 = 0
disp('End of Recording.');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
hold off
plot(1,1)
axes(handles.axes2)
hold off
plot(1,1)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% n=0:10e6;%�źŵĳ���
n = 0:80000
amp = 39690;
fs=8000;%����Ƶ��
A0 = get(handles.edit3,'string');
A0 = str2double(A0);
freq = get(handles.edit2,'string');
freq = str2double(freq);
x=A0 * cos(2*pi*(freq/fs)*n);%����Ƶ��Ϊ550hz���ź�
%plot(n,x);
%hold on
y=awgn(x,10);%�ź��м��������������Ϊ10db
%plot(n,y);
N=length(n);
xk=fft(x,N);%��dft
re=real(xk);%ȡʵ��
[~,kmr]=max(re);%�ҵ��������
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

%% ʱ����ͼ
axes(handles.axes1)
plot(n,x);
xlabel('t')
ylabel('���Ҳ�')
title('ʱ����ͼ')
axis([0,3000, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(x,N))
w = (-(N-1)/2:1:(N-1)/2)*0.1;
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,2000])
xlabel('Ƶ��/HZ')
ylabel('abs')
title('Ƶ��ͼ')
A = max(abs(Y))/amp;
% result = ['Ƶ�ʲ���ֵ',f0,'Ƶ�ʲ������',df,'���Ȳ���ֵ',A,'���Ȳ������',A-A0];
result = [f0,df,A,A-A0];
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(x,fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*697*t)+sin(2*pi*1209*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*697*t)+sin(2*pi*1336*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*697*t)+sin(2*pi*1477*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)


% --- Executes on button press in pushbuttona.
function pushbuttona_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttona (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*697*t)+sin(2*pi*1633*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*770*t)+sin(2*pi*1209*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*770*t)+sin(2*pi*1336*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('����5�����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*770*t)+sin(2*pi*1477 *t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('����6�����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)



% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*770*t)+sin(2*pi*1633*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���') 
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*852*t)+sin(2*pi*1209*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)



% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*852*t)+sin(2*pi*1336*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*852*t)+sin(2*pi*1477*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*852*t)+sin(2*pi*1633*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)



% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*941*t)+sin(2*pi*1209*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*1336*t)+sin(2*pi*941*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)



% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*1477*t)+sin(2*pi*941*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs
global Y
dt = 1.0/Fs;         %����ʱ����
T = 1;
N = T/dt;             %������������λʱ���ڵģ�
t = linspace(0, T, N);     %����Ϊ1s������ΪN��ʱ���         
y0 = sin(2*pi*1633*t)+sin(2*pi*941*t);          %�Դ����ú���
axes(handles.axes1)
plot(t,y0);
xlabel('t(����ȡ��0.1)')
ylabel('�����ֲ����Ĳ���')
axis([0,0.1, -2, 2]);
%% Ƶ��ͼ
Y = fftshift(fft(y0,N))
w = (-(N-1)/2:1:(N-1)/2);
axes(handles.axes2)
plot(w,abs(Y))
axis([-1700,1700,0,1300])
xlabel('Ƶ��/HZ')
ylabel('����')
title('�źŵ�Ƶ��')
%% ��ʾƵ��
result = []
for freq =1:1:length(Y)
    if (Y(freq) > 700) & (freq > N/2)
        freq = freq - (N)/2 -1;
        result = [result freq]; 
    end
end
set(handles.listbox1,'string',result);
%% ������������������
p = audioplayer(y0,Fs);                                     %����Ԫ��p
play(p);                                                                %����p
pause(0.5)


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
I=imread('DTMF.jpg');
imshow(I);
% Hint: place code in OpeningFcn to populate axes5



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
I=imread('uestc.jpg');
imshow(I);
% Hint: place code in OpeningFcn to populate axes6



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
