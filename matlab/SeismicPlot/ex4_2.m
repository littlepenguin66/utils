% 添加路径，包含所有子目录
addpath(genpath('./SeisPlot'));

% 清除命令窗口、变量和关闭所有图形窗口
clc; clear; close all;

% 加载数据文件 Q_value.mat，假设文件中包含变量 qx1, qx2, qx3, qx4
load Q_value.mat

% 定义 r 和 yti 的值，分别用于 x 轴和 y 轴的刻度
r = 10:10:80; % r 是 x 轴的刻度，从 10 到 80，步长为 10
yti = 0:5:45; % yti 是 y 轴的刻度，从 0 到 45，步长为 5

% 创建一个新图形窗口
figure,

% 绘制第一条曲线，红色圆圈标记，线宽为 1.1
plot(r, qx1, 'r-o', 'linewidth', 1.1), hold on, 

% 绘制第二条曲线，蓝色方块标记，线宽为 1.1
plot(r, qx2, 'b-s', 'linewidth', 1.1),

% 绘制第三条曲线，绿色三角标记，线宽为 1.1
plot(r, qx3, 'g-^', 'linewidth', 1.1), 

% 绘制第四条曲线，黑色星号标记，线宽为 1.1
plot(r, qx4, 'k-*', 'linewidth', 1.1), 

% 添加图例，分别对应四条曲线
legend('CT', 'QCT', 'FT', 'QFT')

% 设置 x 轴标签
xlabel('Percentage of missing traces (%)'), 

% 设置 y 轴标签
ylabel('SNR (dB)'), 

% 设置 x 轴和 y 轴的刻度
tickset(r, yti)

% 在图形的左上角添加文本标注 (a)，字体为 Times New Roman，字号为 20
text(1.5, 45.5, '(a)', 'Fontname', 'times new roman', 'fontsize', 20),

% 调整图形的边框，使其更紧凑
box on