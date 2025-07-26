function hodogramplot(wavex,wavey,wavez,xmax,ymax,zmax,fontsize,color,width)
%【作用】：绘制矢端图
%【作者】：五道口勘探员
%【单位】：中国地质大学（北京），地球物理与信息技术学院
%【参数】：
% wavex：x分量波形
% wavey：y分量波形
% wavez：z分量波形
% xmax：x方向最大范围
% ymax：y方向最大范围
% zmax：z方向最大范围
% fontsize：字体大小
% color：线条颜色
% width：线条宽度
% plot3(wavex,wavey,wavez,color);
if nargin<=6
    fontsize=12;
end
if nargin<=7
    color='k-';
end
if nargin<=8
    width=1;
end
len=length(wavex);
plot3(wavex,wavey,-zmax*ones(len,1),color,'Linewidth',width) %关闭图例
hold on
plot3(wavex,ymax*ones(len,1),wavez,color,'HandleVisibility','off','Linewidth',width) %关闭图例
plot3(-xmax*ones(len,1),wavey,wavez,color,'HandleVisibility','off','Linewidth',width) %关闭图例
axis([-xmax,xmax,-ymax,ymax,-zmax,zmax])
grid on
xlabel('X','fontsize',fontsize); 
ylabel('Y','fontsize',fontsize); 
zlabel('Z','fontsize',fontsize);
plot3([-xmax,-xmax],[-ymax,ymax],[zmax,zmax],'k-','HandleVisibility','off')
plot3([-xmax,-xmax],[-ymax,ymax],[-zmax,-zmax],'k-','HandleVisibility','off')
plot3([-xmax,xmax],[ymax,ymax],[zmax,zmax],'k-','HandleVisibility','off')
plot3([-xmax,xmax],[ymax,ymax],[-zmax,-zmax],'k-','HandleVisibility','off')
plot3([-xmax,-xmax],[ymax,ymax],[-zmax,zmax],'k-','HandleVisibility','off')
plot3([xmax,xmax],[ymax,ymax],[-zmax,zmax],'k-','HandleVisibility','off')
view([45,20])
