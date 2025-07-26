addpath(genpath('./SeisPlot'));

clc;clear;close all; 
% 读取sgy数据
Data = altreadsegy('data_shot.sgy');
dx=20;
dt=0.008;
fmax=60;
fkplot(Data,dx,dt,fmax,12)
