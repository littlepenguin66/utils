addpath(genpath('./SeisPlot'));

clc;clear;close all; 
% 读取sgy数据
Data = altreadsegy('data_shot.sgy');

sample_t=0.008;
fmin=0;
fmax=60;
[Rsn,F] =RSN(200,500,50,100,sample_t,fmin,fmax,Data);

