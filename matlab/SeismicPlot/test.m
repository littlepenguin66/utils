addpath(genpath('./SeisPlot'));

Data = altreadsegy('../../data/0701/group10/lczy0002.segy');

dt = 0.008;
spectrumplot(Data, dt, 12)
