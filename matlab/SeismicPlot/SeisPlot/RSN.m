function [Rsn,F] = RSN(start_s,end_s,start_t,end_t,sample_t,fmin,fmax,records)
%2019/11 �й����ʴ�ѧ����������������������Ϣ����ѧԺ������ڿ�̽Ա
% start_s = input('������ʼ�����㣺');
% end_s = input('������ֹ�����㣺');
% start_t = input('������ʼ���ţ�');
% end_t = input('������ֹ���ţ�');
% sample_t = input('�������ʱ������');
% fmin = input('ѡ�������СƵ��');
% fmax = input('ѡ��������Ƶ��');
records = records(start_s:end_s,start_t:end_t);
[c,l] = size(records);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sum = zeros(c,1);
for i =1:1:l-1
    record_i = records(:,i);
    record_i1 = records(:,i+1);
    Ai = fft(record_i);
    Ai1 = fft(record_i1);
    sum = sum + (Ai.*conj(Ai1)+Ai1.*conj(Ai));
end
Ps=sum/(2*(l-1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sum = zeros(c,1);
for i=1:1:l
    record_i = records(:,i);
    Ai = fft(record_i);
    sum = sum+(Ai.*conj(Ai));
end
Pm=sum/l;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Rsn = Ps./(Pm-Ps);
F = ((0:c-1)*((1/sample_t)/c))';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(F,Rsn,'linewidth',1.1);
xlim([fmin,fmax]);
ylabel('Rsn','fontsize',12);
xlabel('Frequency (Hz)','fontsize',12)
set(gca, 'LineWidth',1.1)
box off
boxplot
set(gca,'tickdir','out')

end