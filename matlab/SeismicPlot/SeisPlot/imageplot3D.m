function imageplot3D(data,slicex,slicey,slicez,t,xdim,ydim)
%三维地震记录绘图
%2020/10 中国地质大学（北京），地球物理与信息技术学院，五道口勘探员
%data：地震数据
%slicex: X方向切片位置
%slicey: Y方向切片位置
%slicez: 时间方向切片位置
%t：时间轴向量
%xdim：x轴向量
%ydim：y轴向量
[nt,nx,ny]=size(data);
data2=zeros([ny,nx,nt]);
%三维网格
[x,y,z] = meshgrid(xdim,ydim,t);
%立方体正侧上三面赋值需要显示的剖面
data2(1,:,:)=squeeze(data(:,:,slicey))';
data2(:,1,:)=squeeze(data(:,slicex,:))';
data2(:,:,1)=squeeze(data(slicez,:,:))';
slice(x,y,z,data2,xdim(1),ydim(1),t(1))
colormap(seis_colors)
colorbar off
shading interp
xlabel('Inline','fontsize',12,'Rotation',15); 
ylabel('Crossline','fontsize',12,'Rotation',-35); 
zlabel('Time (s)','fontsize',12); 
set(gca,'zdir','reverse')
hold on
axis([xdim(1),xdim(nx),ydim(1),ydim(ny),t(1),t(nt)])
ampm=0.6*max(abs(data2(:)));
clim([-ampm,ampm])
%立方体边线
plot3([xdim(1),xdim(1)],[ydim(1),ydim(ny)],[t(1),t(1)],'k')
plot3([xdim(1),xdim(nx)],[ydim(1),ydim(1)],[t(1),t(1)],'k')
plot3([xdim(1),xdim(nx)],[ydim(ny),ydim(ny)],[t(1),t(1)],'k')
plot3([xdim(nx),xdim(nx)],[ydim(1),ydim(ny)],[t(1),t(1)],'k')
plot3([xdim(1),xdim(1)],[ydim(1),ydim(1)],[t(1),t(nt)],'k')
plot3([xdim(nx),xdim(nx)],[ydim(1),ydim(1)],[t(1),t(nt)],'k')

%剖面边线
plot3([xdim(slicex),xdim(slicex)],[ydim(1),ydim(1)],[t(1),t(nt)],'k--','linewidth',1.5)
plot3([xdim(slicex),xdim(slicex)],[ydim(1),ydim(ny)],[t(1),t(1)],'k--','linewidth',1.5)
plot3([xdim(1),xdim(1)],[ydim(slicey),ydim(slicey)],[t(1),t(nt)],'k--','linewidth',1.5)
plot3([xdim(1),xdim(nx)],[ydim(slicey),ydim(slicey)],[t(1),t(1)],'k--','linewidth',1.5)
plot3([xdim(1),xdim(1)],[ydim(1),ydim(ny)],[t(slicez),t(slicez)],'k--','linewidth',1.5)
plot3([xdim(1),xdim(nx)],[ydim(1),ydim(1)],[t(slicez),t(slicez)],'k--','linewidth',1.5)

%设置坐标轴
xti(1)=xdim(1);xti(2)=xdim(slicex);xti(3)= xdim(ceil(nx/2));xti(4)= xdim(nx);
xti=unique(sort(xti)); xla=num2cell(xti);
% xti=xdim(slicex);xla=num2cell(xti);
set(gca,'xtick',xti,'xticklabel',xla);%设置x坐标轴标签
yti(1)=ydim(1);yti(2)=ydim(slicey);yti(3)= ydim(ceil(ny/2));yti(4)= ydim(ny);
yti=unique(sort(yti)); yla=num2cell(yti);
% yti=ydim(slicey);yla=num2cell(yti);
set(gca,'ytick',yti,'yticklabel',yla);%设置y坐标轴标签
zti(1)=t(1);zti(2)=t(slicez);zti(3)= t(ceil(nt/2));zti(4)= t(nt);
zti=unique(sort(zti)); zla=num2cell(zti);
set(gca,'ztick',zti,'zticklabel',zla);%设置z坐标轴标签
set(gcf,'position',[200,200,400,500])
view(-30,20)
end
    
