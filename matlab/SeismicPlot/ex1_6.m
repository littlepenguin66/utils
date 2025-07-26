clc;clear;close all;
addpath(genpath('./SeisPlot'));
%使用合成数据synthetic_data
[dn,d]=synthetic_data();
dt=0.04;
imageplot3D(d,10,20,100,0:dt:(300-1)*dt,1:60,1:60)
figure
imageplot3D(dn,10,20,100,0:dt:(300-1)*dt,1:60,1:60)

%d是一个三维数据体，10，20和100是黑色虚线出现的位置，dt是采样间隔，300是数据的时间长度，后面的60就是道数和侧线数