% 加载所需的工具包
addpath(genpath('./SeisPlot'));

clc;clear;close all; 
% 读取sgy数据
Data = altreadsegy('data_shot.sgy');

% 添加 10% 的高斯噪声
noise_level = 0.2; % 噪声水平为 10%
noisy_Data = imnoise(Data, 'gaussian', 0, noise_level^2); % 添加高斯噪声

C=local_related2D(noisy_Data,Data,40,10);
dt=0.008;
figure, imageplot(-C,dt),colormap(jet),clim([-1,1]),colorbar