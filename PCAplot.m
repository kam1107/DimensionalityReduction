function PCAplot()

load('emotions_data_66.mat');

[reduced_data,~]=applyPCA(x);
num_emotions = max(unique(y));
merge_data = [reduced_data,y];
% plot images?
figure;
for i = 1:num_emotions
    tmp= merge_data(merge_data(:,end)==i,:);
    plot(tmp(:,1),tmp(:,2),'.','markers',15);
    hold on;
end
title('PCA');
xlabel('PC1') % x-axis label
ylabel('PC2') % y-axis label
legend('Emotion1','Emotion2','Emotion3', 'Emotion4','Emotion5','Emotion6');
hold off;
