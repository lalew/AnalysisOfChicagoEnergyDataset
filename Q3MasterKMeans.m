%% Q3 KMeans File
% Calls "clusterKMeans.m" to produce graphs of each kMeans Combination

% Total kWh Output
Dataset1 = [TOTALPOPULATION TOTALKWH];
X1Labels = 'Total Population';
Y1Labels = 'Total kWh';
Title1 = 'Total kWh vs Total Population';
labels1 = string({Title1 X1Labels Y1Labels});

Dataset2 = [AVERAGEBUILDINGAGE TOTALKWH];
X2Labels = 'Average Building Age';
Y2Labels = 'Total kWh';
Title2 = 'Total kWh vs Average Building Age';
labels2 = string({Title2 X2Labels Y2Labels});

% Total Total Therms Output
Dataset3 = [TOTALPOPULATION TOTALTHERMS];
X3Labels = 'Total Population';
Y3Labels = 'Total Therms';
Title3 = 'Total Therms vs Total Population';
labels3 = string({Title3 X3Labels Y3Labels});

Dataset4 = [AVERAGEBUILDINGAGE TOTALTHERMS];
X4Labels = 'Average Building Age';
Y4Labels = 'Total Therms';
Title4 = 'Total Therms vs Average Building Age';
% labels4 = [Title4 X4Labels Y4Labels];
labels4 = string({Title4 X4Labels Y4Labels});

% Dataset5
Dataset5 = [TOTALPOPULATION TOTALKWH];
X5Labels = 'Total Population';
Y5Labels = 'Total kWh';
Title5 = 'Total kWh vs Total Population';
% labels4 = [Title4 X4Labels Y4Labels];
labels5 = string({Title5 X5Labels Y5Labels});


% % subplot(2,2,1)
% clusterKMeans(Dataset1, 3, 100, labels1);
% % subplot(2,2,2)
% clusterKMeans(Dataset2, 3, 100, labels2);
% % subplot(2,2,3)
% clusterKMeans(Dataset3, 3, 100, labels3);
% % subplot(2,2,4)
% clusterKMeans(Dataset4, 3, 100, labels4);

% clusterKMeans(Dataset1, 2, 100, labels4);
% clusterKMeans(Dataset1, 3, 100, labels4);
% clusterKMeans(Dataset1, 4, 100, labels4);
% clusterKMeans(Dataset1, 5, 100, labels4);

% Checking Total Therms vs Building Age
clusterKMeans(Dataset4, 5, 100, labels4);

% Checking Total kWh vs Total Population
% clusterKMeans(Dataset5, 2, 1000, labels5);



