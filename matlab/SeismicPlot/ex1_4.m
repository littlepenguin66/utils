% 加载所需的工具包
addpath(genpath('./Codes'));

clc;clear;close all; 
% 读取sgy数据
Data = altreadsegy('data_shot.sgy');

% 无噪声的单道数据
clean_signal= Data(:,100);
% 添加高斯白噪声
noise_power = 2; % 噪声功率
noise = sqrt(noise_power) * randn(size(clean_signal)); % 生成高斯白噪声
noisy_signal = clean_signal + noise; % 添加噪声
% 采样间隔，单位是秒
Ts=0.008;

% 调用函数绘制信号
signals = {clean_signal, noisy_signal}; % 信号元胞数组
styles = {'k-', 'r-'}; % 样式元胞数组
plotSignals(signals, styles, Ts);




