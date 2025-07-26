function [Velocity, depthSta] = calcStairsData(VS,H,maxDepth)
% 输入VS和对应的层厚H，返回台阶速度用于画图。
% 
% 输入参数：
% vs: 速度向量。
% h: 深度增量向量。
% maxDepth: 最大深度，如果未提供，则默认值为 1.5 倍的深度增量总和。
%
% 输出参数：
% vsSta: 阶梯状的速度数据。
% depthSta: 对应的深度数据。
% @author:夜剑听雨
% E-mail:2530595378@qq.com
% 2025.01.01

% 如果只提供了速度和深度增量，则计算最大深度为深度增量总和的 1.5 倍。
if nargin==2
   maxDepth = 1.5*sum(H);
end
% 构建地层深度序列函数
depth1 = [0 H];  % 增加起始深度0
depthSta = cumsum(depth1);  % 使用cumsum函数计算累积和，得到向量B
% 增加最大深度
depthSta = [depthSta maxDepth];
% 定义速度和深度的数据点 
Velocity = [ VS(1) VS ];
end



