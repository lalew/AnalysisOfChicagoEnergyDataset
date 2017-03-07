%% Linear Regression on Data (Chicago Energy Dataset)

%% Scatterplots of input variables vs. KWH
figure;
subplot(4, 2, 1);
scatter(cogsdata(:, 65), cogsdata(:, 18)); %total kwh vs total population
title('Total Population vs Total KWH');
xlabel('Total Population');
ylabel('Total KWH');
subplot(4, 2, 2);
scatter(cogsdata(:, 66), cogsdata(:, 18)); %total kwh vs total units
title('Total Building Units vs Total KWH');
xlabel('Total Building Units');
ylabel('Total KWH');
subplot(4, 2, 3);
scatter(cogsdata(:, 67), cogsdata(:, 18)); %total kwh vs average stories
title('Average Stories vs Total KWH');
xlabel('Average Stories');
ylabel('Total KWH');
subplot(4, 2, 4);
scatter(cogsdata(:, 68), cogsdata(:, 18)); %total kwh vs average building age
title('Average Building Age vs Total KWH');
xlabel('Average Building Age');
ylabel('Total KWH');
subplot(4, 2, 5);
scatter(cogsdata(:, 69), cogsdata(:, 18)); %total kwh vs average house size
title('Average Housesize vs Total KWH');
xlabel('Average Housesize');
ylabel('Total KWH');
subplot(4, 2, 6);
scatter(cogsdata(:, 70), cogsdata(:, 18)); %total kwh vs average stories
title('Occupied Units vs Total KWH');
xlabel('Occupied Units');
ylabel('Total KWH');
subplot(4, 2, 7);
scatter(cogsdata(:, 72), cogsdata(:, 18)); %total kwh vs renter occupied housing units
title('Renter-Occupied Housing Units vs Total KWH');
xlabel('Renter-Occupied Housing Units');
ylabel('Total KWH');
subplot(4, 2, 8);
scatter(cogsdata(:, 74), cogsdata(:, 18)); %total kwh vs occupied housing units
title('Occupied Housing Units vs Total KWH');
xlabel('Occupied Housing Units');
ylabel('Total KWH');

%% Scatterplots of input variables vs. Therms
figure;
subplot(4, 2, 1);
scatter(cogsdata(:, 65), cogsdata(:, 33)); %total kwh vs total population
title('Total Population vs Total Therms');
xlabel('Total Population');
ylabel('Total Therms');
subplot(4, 2, 2);
scatter(cogsdata(:, 66), cogsdata(:, 33)); %total kwh vs total units
title('Total Building Units vs Total Therms');
xlabel('Total Building Units');
ylabel('Total Therms');
subplot(4, 2, 3);
scatter(cogsdata(:, 67), cogsdata(:, 33)); %total kwh vs average stories
title('Average Stories vs Total Therms');
xlabel('Average Stories');
ylabel('Total Therms');
subplot(4, 2, 4);
scatter(cogsdata(:, 68), cogsdata(:, 33)); %total kwh vs average building age
title('Average Building Age vs Total Therms');
xlabel('Average Building Age');
ylabel('Total Therms');
subplot(4, 2, 5);
scatter(cogsdata(:, 69), cogsdata(:, 33)); %total kwh vs average house size
title('Average Housesize vs Total Therms');
xlabel('Average Housesize');
ylabel('Total Therms');
subplot(4, 2, 6);
scatter(cogsdata(:, 70), cogsdata(:, 33)); %total kwh vs average stories
title('Occupied Units vs Total Therms');
xlabel('Occupied Units');
ylabel('Total Therms');
subplot(4, 2, 7);
scatter(cogsdata(:, 72), cogsdata(:, 33)); %total kwh vs renter occupied housing units
title('Renter-Occupied Housing Units vs Total Therms');
xlabel('Renter-Occupied Housing Units');
ylabel('Total Therms');
subplot(4, 2, 8);
scatter(cogsdata(:, 74), cogsdata(:, 33)); %total kwh vs occupied housing units
title('Occupied Housing Units vs Total Therms');
xlabel('Occupied Housing Units');
ylabel('Total Therms');

%% Calculate the covariance matrix
data = cogsdata';
Z = data - repmat(mean(data, 2), [1, size(data, 2)]);
CV = 1/size(data, 2) * (Z) * Z';
heatCV = abs(CV(:, 18));
[sortHeatCV, indicesHeat] = sort(heatCV, 'descend');
indexes = indicesHeat(:);
thermCV = abs(CV(:, 33));
[sortThermCV, indicesTherm] = sort(thermCV, 'descend');
indexesTherm = indicesTherm(:);

