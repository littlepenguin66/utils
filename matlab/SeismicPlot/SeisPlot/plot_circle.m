function plot_circle(x0,y0,r,linetype,fillcolor)
theta=0:pi/100:2*pi;
x=x0+r*cos(theta);
y=y0+r*sin(theta);
plot(x,y,linetype)
fill(x,y,fillcolor)
axis equal
end


