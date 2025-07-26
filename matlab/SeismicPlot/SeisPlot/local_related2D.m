function C=local_related2D(a,b,lent,lenx)
%�����á�������ֲ����ͼ
%�����ߡ�������ڿ�̽Ա
%����λ�����й����ʴ�ѧ����������������������Ϣ����ѧԺ
%��ʱ�䡿��2023/11
%����������
% a����������1��ȥ��ǰ����
% b����������2��ȥ�������
% lent�� ʱ�䷽�򴰳�
% lenx���ռ䷽�򴰳�
G1=gausswin(lent,lent/4);
G2=gausswin(lenx,lenx/4);
G=G1*G2';
[nt,nx]=size(a);
A=zeros(nt+lent-1,nx+lenx-1);
B=zeros(nt+lent-1,nx+lenx-1);
A(lent/2:nt+lent/2-1,lenx/2:nx+lenx/2-1)=a;
B(lent/2:nt+lent/2-1,lenx/2:nx+lenx/2-1)=b;
C=zeros(nt,nx);
for i=1:nt
    for j=1:nx
        AA=A(i:i+lent-1,j:j+lenx-1).*G;
        BB=B(i:i+lent-1,j:j+lenx-1).*G;
%         AA=A(i:i+lent-1,j:j+lenx-1);
%         BB=B(i:i+lent-1,j:j+lenx-1);
        AB=sqrt(norm(AA.*AA,'fro')*norm(BB.*BB,'fro'));
        if AB<1e-6
            C(i,j)=0;
        else
            C(i,j)=norm(AA.*BB,'fro')/AB;
        end
    end
end
end