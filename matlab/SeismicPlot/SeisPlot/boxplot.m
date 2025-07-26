function boxplot(color,linewidth)
%�����á�������ͼ��߿�
%�����ߡ�������ڿ�̽Ա
%����λ�����й����ʴ�ѧ����������������������Ϣ����ѧԺ
%��ʱ�䡿��2020/11
%����������position���߶�λ��
%         color���߶���ɫ
%         linewidth���߿�
if nargin<1
    color='k';
end
if nargin<2
    linewidth=1.1;
end
box off
hold on
rr=axis; %��ȡ��������
plot(rr(1:2),[rr(4),rr(4)],color,'LineWidth',linewidth,'HandleVisibility','off'); %����һ������ͼ���±߿��ʵ��
plot(rr(1:2),[rr(3),rr(3)],color,'LineWidth',linewidth,'HandleVisibility','off'); %����һ������ͼ���ϱ߿��ʵ��
plot([rr(1),rr(1)],rr(3:4),color,'LineWidth',linewidth,'HandleVisibility','off');%����һ������ͼ����߿��ʵ��
plot([rr(2),rr(2)],rr(3:4),color,'LineWidth',linewidth,'HandleVisibility','off');%����һ������ͼ���ұ߿��ʵ��
end