function cf_matrix = confusionMatrixForCFS(all_raw_data,t_labels)
% confusionMatrixForCFS -  create confusion matrix with all the emotions
% Input:   
%       all_raw_data - a cell contains the reduced data for 6 emotions
%       t_labels - target labels in column
% Output:
%       cf_matrix - 6*6 (excluding false negative)

emo_labels_num = max(unique(t_labels));

pred_result = CFSemotionPrediction(all_raw_data,t_labels);

% remove rows that both elements are 0
pred_result(all(pred_result==0,2),:) = [];
vals = ones(size(pred_result,1),1)';

cf_matrix = accumarray(pred_result,vals,[emo_labels_num,emo_labels_num]); 