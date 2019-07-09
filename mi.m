function I=mi(A,B,varargin) 
%MI Determines the mutual information of two images or signals
%   I=mi(A,B)   Mutual information of A and B, using 256 bins for
%   histograms
%   I=mi(A,B,L) Mutual information of A and B, using L bins for histograms
%
%   Assumption: 0*log(0)=0

if nargin>=3
    L=varargin{1};
else
    L=256;
end

A=double(A); 
B=double(B); 
     
na = hist(A(:),L);
na = na/sum(na);

nb = hist(B(:),L); 
nb = nb/sum(nb);

n2 = hist2(A,B,L); 
n2 = n2/sum(n2(:));

MI = sum(minf(n2,na'*nb)); 
Hx = - sum(entropy_cal(na));
Hy =  - sum(entropy_cal(na));

I = sqrt((MI/Hx)*(MI/Hy));
I = max(0,I);
    
end
% -----------------------
function y=minf(pab,papb)

I=find(papb(:)>1e-12 & pab(:)>1e-12); % function support 
y=pab(I).*log2(pab(I)./papb(I));

end

function h = entropy_cal(pab)
    I=find(pab(:)>1e-12); % function support 
    h= pab(I).*log2(pab(I));
end

function n=hist2(A,B,L) 
%HIST2 Calculates the joint histogram of two images or signals
%
%   n=hist2(A,B,L) is the joint histogram of matrices A and B, using L
%   bins for each matrix.

ma=min(A(:)); 
MA=max(A(:)); 
mb=min(B(:)); 
MB=max(B(:));

% For sensorimotor variables, in [-pi,pi] 
% ma=-pi; 
% MA=pi; 
% mb=-pi; 
% MB=pi;

% Scale and round to fit in {0,...,L-1} 
A=round((A-ma)*(L-1)/(MA-ma+eps)); 
B=round((B-mb)*(L-1)/(MB-mb+eps)); 
n=zeros(L); 
x=0:L-1; 
for i=0:L-1 
    n(i+1,:) = histc(B(A==i),x,2); 
end
end

