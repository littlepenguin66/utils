function fkplot(data,dx,dt,fmax,fontsize)
%����Fk�ף����Զ��̻�t-x��
%2019/11 �й����ʴ�ѧ����������������������Ϣ����ѧԺ������ڿ�̽Ա
%data����������
%dx�������
%dt��ʱ��������
%fmax�����Ƶ��
% fontsize�������������С��Ĭ��Ϊ11����

if nargin<=4
    fontsize=11;
end
    [nt,nx]=size(data);
    cla;
    nf=2^nextpow2(nt);
    nk=2^nextpow2(nx);
    AF=fftshift(abs(fft2(data,nf,nk)));
    f=(0:1:nf/2)/nf/dt;
    k=(-nk/2+1:1:nk/2)/nk/dx;
    imagesc(k,f,AF(nf/2:nf,:));    
    colormap(jet);
    colorbar    
    boxplot
    axis([-1/(2*dx) 1/(2*dx) 0 fmax]);
    set(gca,'tickdir','out');
    set(gca,'XAxisLocation','top')
    set(gca,'fontsize',fontsize,'fontname','Arial');
    set(gca,'linewidth',1.0);
    xlabel('Wavenumber (1/m)','fontsize',fontsize);
    ylabel('Frequency (Hz)','fontsize',fontsize);
end