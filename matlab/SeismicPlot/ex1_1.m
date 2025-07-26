% 加载所需的工具包
addpath(genpath('./SeisPlot'));

clc;clear;close all; 
% 读取sgy数据
Data = altreadsegy('data_shot.sgy');

% 波形变面积
figure, wigbplot(Data,0.008,1,0,1,12,0,4)