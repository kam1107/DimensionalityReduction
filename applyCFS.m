function all_reduced_data = applyCFS()
% applyCFS is a function that use CFS to realize dimentionality reduction
% Output: all_reduced_data - a cell that contains reduced data for 
%                            6 emotions

load('emotions_data_66.mat')

all_reduced_data = cell(1,6);
for i = 1:length(y)
    [ft,lb] = datatrans(x,y,i);
    all_reduced_data{i} = cfs(ft,[],lb,-inf,1);
end
