function all_reduced_data = applyCFS(x,y)
% applyCFS is a function that use CFS to realize dimentionality reduction
% Output: all_reduced_data - a cell that contains reduced data for 
%                            6 emotions

num_emotions = max(unique(y));
all_reduced_data = cell(1,num_emotions);
for i = 1:num_emotions
    [ft,lb] = datatrans_DR(x,y,i);
    all_reduced_data{i} = cfs(ft,[],lb,-inf,1);
       emotion_cell = [all_reduced_data{i},lb];  
    tmp= emotion_cell(emotion_cell(:,end)==1,:);
    figure;
    plot(tmp(:,1),tmp(:,2),'o');
    title(strcat('Emotion',num2str(i)));
    hold on;
    tmp= emotion_cell(emotion_cell(:,end)==0,:);
    plot(tmp(:,1),tmp(:,2),'x');
    hold off;
    legend('f1','f2');
end

