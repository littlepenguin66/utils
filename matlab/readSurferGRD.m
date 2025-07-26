function [Z, X, Y, header] = readSurferGRD(filePath)
%READSURFERGRD Reads a Surfer GRD (ASCII) file into Matlab.
%   [Z, X, Y, header] = readSurferGRD(filePath) reads the specified Surfer
%   GRD file and returns the grid data (Z), X coordinates (X),
%   Y coordinates (Y), and a structure containing header information.
%
%   Input:
%     filePath - Path to the Surfer GRD file.
%
%   Outputs:
%     Z      - A 2D matrix of Z values (grid data).
%     X      - A 1D vector of X coordinates.
%     Y      - A 1D vector of Y coordinates.
%     header - A structure containing the header information:
%              .FileIdentifier
%              .NumCols
%              .NumRows
%              .XMin
%              .XMax
%              .YMin
%              .YMax
%              .ZMin
%              .ZMax

if ~exist(filePath, 'file')
    error('File not found: %s', filePath);
end

fileID = fopen(filePath, 'r');
if fileID == -1
    error('Could not open file: %s', filePath);
end

header = struct();

try
    % Read File Identifier (DSA)
    header.FileIdentifier = fgetl(fileID);
    if ~strcmp(header.FileIdentifier, 'DSA')
        % You might want to add handling for 'DSBB' (binary) if needed,
        % but this function assumes ASCII.
        warning('File is not a standard ASCII Surfer GRD (DSA). It might be binary or an old format.');
    end

    % Read NX NY
    dims = textscan(fileID, '%f %f', 1);
    header.NumCols = dims{1}; % NX
    header.NumRows = dims{2}; % NY

    % Read XLO XHI
    x_range = textscan(fileID, '%f %f', 1);
    header.XMin = x_range{1};
    header.XMax = x_range{2};

    % Read YLO YHI
    y_range = textscan(fileID, '%f %f', 1);
    header.YMin = y_range{1};
    header.YMax = y_range{2};

    % Read ZLO ZHI
    z_range = textscan(fileID, '%f %f', 1);
    header.ZMin = z_range{1};
    header.ZMax = z_range{2};

    % Read data block
    % The data is stored row by row, from top to bottom (Y descending),
    % and within each row, from left to right (X ascending).
    % textscan reads column-major by default, so we need to transpose.
    % Also, Surfer stores data from top-left (max Y, min X) to bottom-right (min Y, max X).
    % Matlab images/matrices typically have (1,1) as top-left.
    % So, we read all data and then reshape.

    data = textscan(fileID, '%f', header.NumCols * header.NumRows);
    Z = reshape(data{1}, header.NumCols, header.NumRows)'; % Reshape and transpose

    % Surfer stores data such that the first row in the file corresponds to
    % the maximum Y-coordinate, and the last row corresponds to the minimum Y-coordinate.
    % Matlab's image/matrix display typically has row 1 at the top (highest Y value if row index maps to Y).
    % If Z(1,1) should correspond to (XMin, YMax), the reshape and transpose above
    % should give the correct orientation for image/surf plotting.
    % However, if you want Z(1,1) to be (XMin, YMin), you'd need to flipud(Z).
    % Let's assume Z(1,1) corresponds to (XMin, YMax).

    % Generate X and Y coordinates
    X = linspace(header.XMin, header.XMax, header.NumCols);
    Y = linspace(header.YMin, header.YMax, header.NumRows);
    % Surfer's Y values are ordered from max to min in the file,
    % so if Y needs to be ascending for meshgrid, we use Y = linspace(YMin, YMax, NumRows);

    % IMPORTANT: Surfer's GRD data is typically stored from top-left to bottom-right,
    % meaning the first value is for (Xmin, Ymax) and the last for (Xmax, Ymin).
    % If you reshape data into (NumCols, NumRows) and then transpose to (NumRows, NumCols),
    % Z(1,1) will be the top-left (Xmin, Ymax) value.
    % If you want Z(1,1) to be the bottom-left (Xmin, Ymin) value, you'd need to flip Z vertically.
    % For plotting with imagesc/surf, Z(1,1) is top-left, which usually aligns with Y=Ymax.
    % If Y represents increasing values from bottom to top, then Z needs to be flipped.
    Z = flipud(Z); % Flip so that Z(1,:) corresponds to YMin and Z(end,:) to YMax.

catch ME
    fclose(fileID);
    rethrow(ME);
end

fclose(fileID);

end
