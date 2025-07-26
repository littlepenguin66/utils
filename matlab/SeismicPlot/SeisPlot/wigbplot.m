function wigbplot(D,dt,dx,t0,x0,fontsize,isagc,num,fmin,fmax,amax)
% �Ա������ʽ�������¼�����Զ��̻�t-x��
% 2019/11 �й����ʴ�ѧ����������������������Ϣ����ѧԺ������ڿ�̽Ա
% D����������
% dt��ʱ������������λs��Ĭ��Ϊ0.002��
% dx���ռ���������Ĭ��Ϊ1��
% t0����¼��ʼʱ�䣬��λs��Ĭ��Ϊ0��
% x0����¼��ʼ��λ�ã�Ĭ��Ϊ1��
% fontsize�������������С��Ĭ��Ϊ12����
% isagc���Ƿ�����Զ�������ƣ�Ĭ��Ϊ��
% num������Ŵ�����Ĭ��Ϊ1��
% fmin����ͨ�˲��ͽ�Ƶ�ʣ�Ĭ��Ϊ0��
% fmax����ͨ�˲��߽�Ƶ�ʣ�Ĭ��Ϊ0��
% amax���̻�����������Ĭ��Ϊ��������һ�룩

[nt,nx]=size(D); % ��ȡ�������ݵ�������ʱ�������������������������

if nargin<2
    dt=0.002; % ���δ�ṩdt��������Ĭ��ʱ��������Ϊ0.002s
end
if nargin<3
    dx=1; % ���δ�ṩdx��������Ĭ�Ͽռ�������Ϊ1
end
if nargin<4
    t0=0; % ���δ�ṩt0��������Ĭ�ϼ�¼��ʼʱ��Ϊ0s
end
if nargin<5
    x0=1; % ���δ�ṩx0��������Ĭ�ϼ�¼��ʼ��λ��Ϊ1
end
if nargin<6
    fontsize=12; % ���δ�ṩfontsize��������Ĭ�������СΪ12��
end
if nargin<7
    isagc=0; % ���δ�ṩisagc��������Ĭ�ϲ������Զ��������
end
if nargin<8
    num=1; % ���δ�ṩnum��������Ĭ������Ŵ���Ϊ1
end
if nargin<=9
    fmin=0; % ���δ�ṩfmin��������Ĭ�ϴ�ͨ�˲��ͽ�Ƶ��Ϊ0
end
if nargin<=10
    fmax=0; % ���δ�ṩfmax��������Ĭ�ϴ�ͨ�˲��߽�Ƶ��Ϊ0
end

cla; % �����ǰ�����ͼ��

tmax=(nt-1)*dt+t0; % �������ʱ�����
t=t0:dt:tmax; % ����ʱ����
x=x0:dx:(nx-1)*dx+x0; % ����x��

if isagc
    [D,~,~]=agc(D,dt); % ���isagcΪ1����Ե������ݽ����Զ��������
end

if fmax~=0
    D=butterband(double(D),t,fmin,fmax); % ���fmax��Ϊ0����Ե������ݽ��д�ͨ�˲�
end

if nargin<=9
    trmx= max(abs(D)); % ����ÿ����������
    amax=mean(trmx)/2; % ���δ�ṩamax��������Ĭ��amaxΪ���е���������ƽ��ֵ��һ��
end

%D(1:800,:)=0; % ע�͵��Ĵ��룬��������������ǰ800��ʱ�����������

wigb(D,num,x,t,amax); % ����wigb�������Ʊ���������¼ͼ

axis ij % ����y�᷽��Ϊ���ϵ���
xlabel('Trace number','fontsize',fontsize); % ����x���ǩΪ��Trace number������ָ�������С
ylabel('Time (s)','fontsize',fontsize); % ����y���ǩΪ��Time (s)������ָ�������С

intx=floor((nx-1)/4)*dx; % ����x���ǩ�ļ��
xti=(0:4)*intx+x0; % ����x���ǩ��λ��
inty=floor((nt-1)*dt*1000)/5000; % ����t���ǩ�ļ��
yti=(0:5)*inty+t0; % ����t���ǩ��λ��
yti=roundn(yti,-2); % ��t���ǩ������λС��

tickset(xti,yti,fontsize) % ����x���y��Ŀ̶ȼ���ǩ
boxplot % ��������ͼ���˴���������ӦΪbox on��������ʾ������߿�
set(gca,'XAxisLocation','top') % ��x�������ͼ�ζ���
end