%% Mutlivariate Regression for kwh
xlim([0 6000]);   % range of weight values in plot
ylim([-250 70]);   % range of mpg values in plot
x_range = 0:.1:60000;   % x values range in regression line
x_range = x_range';   % get range as a column vector

totalPoints = length(cogsdata);   % get total number of data points
% calculate number of data points that is %70 of total points
trainValue = round(0.70*totalPoints);
% calculate number of data points that is %30 of total points
testValue = totalPoints - trainValue;
% randomize the indices of the data points
randomIndices = randperm(totalPoints);
% store %70 of randomized indices as training set
trainData = randomIndices(1:trainValue);
% store %30 of randomized indices as testing set
testData = randomIndices(trainValue + 1:end);

a_matrix = [cogsdata(trainData, 65) cogsdata(trainData, 66) ones(length(trainData), 1)];
weights = a_matrix\cogsdata(trainData, 18);
x_multivariate = [x_range x_range ones(length(x_range), 1)];
y_range = x_multivariate*weights;
figure;
plot3(x_range, x_range, y_range, 'k-', 'linewidth', 5);
hold on;
scatter3(cogsdata(:, 65), cogsdata(:, 66), cogsdata(:, 18));
title('Total Population vs. Total Building Units vs. Total KWH (1st Order Multivariate Model)');
xlabel('Total Population');
ylabel('Total Building Units');
zlabel('Total KWH');

sum_sq_test = 0;
% go through each test set value to calculate test set SSE for each model
for val = 1:testValue
    % set the multivariate input variables for 1 point
    point_x = [cogsdata(testData(val), 65) cogsdata(testData(val), 66) 1];
    % calculate the y value on the regression line for 1 point
    point_y = point_x*weights;
    % calculate the training set SSE for the multivariate model
    sum_sq_test = sum_sq_test + (point_y - cogsdata(testData(val), 18))^2;
end

sum_sq_test = sum_sq_test/testValue;
fprintf('Sum Squared Error - 1st order multivariate (kwh) test set (per data point): %.2f\n', sum_sq_test/testValue);

output1000 = weights(1) * 1000 + weights(2) * 1000 + weights(3);
fprintf('KWH for population of 1000 and 1000 building units is: %.2f\n', output1000);
output5000 = weights(1) * 5000 + weights(2) * 5000 + weights(3);
fprintf('KWH for population of 5000 and 5000 building units is: %.2f\n', output5000);
output10000 = weights(1) * 10000 + weights(2) * 5000 + weights(3);
fprintf('KWH for population of 10000 and 5000 building units is: %.2f\n', output10000);
output15000 = weights(1) * 15000 + weights(2) * 5000 + weights(3);
fprintf('KWH for population of 15000 and 5000 building units is: %.2f\n', output15000);
%% Multivariate Regression for therms
totalPointsT = length(cogsdata);   % get total number of data points
% calculate number of data points that is %70 of total points
trainValueT = round(0.70*totalPointsT);
% calculate number of data points that is %30 of total points
testValueT = totalPointsT - trainValueT;
% randomize the indices of the data points
randomIndicesT = randperm(totalPointsT);
% store %70 of randomized indices as training set
trainDataT = randomIndicesT(1:trainValueT);
% store %30 of randomized indices as testing set
testDataT = randomIndices(trainValueT + 1:end);

a_matrixT = [cogsdata(trainDataT, 65) cogsdata(trainDataT, 66) ones(length(trainDataT), 1)];
weightsT = a_matrixT\cogsdata(trainDataT, 33);
x_multivariateT = [x_range x_range ones(length(x_range), 1)];
y_range = x_multivariateT*weightsT;
figure;
plot3(x_range, x_range, y_range, 'k-', 'linewidth', 5);
hold on;
scatter3(cogsdata(:, 65), cogsdata(:, 66), cogsdata(:, 33));
title('Total Population vs. Total Building Units vs. Total Therms (1st Order Multivariate Model)');
xlabel('Total Population');
ylabel('Total Building Units');
zlabel('Total Therms');

sum_sq_testT = 0;
% go through each test set value to calculate test set SSE for each model
for val = 1:testValueT
    % set the multivariate input variables for 1 point
    point_xT = [cogsdata(testDataT(val), 65) cogsdata(testDataT(val), 66) 1];
    % calculate the y value on the regression line for 1 point
    point_yT = point_xT*weightsT;
    % calculate the training set SSE for the multivariate model
    sum_sq_testT = sum_sq_testT + (point_yT - cogsdata(testDataT(val), 33))^2;
end

sum_sq_test = sum_sq_test/testValueT;
fprintf('Sum Squared Error - 1st order multivariate (therms) test set (per data point): %.2f\n', sum_sq_testT/testValueT);

