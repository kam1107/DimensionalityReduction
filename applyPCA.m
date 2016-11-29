function reduced_data = applyPCA(x,y)
% applyPCA is a function that use PCA to realize dimentionality reduction
% Output: reduced_data - reduced data that preserves at least 95%
%                        variance of original data

% Constant
num_emotions = max(unique(y));

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

% plot images
figure;
title('PAC');
for i = 1:num_emotions
    tmp= reduced_data(reduced_data(:,end)==i,:);
    plot(tmp(:,1),tmp(:,2),'x');
    hold on;
end
xlabel('PC1') % x-axis label
ylabel('PC2') % y-axis label
legend(strcat('Emotion1','Emotion2','Emotion3', 'Emotion4','Emotion5','Emotion6'));
hold off;
