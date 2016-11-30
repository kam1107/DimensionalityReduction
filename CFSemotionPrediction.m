function pred_result = CFSemotionPrediction(raw_data,t_labels)
% This funciton applied k-fold cross validation on the transferred data
% Input: all_raw_data - a cell contains all reduced data for each emotion
%        t_labels - target labels in column
% Output: pred_result  -  a matrix, first column is actual label, second
%                         column is predicted label (1~6)

% Constant
k = 10;  % 10 fold cross validation 
num_examples = size(raw_data,1);

% data partition
r = mod(num_examples,k);
set_sizes = zeros(1,k);
set_sizes(1,1:r) = floor(num_examples/k)+1;
set_sizes(1,r+1:end) = floor(num_examples/k);

% for every k-cross validation iteration, select indices from indxpool for
% training and validation sets
idxpool = randperm(num_examples);

% predict result for test data, first column is actual label, second column
% is predicted label
pred_result = zeros(num_examples,2);
tmp_result = zeros(num_examples,max(unique(t_labels)));

% k-fold cross validation (6 trees generated at each fold)
for i = 1:k 
    % test set
    tst_start = sum(set_sizes(1:i-1))+1;
    tst_end = tst_start+set_sizes(i)-1;  
    tst_idx = idxpool(tst_start:tst_end);
    tst_data = raw_data(tst_idx,:);
    tst_label = t_labels(tst_idx,:);
    % train set
    trn_idx = idxpool(setdiff(1:end,tst_start:tst_end));
    trn_data = raw_data(trn_idx,:);
    trn_label = t_labels(trn_idx,:);
    % apply CFS on training data
    all_reduced_trn_data = applyCFS(trn_data,trn_label);
    for em = 1:max(unique(t_labels))
        [~,selected_idx] = ismember(all_reduced_trn_data{em}',trn_data','rows');
        % reduced test set
        reduced_tst_data = tst_data(:,selected_idx);
        % train decision tree
        tree = ID3(datatrans(all_reduced_trn_data{em},trn_label,em)); 
        
        % test
        for j = 1:size(tst_data,1)
            if (travelTree(tree,reduced_tst_data(j,:)))
                tmp_result(tst_idx(j),em) = 1;
                pred_result(tst_idx(j),1) = tst_label(j,end);
            end
        end
    end   
end

% if the example is classified to more than one class, randomly select one
% classified class as the result
for i = 1:size(tmp_result,1)
    if sum(tmp_result(i,:)) == 0
        pred_result(i,2) = 0;
    end
    
    if sum(tmp_result(i,:)) == 1
        pred_result(i,2) = find(tmp_result(i,:)==1);
    end
    
    if sum(tmp_result(i,:)) > 1
        idx = find(tmp_result(i,:)==1);
        pred_result(i,2) = idx(randperm(size(idx,2),1));
    end
end