function [cf_matrix,evl_matrix] = CFSEvaluation()
% Output: cf_matrix: a confusion matrix
%         evl_matrix: overall average recall, precision and f1, and 
%                     average recall, precision and f1 measure for each
%                     emotion

load('emotions_data_66.mat');

% CFS
all_reduced_data = applyCFS(x,y);

cf_matrix = confusionMatrixForCFS(all_reduced_data,y);

evl_matrix = recallPrecision(cf_matrix,y);

disp('      Avg       E1        E2        E3        E4         E5        E6');
disp(evl_matrix);

