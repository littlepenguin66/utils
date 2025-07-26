function colorbarset(ymin,ymax,fontsize)
%�����á�������ɫ����������
%�����ߡ�������ڿ�̽Ա
%����λ�����й����ʴ�ѧ����������������������Ϣ����ѧԺ
%��ʱ�䡿��2020/11
%����������ymin��ɫ����Сֵ
%         ymax��ɫ�����ֵ
%         fontsize�������С
%         fontname������
if nargin<3
    fontsize=10;
end
caxis([ymin,ymax]);
yti=ymin:(ymax-ymin)/4:ymax;
yla=num2str(yti');
set(colorbar,'ytick',yti,'yticklabel',yla)
set(gca,'fontsize',fontsize);
end