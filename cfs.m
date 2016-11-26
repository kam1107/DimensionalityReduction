function reduced_data = cfs(F,S_k,target,cur_cfs,k)
% cfs is a function that use CFS to realize dimentionality reduction
% Input: F - availabel feature
%        S_k - all selected feature
%        target - all the labels
%        cur_cfs - current cfs value
%        k - current iteration
% Output: all_reduced_data - a cell that contains reduced data for 6 emotions

% select feature from pool, 1 if the feature is avalable, 0 otherwise

cfs_max = -inf;
cfs_max_idx = -1;
for i = 1:size(F,2)
   r_cf = abs(corr(F(:,i),target)); 
   for j = 1:size(S_k,2)
       r_cf  = r_cf+abs(corr(S_k(:,j),target));
   end
   
   tmp_Sk = [S_k,F(:,i)];
   % all combinations of the column index in tmp_Sk
   r_ff = 0;
   if ~isempty(S_k)
       comb_idx = nchoosek(1:size(tmp_Sk,2),2);
       for j = 1:size(comb_idx,1)
           r_ff = r_ff+abs(corr(tmp_Sk(:,comb_idx(j,1)),tmp_Sk(:,comb_idx(j,2))));
       end
   end
   
   cfs_i = r_cf/sqrt(k+r_ff);
   if cfs_i > cfs_max
       cfs_max = cfs_i;
       cfs_max_idx = i;
   end
end

% check if converge
if cfs_max < cur_cfs
    reduced_data = S_k;
    return;
else
    S_k = [S_k,F(:,cfs_max_idx)];
    F(:,i) = [];
    reduced_data = cfs(F,S_k,target,cfs_max,k+1);
end