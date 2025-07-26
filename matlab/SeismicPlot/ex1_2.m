% 加载所需的工具包
addpath(genpath('./SeisPlot'));

clc;clear;close all; 
% 读取sgy数据
Data = altreadsegy('data_shot.sgy');

% 变密度
figure
imageplot(Data,0.008,1,0,1,12,1)
colormap(seis_colors)
figure
imageplot(Data,0.008,1,0,1,12,1)
colormap(gray)
figure
imageplot(Data,0.008,1,0,1,12,1)
colormap(seismic(1))
figure
imageplot(Data,0.008,1,0,1,12,1)
colormap(seismic(2))