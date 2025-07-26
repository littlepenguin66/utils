function sub_plot(trace1,trace2,lo,t1,t2,line1,line2)
if nargin<6
    line1='b-';
end
if nargin<7
    line2='r-';
end
axes('Position',lo),
plot(trace1(t1:t2),line1,'linewidth',1.2), hold on
plot(trace2(t1:t2),line2,'linewidth',1.2),
boxplot,
axis off,