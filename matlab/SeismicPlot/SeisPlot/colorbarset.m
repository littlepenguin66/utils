function colorbarset(ymin,ymax,fontsize)
%【作用】：设置色棒及其坐标
%【作者】：五道口勘探员
%【单位】：中国地质大学（北京），地球物理与信息技术学院
%【时间】：2020/11
%【参数】：ymin：色棒最小值
%         ymax：色棒最大值
%         fontsize：字体大小
%         fontname：字体
if nargin<3
    fontsize=10;
end
caxis([ymin,ymax]);
yti=ymin:(ymax-ymin)/4:ymax;
yla=num2str(yti');
set(colorbar,'ytick',yti,'yticklabel',yla)
set(gca,'fontsize',fontsize);
end