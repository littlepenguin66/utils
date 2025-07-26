% 加载所需的工具包
addpath(genpath('./SeisPlot'));

clc;clear;close all; 
% 读取sgy数据
Data = altreadsegy('data_shots.sgy');
data = zeros(625,201,3);
% 多道集显示
data(:,:,1)=Data(:,1:201);
data(:,:,2)=Data(:,202:402);
data(:,:,3)=Data(:,403:603);
dt=0.008;
figure,multi_plot(data,0,dt,0,'CMP')