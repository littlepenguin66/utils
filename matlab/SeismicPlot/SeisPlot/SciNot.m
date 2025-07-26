function SciNot(escale,varargin)

% ���÷�����
% SciNot(escale)
% SciNot(escale,'AxisName',Fontsize)
% SciNot(escale,'AxisName',Fontsize,'Fontname')
%
% �����ܡ����������ѧ������ʾ
%
% �����롿��1.escale  ��ָ��������������
%          2.'AxisName' ������: �� 'X','Y'�ȣ�Ĭ�� 'Y',�� Y�ᣩ
%          3.Fontsize �ֺŴ�С��Ĭ�� 10��
%          4.'Fontname' ����(�ַ�����������ֵʱ���� 'Times New Roman')
% 
% ���ο�����dreamtomvp�Ĳ��ͣ�������������������ԭ�£�
%
% �����ߡ���XXX,  Email: 2362538770@qq.com

if nargin>2
    Axisname=varargin{2};
else
    Axisname='Y';
end
if nargin>1
    fontsize1=varargin{1};
    fontname1='Helvetica';
else
    fontsize1=10;
    fontname1='Helvetica';
end
if nargin>3
    if ischar(varargin{3})
        fontname1=varargin{3};
    else
        fontname1='Times New Roman';
    end
end

escale=10.^escale;
oldLabels = str2num(get(gca,[Axisname 'TickLabel']));
Ylim1=get(gca,[Axisname 'lim']);
Ytick1=get(gca,[Axisname 'tick']);
Ytic=Ytick1(end); Ylab=oldLabels(end);
oldscale=10.^fix(log10(Ytic./Ylab)); 
oldLabels=oldscale.*oldLabels;

newLabels = num2str(oldLabels./escale);
set(gca,[Axisname 'lim'],Ylim1,[Axisname 'TickLabel'],newLabels,'units','normalized','fontsize',fontsize1,'fontname',fontname1);
posAxes = get(gca,'position');
textBox = annotation('textbox','linestyle','none','string',['x 10\it^{' sprintf('%d',log10(escale)) '}'],'fontsize',fontsize1,'fontname',fontname1);
posAn = get(textBox,'position');

if lower(Axisname)=='x'
    set(textBox,'position',[posAxes(1)+posAxes(3) posAxes(2) posAn(3) posAn(4)],'VerticalAlignment','cap');
else
    set(textBox,'position',[posAxes(1) posAxes(2)+posAxes(4)-0.4*posAn(4) posAn(3) posAn(4)],'VerticalAlignment','cap');   
end
end