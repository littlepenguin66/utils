function imageplot(D,dt,dx,t0,x0,fontsize,isagc,fmin,fmax,ampm,num)
%�Ա��ܶ���ʽ�������¼�����Զ��̻�t-x��
%2019/11 �й����ʴ�ѧ����������������������Ϣ����ѧԺ������ڿ�̽Ա
% data����������
% dt��ʱ������������λs��Ĭ��Ϊ0.002��
% dx���ռ���������Ĭ��Ϊ1��
% t0����¼��ʼʱ�䣬��λs��Ĭ��Ϊ0��
% x0����¼��ʼ��λ�ã�Ĭ��Ϊ1��
% fontsize�������������С��Ĭ��Ϊ12����
% isagc���Ƿ�����Զ�������ƣ�Ĭ��Ϊ��
% fmin����ͨ�˲��ͽ�Ƶ�ʣ�Ĭ��Ϊ0��
% fmax����ͨ�˲��߽�Ƶ�ʣ�Ĭ��Ϊ0��
% amax���̻�����������Ĭ��Ϊ��������һ�룩
% num������Ŵ�����Ĭ��Ϊ1��

if nargin<=1
    dt=0.002;
end
if nargin<=2
    dx=1;
end
if nargin<=3
    t0=0;
end
if nargin<=4
    x0=1;
end
if nargin<=5
    fontsize=12;
end
if nargin<=6
    isagc=0;
end
if nargin<=7
    fmin=0;
end
if nargin<=8
    fmax=0;
end
if nargin<=9
    ampm=1;
end
if nargin<=10
    num=1;
end
[nt,nx]=size(D);
t=t0:dt:(nt-1)*dt+t0;
x=x0:dx:(nx-1)*dx+x0;

if isagc
    D_avg=mean(abs(D(:)));
    D_std=std(abs(D(:)));
    amp1=D_avg+3*D_std;
    amp2=D_avg-3*D_std;       
    D(D>amp1)=amp1;
    D(D<amp2)=amp2; 
    [D,~,~]=agc(D,dt); 
end

if ampm==1
    D=D/max(abs(D(:)))*num;
end
if fmax~=0
    D=butterband(double(D),t,fmin,fmax);
end
pcolor(x,t,-1*D),
shading interp;
colorbar
axis ij
box off
boxplot
intx=floor((nx-1)/4)*dx; %����x���ǩλ��
xti=(0:4)*intx+x0;
inty=floor((nt-1)*dt*1000)/5000; %����t���ǩλ��
yti=(0:5)*inty+t0;
yti=roundn(yti,-2); %������λС��
tickset(xti,yti,fontsize)
set(gca,'linewidth',1.0); %�����߿�
xlabel('Trace number','fontsize',fontsize); %������������
ylabel('Time (s)','fontsize',fontsize); %������������
colormap(seis_colors)
clim([-ampm,ampm])
colorbar off
set(gca,'XAxisLocation','top')
% colorbarset(-ampm,ampm,fontsize)
% set(gca,'Position',[0.2 0.05 0.6 0.75]);
end