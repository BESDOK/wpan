function [ObjFunVal , PS] = WPAN(MSI,PAN,w0,T)
% MSI : Multispectral Image
% PAN : Panchromatic Image
% w0  : Optimized weights 3x16 sized matrix
% T   : Threshold, T=20 used in the tests performed

K=16;
rng(100); % for initial step of k-means
[M,N,D]=size(MSI);
L=inf(M,N,D); % initalization of labels matrix, L
for i=1:3
    dv=abs(MSI(:,:,i)-PAN(:,:,i));
    [k,~]=kmeans(dv(:),K);
    L(:,:,i)=reshape(k,M,N);
end
w=inf(M,N); % initalization of weight matrix, w
for BNumber = 1:3
    alpha = inf(M,N); % initalization of alpha
    for CNumber = 1 : K
        ind = L(:,:,BNumber)==CNumber;        
        alpha(ind) = w0(BNumber,CNumber);
    end
    w(:,:,BNumber) = alpha;
end
PS = MSI + w .* ( PAN - MSI ) ;
ObjFunVal = -sum( (abs(PS-MSI) <= T) + (abs(PS-PAN) <= T) ,"all") / (M*N*6) ;