function spectrumplot(data,dt,fontsize)
%����Ƶ�ף����Զ��̻�f-x��
%2019/11 �й����ʴ�ѧ����������������������Ϣ����ѧԺ������ڿ�̽Ա
%data����������
%dt��ʱ��������
% fontsize�������������С��Ĭ��Ϊ12����

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


