function [W_nrm] = adjacet_mat(W)  
% normalize weight matrix 
    W(isnan(W)) = 0;
    W(W >= 1) = 0;
    W = W - diag(diag(W)); % set diagonal into zero 
    W_nrm = (W-min(W(:))) ./ (max(W(:)-min(W(:))));
end