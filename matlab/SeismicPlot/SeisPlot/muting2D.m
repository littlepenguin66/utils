function data=muting2D(data,v,t0,x,dt)
tn=sqrt(t0^2+x.^2/v^2);
[nt,ntrace]=size(data);
tnn=floor(tn/dt)+1;
for i=1:ntrace
    data(1:tnn(i),i)=0;
end
