function hodogramplot(wavex,wavey,wavez,xmax,ymax,zmax,fontsize,color,width)
%�����á�������ʸ��ͼ
%�����ߡ�������ڿ�̽Ա
%����λ�����й����ʴ�ѧ����������������������Ϣ����ѧԺ
%����������
% wavex��x��������
% wavey��y��������
% wavez��z��������
% xmax��x�������Χ
% ymax��y�������Χ
% zmax��z�������Χ
% fontsize�������С
% color��������ɫ
% width���������
% plot3(wavex,wavey,wavez,color);
if nargin<=6
    fontsize=12;
end
if nargin<=7
    color='k-';
end
if nargin<=8
    width=1;
end
len=length(wavex);
plot3(wavex,wavey,-zmax*ones(len,1),color,'Linewidth',width) %�ر�ͼ��
hold on
plot3(wavex,ymax*ones(len,1),wavez,color,'HandleVisibility','off','Linewidth',width) %�ر�ͼ��
plot3(-xmax*ones(len,1),wavey,wavez,color,'HandleVisibility','off','Linewidth',width) %�ر�ͼ��
axis([-xmax,xmax,-ymax,ymax,-zmax,zmax])
grid on
xlabel('X','fontsize',fontsize); 
ylabel('Y','fontsize',fontsize); 
zlabel('Z','fontsize',fontsize);
plot3([-xmax,-xmax],[-ymax,ymax],[zmax,zmax],'k-','HandleVisibility','off')
plot3([-xmax,-xmax],[-ymax,ymax],[-zmax,-zmax],'k-','HandleVisibility','off')
plot3([-xmax,xmax],[ymax,ymax],[zmax,zmax],'k-','HandleVisibility','off')
plot3([-xmax,xmax],[ymax,ymax],[-zmax,-zmax],'k-','HandleVisibility','off')
plot3([-xmax,-xmax],[ymax,ymax],[-zmax,zmax],'k-','HandleVisibility','off')
plot3([xmax,xmax],[ymax,ymax],[-zmax,zmax],'k-','HandleVisibility','off')
view([45,20])
