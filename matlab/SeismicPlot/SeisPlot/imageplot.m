function imageplot(D,dt,dx,t0,x0,fontsize,isagc,fmin,fmax,ampm,num)
%以变密度形式画地震记录，并自动刻画t-x轴
%2019/11 中国地质大学（北京），地球物理与信息技术学院，五道口勘探员
% data：地震数据
% dt：时间采样间隔，单位s（默认为0.002）
% dx：空间采样间隔（默认为1）
% t0：记录起始时间，单位s（默认为0）
% x0：记录起始道位置（默认为1）
% fontsize：坐标轴字体大小（默认为12磅）
% isagc：是否进行自动增益控制（默认为否）
% fmin：带通滤波低截频率（默认为0）
% fmax：带通滤波高截频率（默认为0）
% amax：刻画的最大振幅（默认为最大振幅的一半）
% num：振幅放大倍数（默认为1）

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
intx=floor((nx-1)/4)*dx; %计算x轴标签位置
xti=(0:4)*intx+x0;
inty=floor((nt-1)*dt*1000)/5000; %计算t轴标签位置
yti=(0:5)*inty+t0;
yti=roundn(yti,-2); %保留两位小数
tickset(xti,yti,fontsize)
set(gca,'linewidth',1.0); %设置线宽
xlabel('Trace number','fontsize',fontsize); %设置坐标轴名
ylabel('Time (s)','fontsize',fontsize); %设置坐标轴名
colormap(seis_colors)
clim([-ampm,ampm])
colorbar off
set(gca,'XAxisLocation','top')
% colorbarset(-ampm,ampm,fontsize)
% set(gca,'Position',[0.2 0.05 0.6 0.75]);
end