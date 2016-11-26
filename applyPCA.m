function reduced_data = applyPCA()
% applyPCA is a function that use PCA to realize dimentionality reduction
% Output: reduced_data - reduced data that preserves at least 95%
%                        variance of original data

load('emotions_data_66.mat')

% original variance
cov_mat = cov(x);
orig_variance = sum(diag(cov_mat));

% calculate principle compoments
[coeff,~,latent] = pca(x);
% PC dimension
sums = cumsum(latent);
idx = sums<orig_variance*0.95;
new_dimension = sum(idx)+1;

reduced_data = x*coeff(:,1:new_dimension);
