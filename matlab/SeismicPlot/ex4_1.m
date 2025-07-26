clc;clear;close all;                   % 清除matlab的工作空间中的所有变量 
%% 速度模型
%% 含高速夹层4层模型
VS = [120 300 250 400];             % 横波速度
H = [3 3 4];                       % 地层厚度

%% 台阶状速度图
% 画图最大深度
maxDepth = 20;
[vs_sta, depth_sta] = calcStairsData(VS,H, maxDepth);
% 创建图形
figure;
% 使用stairs函数绘制台阶状图形
stairs(vs_sta,depth_sta,  'r-', 'LineWidth', 2);
% % 设置y轴的范围和刻度
ylim([0 20]);
yticks(0:5:20);
% 设置x轴的范围和刻度
xlim([50 600]);
xticks(100:100:600);

% 设置x轴和y轴的标签
xlabel('S-wave velocity (m/s)','FontName', 'Microsoft YaHei', 'FontSize', 14);
ylabel('Depth (m)','FontName', 'Microsoft YaHei', 'FontSize', 14);
% 设置坐标轴线宽
set(gca, 'LineWidth', 1);
% 反转y轴
set(gca,'XAxisLocation','bottom');% 将x轴的位置设置在底部。
set(gca,'YDir','reverse'); % 将y轴方向设置为反向(从上到下递增)。
% 设置图形的标题
title('高速夹层模型','FontName', 'Microsoft YaHei', 'FontSize', 14);
% 消除图片白边
set(gca,'LooseInset',get(gca,'TightInset')+0.01);