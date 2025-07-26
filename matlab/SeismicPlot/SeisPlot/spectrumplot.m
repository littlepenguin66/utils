function spectrumplot(data,dt,fontsize)
%绘制频谱，并自动刻画f-x轴
%2019/11 中国地质大学（北京），地球物理与信息技术学院，五道口勘探员
%data：地震数据
%dt：时间采样间隔
% fontsize：坐标轴字体大小（默认为12磅）

if nargin<=2
    fontsize=12;
end
[nt,nx]=size(data);
dataf=fft(data);
df=1/nt/dt;
fmax=1/2/dt;
f=0:df:fmax;
dataf=fft(data); 
spex=sum(abs(dataf),2); 
plot(f,spex(1:length(f)))
set(gca,'tickdir','out')
xlabel('Frequency (Hz)','fontsize',fontsize);
ylabel('Amplitude','fontsize',fontsize);
boxplot
end


