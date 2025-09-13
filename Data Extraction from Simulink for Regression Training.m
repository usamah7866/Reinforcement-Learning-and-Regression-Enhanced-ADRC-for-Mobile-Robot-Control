% Initialize storage arrays before the first run
if ~exist('wl_real', 'var')
    wl_real = cell(5, 1);
    wr_real = cell(5, 1);
    theta_real = cell(5, 1);
    x_real = cell(5, 1);
    y_real = cell(5, 1);
    torqueL = cell(5, 1);
    torqueR = cell(5, 1);
    iteration = 1;  % Counter for iterations
end

% Extract and reshape data from Simulink output after each run
wl_real{iteration} = squeeze(out.wl_real.Data);     % [3101 x 1]
wr_real{iteration} = squeeze(out.wr_real.Data);     % [3101 x 1]
theta_real{iteration} = out.theta_real.Data;        % [3101 x 1]
x_real{iteration} = out.x_real.Data;                % [3101 x 1]
y_real{iteration} = out.y_real.Data;                % [3101 x 1]
torqueL{iteration} = out.tauL.Data;                 % [3101 x 1]
torqueR{iteration} = out.tauR.Data;                 % [3101 x 1]

% Increment the iteration counter
iteration = iteration + 1;
