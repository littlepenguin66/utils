function boxplot(color,linewidth)
%【作用】：绘制图像边框
%【作者】：五道口勘探员
%【单位】：中国地质大学（北京），地球物理与信息技术学院
%【时间】：2020/11
%【参数】：position：线段位置
%         color：线段颜色
%         linewidth：线宽
if nargin<1
    color='k';
end
if nargin<2
    linewidth=1.1;
end
box off
hold on
rr=axis; %获取坐标轴句柄
plot(rr(1:2),[rr(4),rr(4)],color,'LineWidth',linewidth,'HandleVisibility','off'); %绘制一条沿着图像下边框的实线
plot(rr(1:2),[rr(3),rr(3)],color,'LineWidth',linewidth,'HandleVisibility','off'); %绘制一条沿着图像上边框的实线
plot([rr(1),rr(1)],rr(3:4),color,'LineWidth',linewidth,'HandleVisibility','off');%绘制一条沿着图像左边框的实线
plot([rr(2),rr(2)],rr(3:4),color,'LineWidth',linewidth,'HandleVisibility','off');%绘制一条沿着图像右边框的实线
end