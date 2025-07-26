function [S,xti,yti]=folds(mx,my,dmx,dmy)
Xmin=min(mx); Xmax=max(mx);
Ymin=min(my); Ymax=max(my);
Nx=ceil((Xmax-Xmin)/dmx);
Ny=ceil((Ymax-Ymin)/dmy);
S=zeros(Nx,Ny);
for i=1:length(mx)
    imx = floor((mx(i) - Xmin)/dmx)+1;
    imy = floor((my(i) - Ymin)/dmy)+1;
    if imx>Nx
        imx=Nx;
    end
    if imy>Ny
        imy=Ny;
    end    
    S(imx,imy)=S(imx,imy)+1;
end
xti=Xmin:dmx:Xmin+dmx*Nx;
yti=Ymin:dmy:Ymin+dmy*Ny;
