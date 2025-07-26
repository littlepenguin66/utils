%% ��ͼʾ������
% ���ݶ���
load crpz.mat
dt=0.004;
[nt,nx,ny]=size(crpz);
dx=16.667; dy=16.667;
t=0:dt:(nt-1)*dt;
x=1:nx;
y=1:ny;

set(0,'defaultfigurecolor','w')
profile=squeeze(crpz(:,:,100));
% ���α����
figure, wigbplot(profile(:,1:2:end),dt,1,0,1,12,0)
% ���ܶ�
figure, imageplot(profile,dt,1,0,1,12,1)
% �������
single_wigbplot(profile(:,1:2:end),10,0,dt,1,1,2.5)
colormap(seismic(1))
% �������ʾ
data(:,:,1)=squeeze(crpz(:,:,1));
data(:,:,2)=squeeze(crpz(:,:,50));
data(:,:,3)=squeeze(crpz(:,:,100));
figure,multi_plot(data,0,dt,0,'CMP')
% ��ά��ʾ
figure, imageplot3D(crpz,50,50,201,t,x,y)
%Ƶ��
figure, spectrumplot(crpz,dt)
%fk��
figure, fkplot(profile,dx,dt,50),set(gca,'LooseInset',get(gca,'TightInset')+0.01)
%�������
[profile2,noise]=addnoise(profile,2); %�����ƶ�����ȵ��������
[Rsn,F] = RSN(1,nt,1,nx,dt,0,60,profile2);
%�ֲ������
C=local_related(profile,profile2,50);
figure, imageplot(-C,dt),colormap(jet),clim([-1,1]),colorbar

%ͼ�λ��Ƽ���
figure,plot(x,y)
xti=0:41:nx; yti=0:41:ny;
figure,plot(x,y), tickset(xti,yti),xlabel('X'),ylabel('Y'), axis([0,205,0,205]), boxplot('k-',1.25)

%ͼ�ε���
print -f1 test -djpeg -r300
export_fig test2 -svg -r300 -append -transparent