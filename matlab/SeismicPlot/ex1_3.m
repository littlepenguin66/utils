% 加载所需的工具包
addpath(genpath('./SeisPlot'));
clc;clear;close all; 
% 读取sgy数据
Data = altreadsegy('data_shot.sgy');

figure
subImageplot(Data,0.008,1,[300,400,100,150],0,1,12,1)
colormap(seis_colors)
figure
imageplot(Data(300:400,100:150))
set(gca, 'Position', [0 0 1 1]); % 将坐标轴填充到整个绘图区域
set(gcf, 'Color', 'w'); % 设置背景为白色
