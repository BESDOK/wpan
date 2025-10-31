

function [out , ps ] = wpan(X,userdata)
msi=double(userdata.msi);
pan=double(userdata.pan);
T=userdata.T;
labels=userdata.labels;
[M,N]=size(pan);
w=inf(M,N); % init
pan3=cat(3,pan,pan,pan);
n=size(X,1);
out=inf(n,1);
K=size(X(1,:),2)/3;
for i = 1:n
    s = reshape(X(i,:),3,K) ;
    for j = 1:3
        alpha = inf(M,N); %init
        for k = 1 : K
            ind = labels(:,:,j)==k;
            alpha(ind) = s(j,k);
        end
        w(:,:,j) = alpha;
    end
    ps = msi + w .* ( pan - msi ) ;
    out(i) = -sum( (abs(ps-msi) <= T) + (abs(ps-pan3) <= T) ,"all") / (M*N*6) ;
end





































