function [feature,label] = datatrans_DR(raw_data,targets,n)
% function datatrans transfers initial data to a form that
% label is concatenated to features (612*133), where label is a column
% vector with 1 for targeted class (n) and 0 for the rest
% Input: raw_data - initial data
%        targets   - all the emotion labels (y)
%        n        - target emotion label
% Output: ft_lb   - a 612*133 matrix with a new label column positioned at
%                   the most right
                
label = targets==n;
feature = raw_data;
