function C=local_related2D(a,b,lent,lenx)
%【作用】：计算局部相关图
%【作者】：五道口勘探员
%【单位】：中国地质大学（北京），地球物理与信息技术学院
%【时间】：2023/11
%【参数】：
% a：输入数据1，去噪前数据
% b：输入数据2，去噪后数据
% lent： 时间方向窗长
% lenx：空间方向窗长
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