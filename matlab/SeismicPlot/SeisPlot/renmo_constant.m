function data=renmo_constant(dnmo,t,x,v)
[nt,nx]=size(dnmo);
data=zeros(size(dnmo));
dt=t(2)-t(1);
tmax=max(t);
if length(v)==1
    v=ones(size(x))*v;
end
parfor j=1:nx
    trace2=data(:,j);
    trace=dnmo(:,j);
    for i=1:nt   
        t0=t(i);
        tx=sqrt(t0^2+(x(j)^2/v(j)^2));
        if tx<=tmax
            lo=round(tx/dt)+1;
            trace2(lo)=trace(i);
        end
    end
    data(:,j)=trace2;
end