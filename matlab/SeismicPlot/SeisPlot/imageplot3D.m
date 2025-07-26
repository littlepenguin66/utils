function imageplot3D(data,slicex,slicey,slicez,t,xdim,ydim)
%��ά�����¼��ͼ
%2020/10 �й����ʴ�ѧ����������������������Ϣ����ѧԺ������ڿ�̽Ա
%data����������
%slicex: X������Ƭλ��
%slicey: Y������Ƭλ��
%slicez: ʱ�䷽����Ƭλ��
%t��ʱ��������
%xdim��x������
%ydim��y������
[nt,nx,ny]=size(data);
data2=zeros([ny,nx,nt]);
%��ά����
[x,y,z] = meshgrid(xdim,ydim,t);
%���������������渳ֵ��Ҫ��ʾ������
data2(1,:,:)=squeeze(data(:,:,slicey))';
data2(:,1,:)=squeeze(data(:,slicex,:))';
data2(:,:,1)=squeeze(data(slicez,:,:))';
slice(x,y,z,data2,xdim(1),ydim(1),t(1))
colormap(seis_colors)
colorbar off
shading interp
xlabel('Inline','fontsize',12,'Rotation',15); 
ylabel('Crossline','fontsize',12,'Rotation',-35); 
zlabel('Time (s)','fontsize',12); 
set(gca,'zdir','reverse')
hold on
axis([xdim(1),xdim(nx),ydim(1),ydim(ny),t(1),t(nt)])
ampm=0.6*max(abs(data2(:)));
clim([-ampm,ampm])
%���������
plot3([xdim(1),xdim(1)],[ydim(1),ydim(ny)],[t(1),t(1)],'k')
plot3([xdim(1),xdim(nx)],[ydim(1),ydim(1)],[t(1),t(1)],'k')
plot3([xdim(1),xdim(nx)],[ydim(ny),ydim(ny)],[t(1),t(1)],'k')
plot3([xdim(nx),xdim(nx)],[ydim(1),ydim(ny)],[t(1),t(1)],'k')
plot3([xdim(1),xdim(1)],[ydim(1),ydim(1)],[t(1),t(nt)],'k')
plot3([xdim(nx),xdim(nx)],[ydim(1),ydim(1)],[t(1),t(nt)],'k')

%�������
plot3([xdim(slicex),xdim(slicex)],[ydim(1),ydim(1)],[t(1),t(nt)],'k--','linewidth',1.5)
plot3([xdim(slicex),xdim(slicex)],[ydim(1),ydim(ny)],[t(1),t(1)],'k--','linewidth',1.5)
plot3([xdim(1),xdim(1)],[ydim(slicey),ydim(slicey)],[t(1),t(nt)],'k--','linewidth',1.5)
plot3([xdim(1),xdim(nx)],[ydim(slicey),ydim(slicey)],[t(1),t(1)],'k--','linewidth',1.5)
plot3([xdim(1),xdim(1)],[ydim(1),ydim(ny)],[t(slicez),t(slicez)],'k--','linewidth',1.5)
plot3([xdim(1),xdim(nx)],[ydim(1),ydim(1)],[t(slicez),t(slicez)],'k--','linewidth',1.5)

%����������
xti(1)=xdim(1);xti(2)=xdim(slicex);xti(3)= xdim(ceil(nx/2));xti(4)= xdim(nx);
xti=unique(sort(xti)); xla=num2cell(xti);
% xti=xdim(slicex);xla=num2cell(xti);
set(gca,'xtick',xti,'xticklabel',xla);%����x�������ǩ
yti(1)=ydim(1);yti(2)=ydim(slicey);yti(3)= ydim(ceil(ny/2));yti(4)= ydim(ny);
yti=unique(sort(yti)); yla=num2cell(yti);
% yti=ydim(slicey);yla=num2cell(yti);
set(gca,'ytick',yti,'yticklabel',yla);%����y�������ǩ
zti(1)=t(1);zti(2)=t(slicez);zti(3)= t(ceil(nt/2));zti(4)= t(nt);
zti=unique(sort(zti)); zla=num2cell(zti);
set(gca,'ztick',zti,'zticklabel',zla);%����z�������ǩ
set(gcf,'position',[200,200,400,500])
view(-30,20)
end
    
