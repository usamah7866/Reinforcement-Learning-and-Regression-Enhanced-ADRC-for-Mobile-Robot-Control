% Load data from Excel
data = readtable('robotTrajectoryData.xlsx');

% Extract input and output features
input_features = data{:, {'WL_Real', 'WR_Real', 'Theta_Real', 'X_Real', 'Y_Real', 'TorqueL', 'TorqueR'}};
output_features = data{:, {'X_Real', 'Y_Real', 'Theta_Real'}};
input_features(end, :) = [];
output_features(end, :) = [];

% Normalize input features (Min-Max Scaling)
input_min = min(input_features);
input_max = max(input_features);
input_features_norm = (input_features - input_min) ./ (input_max - input_min);

% Normalize output features (Min-Max Scaling)
output_min = min(output_features);
output_max = max(output_features);
output_features_norm = (output_features - output_min) ./ (output_max - output_min);

% Prepare data for LSTM
sequenceLength = 10; % Number of time steps
numSamples = size(input_features, 1) - sequenceLength;

X = cell(numSamples, 1); % Cell array for input sequences
Y = zeros(numSamples, 3); % Matrix for output targets

for i = 1:numSamples
    X{i} = input_features_norm(i:i+sequenceLength-1, :)'; % Transpose for LSTM input
    Y(i, :) = output_features_norm(i+sequenceLength, :);
end

% Define split ratios
trainRatio = 0.7; % 70% for training
valRatio = 0.15;  % 15% for validation
testRatio = 0.15; % 15% for testing

% Compute indices
numSamples = size(X, 1);
idxTrain = 1:round(trainRatio*numSamples);
idxVal = round(trainRatio*numSamples)+1:round((trainRatio+valRatio)*numSamples);
idxTest = round((trainRatio+valRatio)*numSamples)+1:numSamples;

% Split data
XTrain = X(idxTrain); YTrain = Y(idxTrain, :);
XVal = X(idxVal);     YVal = Y(idxVal, :);
XTest = X(idxTest);   YTest = Y(idxTest, :);


% Define LSTM network architecture
inputSize = size(input_features_norm, 2); % Number of input features
numHiddenUnits = 50; % Number of hidden units in LSTM
outputSize = 3; % Number of output features (X, Y, Theta)

layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(numHiddenUnits, 'OutputMode', 'last')
    fullyConnectedLayer(outputSize)
    regressionLayer];

% Define training options
options = trainingOptions('adam', ...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 32, ...
    'InitialLearnRate', 0.001, ...
    'Verbose', true, ...
    'ValidationData', {XVal, YVal}, ...
    'ValidationFrequency', 50, ...
    'Plots', 'training-progress');


% Train the LSTM network
net = trainNetwork(XTrain, YTrain, layers, options);
save('trainedLSTMModel.mat', 'net')
% Predict outputs for test data
YPred = predict(net, XTest);

% Denormalize predictions and ground truth (if needed)
YPred_denorm = YPred .* (output_max - output_min) + output_min;
YTest_denorm = YTest .* (output_max - output_min) + output_min;

% Compute error metrics
rmse = sqrt(mean((YPred_denorm - YTest_denorm).^2));
disp(['Test RMSE: ', num2str(rmse)]);

%% Plot Predictions vs Ground Truth
figure;
plot(YTest_denorm(:, 1), YTest_denorm(:, 2), 'b-', 'LineWidth', 1.5); hold on;
plot(YPred_denorm(:, 1), YPred_denorm(:, 2), 'r--', 'LineWidth', 1.5);
xlabel('X Position'); ylabel('Y Position');
title('Predicted vs Ground Truth Trajectory');
legend('Ground Truth', 'Predicted');
grid on;