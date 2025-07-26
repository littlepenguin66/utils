function tickset(xti,yti,fontsize,xla,yla)
%�����á�������������
%�����ߡ�������ڿ�̽Ա
%����λ�����й����ʴ�ѧ����������������������Ϣ����ѧԺ
%��ʱ�䡿��2020/11
%����������xti��x��̶ȣ���������
%         yti��y��̶ȣ���������
%         fontsize�������С
%         fontname������
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