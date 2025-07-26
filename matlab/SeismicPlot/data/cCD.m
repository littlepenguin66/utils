function distances = cCD(totalChannels)
    % 初始化距离数组
    distances = zeros(1, totalChannels);

    % 计算每道的距离
    for channel = 1:totalChannels

        if channel >= 1 && channel <= 12
            % 1-12道，道间距1米
            distances(channel) = (channel - 1) * 1;
        elseif channel >= 13 && channel <= 36
            % 13-36道，道间距0.5米，需要考虑前面12道的总距离
            distances(channel) = 11 + (channel - 13) * 0.5;
        elseif channel >= 37 && channel <= 48
            % 37-48道，道间距1米，需要考虑前面36道的总距离
            distances(channel) = 11 + 12 + (channel - 37) * 1;
        end

    end

    % 返回距离数组
    distances = distances(totalChannels) + 1; % 转换为列向量
    disp('Distances calculated for each channel:');
    disp(distances);
end
