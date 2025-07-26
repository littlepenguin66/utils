%% 绘图示例代码
% 数据读入
load crpz.mat
dt=0.004;
[nt,nx,ny]=size(crpz);
dx=16.667; dy=16.667;
t=0:dt:(nt-1)*dt;
x=1:nx;
y=1:ny;

set(0,'defaultfigurecolor','w')
profile=squeeze(crpz(:,:,100));
% 波形变面积
figure, wigbplot(profile(:,1:2:end),dt,1,0,1,12,0)
% 变密度
figure, imageplot(profile,dt,1,0,1,12,1)
% 单道标记
single_wigbplot(profile(:,1:2:end),10,0,dt,1,1,2.5)
colormap(seismic(1))
% 多道集显示
data(:,:,1)=squeeze(crpz(:,:,1));
data(:,:,2)=squeeze(crpz(:,:,50));
data(:,:,3)=squeeze(crpz(:,:,100));
figure,multi_plot(data,0,dt,0,'CMP')
% 三维显示
figure, imageplot3D(crpz,50,50,201,t,x,y)
%频谱
figure, spectrumplot(crpz,dt)
%fk谱
figure, fkplot(profile,dx,dt,50),set(gca,'LooseInset',get(gca,'TightInset')+0.01)
%信噪比谱
[profile2,noise]=addnoise(profile,2); %加入制定信噪比的随机噪声
[Rsn,F] = RSN(1,nt,1,nx,dt,0,60,profile2);
%局部相关谱
C=local_related(profile,profile2,50);
figure, imageplot(-C,dt),colormap(jet),clim([-1,1]),colorbar

%图形绘制技巧
figure,plot(x,y)
xti=0:41:nx; yti=0:41:ny;
figure,plot(x,y), tickset(xti,yti),xlabel('X'),ylabel('Y'), axis([0,205,0,205]), boxplot('k-',1.25)

%图形导出
print -f1 test -djpeg -r300
export_fig test2 -svg -r300 -append -transparent