function A=AngleCompute(X,Y)
N1=length(X);
N2=length(X);
if N1~=N2
     disp('Error:X and Y must be the same size!');
else
    A=zeros(size(X));
    for i=1:N1
        A(i)=atan(Y(i)/X(i))+(1-sign(X(i)))/2*pi;
    end
    n=find(A>pi);
    A(n)=A(n)-2*pi;
    n1=find(A>=0);
    n2=find(A<0);
    A(n1)=A(n1)/pi*180;
    A(n2)=A(n2)/pi*180+360;
end
end
