function sub_imageplot(data,lo,t1,t2,x1,x2)
%以变密度形式画地震记录子图
%2023/9 中国地质大学（北京），地球物理与信息技术学院，五道口勘探员
% data：地震数据
% lo：子图图形在大图中的位置和大小
% t1：起始时间下标
% t2：终止时间下标
% x1：记录起始位置下标
% x2：记录终止位置下标
hold on,
axes('Position',lo),
imageplot(data(t1:t2,x1:x2)), axis off