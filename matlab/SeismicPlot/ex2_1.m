% 加载所需的工具包
addpath(genpath('./SeisPlot'));

clc;clear;close all; 
% 读取sgy数据
Data = altreadsegy('data_shot.sgy');
dt=0.008;
spectrumplot(Data,dt,12)
