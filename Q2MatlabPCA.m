% load cogs
% categories

% Row data points
% Col attributes (education, etc)
% -----
% Categories - Attributes (C x length of string)
% Names - Rows of input (R x length of strings)
% Ratings - All of our data (R x C)
% -----
categories = [...
    'TotalPop             '; 'TotalUnits           '; ...
    'avgStory             '; 'AvgBuildingAge       '; ...
    'AvgHouseSize         '; 'OccupiedUnits        '; ...
    'RenterOccupiedHousing'; 'OccupiedHousingUnits '];

names = [1:size(EnergyUsage2010,2)]';
ratings = EnergyUsage2010(:,[64:69 71 73]);

ratings = table2array(ratings);
C = corr(ratings,ratings);

w = 1./var(ratings);
[wcoeff,score,latent,tsquared,explained] = pca(ratings,'VariableWeights',w);

c3 = wcoeff(:,1:3)

coefforth = inv(diag(std(ratings)))*wcoeff;

I = coefforth'*coefforth;
I(1:3,1:3)

cscores = zscore(ratings)*coefforth;

figure()
plot(score(:,1),score(:,2),'+')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')

gname

%% Rest of code
% Latent - Variance explained by corres. output
latent
% Explained - Percentage explained by corres. output
explained

figure()
pareto(explained)
xlabel('Principal Component')
ylabel('Variance Explained (%)')

[st2,index] = sort(tsquared,'descend'); % sort in descending order
extreme = index(1);
names(extreme,:)

figure
biplot(coefforth(:,1:2),'scores',score(:,1:2),'varlabels',categories);
axis([-0.2 1 -0.2 1]);

figure()
biplot(coefforth(:,1:3),'scores',score(:,1:3),'obslabels',categories);
axis([-0.2 1 -0.2 1]);
view([30 40]);
