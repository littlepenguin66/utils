function multi_plot(data,t0,dt,iswigb,name)
%多道集绘制
%2023/9 中国地质大学（北京），地球物理与信息技术学院，五道口勘探员
% data：N个道集地震数据，排列方式 [nt, ntrace, N]
% dt：时间采样间隔，单位s（默认为0.002）
% t0：记录起始时间，单位s（默认为0）
% iswigb：是否使用wigb绘制，否则使用image绘制
% name：坐标轴显示的道集名字
[nt,ntrace,N]=size(data);
gap=2;
ntrace2=ntrace*N+gap*(N-1);
data2=zeros(nt,ntrace2);
for i=1:N
    nbgn=(ntrace+gap)*(i-1)+1;
    nend=nbgn+ntrace-1;
    data2(:,nbgn:nend)=data(:,:,i);
end
if iswigb
   wigbplot(data2,dt,1)
else 
    imageplot(data2,dt,1)
end
axis ij
box off
boxplot
inty=floor((nt-1)*dt*1000)/5000; %计算t轴标签位置
yti=(0:5)*inty+t0;
yti=roundn(yti,-2); %保留两位小数
set(gca,'ytick',yti,'yticklabel',num2str(yti'))
set(gca,'tickdir','out')
ylabel('Time (s)','fontsize',12);
x0=floor(ntrace/2);
intx=ntrace+gap;
xti=(0:N-1)*intx+x0;
for i=1:N
    yla(i,:)=[name,' ',num2str(i)];
end
set(gca,'xtick',xti,'xticklabel',yla)
set(gca,'XAxisLocation','top')
xlabel(' '); %设置坐标轴名

end