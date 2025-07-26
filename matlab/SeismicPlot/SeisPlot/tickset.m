function tickset(xti,yti,fontsize,xla,yla)
%【作用】：设置坐标轴
%【作者】：五道口勘探员
%【单位】：中国地质大学（北京），地球物理与信息技术学院
%【时间】：2020/11
%【参数】：xti：x轴刻度（行向量）
%         yti：y轴刻度（行向量）
%         fontsize：字体大小
%         fontname：字体
if nargin<3
    fontsize=11;
end
if nargin<4
   xla=num2str(xti');
end
if nargin<5
   yla=num2str(yti');
end
set(gca,'tickdir','out')
set(gca,'xtick',xti,'xticklabel',xla)
set(gca,'ytick',yti,'yticklabel',yla)
set(gca,'color','none');
set(gca,'fontsize',fontsize);
end