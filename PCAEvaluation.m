function [cf_matrix,evl_matrix] = PCAEvaluation()
% Output: cf_matrix: a confusion matrix
%         evl_matrix: overall average recall, precision and f1, and 
%                     average recall, precision and f1 measure for each
%                     emotion

load('emotions_data_66.mat');

% PCA
reduced_data = applyPCA(x,y);

cf_matrix = confusionMatrixForPCA(reduced_data,y);

evl_matrix = recallPrecision(cf_matrix,y);

disp('      Avg       E1        E2        E3        E4         E5        E6');
disp(evl_matrix);