output1000 = weightsT(1) * 1000 + weightsT(2) * 1000 + weightsT(3);
fprintf('Therms for population of 1000 and 1000 building units is: %.2f\n', output1000);
output5000 = weightsT(1) * 5000 + weightsT(2) * 5000 + weightsT(3);
fprintf('Therms for population of 5000 and 5000 building units is: %.2f\n', output5000);
output10000 = weightsT(1) * 10000 + weightsT(2) * 5000 + weightsT(3);
fprintf('Therms for population of 10000 and 5000 building units is: %.2f\n', output10000);
output15000 = weightsT(1) * 15000 + weightsT(2) * 5000 + weightsT(3);
fprintf('Therms for population of 15000 and 5000 building units is: %.2f\n', output15000);

%% 2nd order Multivariate Regression for kwh
totalPoints = length(cogsdata);   % get total number of data points
% calculate number of data points that is %70 of total points
trainValue = round(0.70*totalPoints);
% calculate number of data points that is %30 of total points
testValue = totalPoints - trainValue;
% randomize the indices of the data points
randomIndices = randperm(totalPoints);
% store %70 of randomized indices as training set
trainData = randomIndices(1:trainValue);
% store %30 of randomized indices as testing set
testData = randomIndices(trainValue + 1:end);

a_matrix = [cogsdata(trainData, 65).^2 cogsdata(trainData, 66).^2 ones(length(trainData), 1)];
weights = a_matrix\cogsdata(trainData, 18);
x_multivariate = [x_range.^2 x_range.^2 ones(length(x_range), 1)];
y_range = x_multivariate*weights;
figure;
plot3(x_range, x_range, y_range, 'k-', 'linewidth', 5);
hold on;
scatter3(cogsdata(:, 65), cogsdata(:, 66), cogsdata(:, 18));
title('Total Population vs. Total Building Units vs. Total KWH (2nd order Multivariate Model)');
xlabel('Total Population');
ylabel('Total Building Units');
zlabel('Total KWH');

sum_sq_test = 0;
% go through each test set value to calculate test set SSE for each model
for val = 1:testValue
    % set the multivariate input variables for 1 point
    point_x = [cogsdata(testData(val), 65).^2 cogsdata(testData(val), 66).^2 1];
    % calculate the y value on the regression line for 1 point
    point_y = point_x*weights;
    % calculate the training set SSE for the multivariate model
    sum_sq_test = sum_sq_test + (point_y - cogsdata(testData(val), 18))^2;
end

sum_sq_test = sum_sq_test;
fprintf('Sum Squared Error - 2nd order multivariate (kwh) test set (per data point): %.2f\n', sum_sq_test/testValue);

%% 2nd order Multivariate Regression for therms
totalPointsT = length(cogsdata);   % get total number of data points
% calculate number of data points that is %70 of total points
trainValueT = round(0.70*totalPointsT);
% calculate number of data points that is %30 of total points
testValueT = totalPointsT - trainValueT;
% randomize the indices of the data points
randomIndicesT = randperm(totalPointsT);
% store %70 of randomized indices as training set
trainDataT = randomIndicesT(1:trainValueT);
% store %30 of randomized indices as testing set
testDataT = randomIndices(trainValueT + 1:end);

a_matrixT = [cogsdata(trainDataT, 65).^2 cogsdata(trainDataT, 66).^2 ones(length(trainDataT), 1)];
weightsT = a_matrixT\cogsdata(trainDataT, 33);
x_multivariateT = [x_range.^2 x_range.^2 ones(length(x_range), 1)];
y_range = x_multivariateT*weightsT;
figure;
plot3(x_range, x_range, y_range, 'k-', 'linewidth', 5);
hold on;
scatter3(cogsdata(:, 65), cogsdata(:, 66), cogsdata(:, 33));
title('Total Population vs. Total Building Units vs. Total Therms (2nd Order Multivariate Model)');
xlabel('Total Population');
ylabel('Total Building Units');
zlabel('Total Therms');

sum_sq_testT = 0;
% go through each test set value to calculate test set SSE for each model
for val = 1:testValueT
    % set the multivariate input variables for 1 point
    point_xT = [cogsdata(testDataT(val), 65)^2 cogsdata(testDataT(val), 66)^2 1];
    % calculate the y value on the regression line for 1 point
    point_yT = point_xT*weightsT;
    % calculate the training set SSE for the multivariate model
    sum_sq_testT = sum_sq_testT + (point_yT - cogsdata(testDataT(val), 33))^2;
end

sum_sq_test = sum_sq_test;
fprintf('Sum Squared Error - 2nd order multivariate (therms) test set (per data point): %.2f\n', sum_sq_testT/testValueT);