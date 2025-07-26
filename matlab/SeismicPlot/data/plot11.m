addpath(genpath('../SeisPlot'));

clc; clear; close all;

% Define the directory containing the SEG-Y files
dataDir = './';

% Get a list of all SEG-Y files in the directory
segyFiles = dir(fullfile(dataDir, '*.segy'));

% Loop through each SEG-Y file
for i = 1:length(segyFiles)
    filePath = fullfile(dataDir, segyFiles(i).name);

    % Read the SEG-Y data
    Data = altreadsegy(filePath);

    % Plotting
    figure('Name', [segyFiles(i).name]);
    imageplot(Data, 0.0002, 1, 0, 1, 12, 1);
    colormap(seis_colors);
    saveas(gcf, fullfile(dataDir, [segyFiles(i).name, '.png']));

    % title(['Variable Density Plot - ' segyFiles(i).name]);

    % figure('Name', ['Grayscale Plot - ' segyFiles(i).name]);
    % imageplot(Data, 0.008, 1, 0, 1, 12, 1);
    % colormap(gray);
    % % title(['Grayscale Plot - ' segyFiles(i).name]);

    % figure('Name', ['Seismic Colormap 1 - ' segyFiles(i).name]);
    % imageplot(Data, 0.008, 1, 0, 1, 12, 1);
    % colormap(seismic(1));
    % % title(['Seismic Colormap 1 - ' segyFiles(i).name]);

    % figure('Name', ['Seismic Colormap 2 - ' segyFiles(i).name]);
    % imageplot(Data, 0.008, 1, 0, 1, 12, 1);
    % colormap(seismic(2));
    % % title(['Seismic Colormap 2 - ' segyFiles(i).name]);
end
