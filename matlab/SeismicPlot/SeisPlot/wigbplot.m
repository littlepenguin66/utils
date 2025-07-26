function wigbplot(D,dt,dx,t0,x0,fontsize,isagc,num,fmin,fmax,amax)
% 以变面积形式画地震记录，并自动刻画t-x轴
% 2019/11 中国地质大学（北京），地球物理与信息技术学院，五道口勘探员
% D：地震数据
% dt：时间采样间隔，单位s（默认为0.002）
% dx：空间采样间隔（默认为1）
% t0：记录起始时间，单位s（默认为0）
% x0：记录起始道位置（默认为1）
% fontsize：坐标轴字体大小（默认为12磅）
% isagc：是否进行自动增益控制（默认为否）
% num：振幅放大倍数（默认为1）
% fmin：带通滤波低截频率（默认为0）
% fmax：带通滤波高截频率（默认为0）
% amax：刻画的最大振幅（默认为最大振幅的一半）

[nt,nx]=size(D); % 获取地震数据的行数（时间采样点数）和列数（道数）

if nargin<2
    dt=0.002; % 如果未提供dt参数，则默认时间采样间隔为0.002s
end
if nargin<3
    dx=1; % 如果未提供dx参数，则默认空间采样间隔为1
end
if nargin<4
    t0=0; % 如果未提供t0参数，则默认记录起始时间为0s
end
if nargin<5
    x0=1; % 如果未提供x0参数，则默认记录起始道位置为1
end
if nargin<6
    fontsize=12; % 如果未提供fontsize参数，则默认字体大小为12磅
end
if nargin<7
    isagc=0; % 如果未提供isagc参数，则默认不进行自动增益控制
end
if nargin<8
    num=1; % 如果未提供num参数，则默认振幅放大倍数为1
end
if nargin<=9
    fmin=0; % 如果未提供fmin参数，则默认带通滤波低截频率为0
end
if nargin<=10
    fmax=0; % 如果未提供fmax参数，则默认带通滤波高截频率为0
end

cla; % 清除当前画板的图案

tmax=(nt-1)*dt+t0; % 计算最大时间深度
t=t0:dt:tmax; % 生成时间轴
x=x0:dx:(nx-1)*dx+x0; % 生成x轴

if isagc
    [D,~,~]=agc(D,dt); % 如果isagc为1，则对地震数据进行自动增益控制
end

if fmax~=0
    D=butterband(double(D),t,fmin,fmax); % 如果fmax不为0，则对地震数据进行带通滤波
end

if nargin<=9
    trmx= max(abs(D)); % 计算每道的最大振幅
    amax=mean(trmx)/2; % 如果未提供amax参数，则默认amax为所有道最大振幅的平均值的一半
end

%D(1:800,:)=0; % 注释掉的代码，可能是用于屏蔽前800个时间采样的数据

wigb(D,num,x,t,amax); % 调用wigb函数绘制变面积地震记录图

axis ij % 设置y轴方向为从上到下
xlabel('Trace number','fontsize',fontsize); % 设置x轴标签为“Trace number”，并指定字体大小
ylabel('Time (s)','fontsize',fontsize); % 设置y轴标签为“Time (s)”，并指定字体大小

intx=floor((nx-1)/4)*dx; % 计算x轴标签的间隔
xti=(0:4)*intx+x0; % 生成x轴标签的位置
inty=floor((nt-1)*dt*1000)/5000; % 计算t轴标签的间隔
yti=(0:5)*inty+t0; % 生成t轴标签的位置
yti=roundn(yti,-2); % 将t轴标签保留两位小数

tickset(xti,yti,fontsize) % 设置x轴和y轴的刻度及标签
boxplot % 绘制箱线图（此处可能有误，应为box on，用于显示坐标轴边框）
set(gca,'XAxisLocation','top') % 将x轴放置在图形顶部
end