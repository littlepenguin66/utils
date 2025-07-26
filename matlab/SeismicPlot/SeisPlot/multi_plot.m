function multi_plot(data,t0,dt,iswigb,name)
%���������
%2023/9 �й����ʴ�ѧ����������������������Ϣ����ѧԺ������ڿ�̽Ա
% data��N�������������ݣ����з�ʽ [nt, ntrace, N]
% dt��ʱ������������λs��Ĭ��Ϊ0.002��
% t0����¼��ʼʱ�䣬��λs��Ĭ��Ϊ0��
% iswigb���Ƿ�ʹ��wigb���ƣ�����ʹ��image����
% name����������ʾ�ĵ�������
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
inty=floor((nt-1)*dt*1000)/5000; %����t���ǩλ��
yti=(0:5)*inty+t0;
yti=roundn(yti,-2); %������λС��
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
xlabel(' '); %������������

end