function plotSignals(signals, styles, Ts)
    % plotSignals - 绘制多个一维信号
    % 2025/02 中国矿业大学（北京），六道口矿工
    % 输入参数:
    %   signals - 包含多个信号的元胞数组，每个信号为一维向量
    %   styles  - 对应的绘图样式（元胞数组，例如 {'k-', 'r--'}）
    %   Ts      - 采样间隔（秒）
    %
    % 输出:
    %   在同一张图上绘制多个信号

    % 检查输入参数
    if nargin < 3
        error('请输入三个参数：signals、styles 和 Ts。');
    end
    if length(signals) ~= length(styles)
        error('signals 和 styles 的长度必须一致。');
    end

    % 生成时间轴
    t = (0:length(signals{1})-1) * Ts; % 假设所有信号长度相同

    % 绘制信号
    figure;
    hold on; % 保持图形，用于绘制多个信号
    for i = 1:length(signals)
        plot(t, signals{i}, styles{i}, 'LineWidth', 1);
        box on; % 确保边框显示
    end
    hold off;
    xlabel('Time (s)');
    ylabel('Amplitude');
   legend('Clean Signal', 'Noisy Signal');
end