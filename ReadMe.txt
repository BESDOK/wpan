load("C:\Users\felix\Desktop\JRS (revised 291025)\code\JRS_sims.mat")
userdata.T=40;
MSI=double(JRS_WORDVIEW.sims{1}); 
PAN=double(JRS_WORDVIEW.sims{2});

K=16;
low=0.0*ones(1,3*K);
up=1.0*ones(1,3*K); 
msi=double(MSI);
pan=double(PAN);
userdata.K=K;
userdata.msi=msi;  
userdata.pan=pan;
f=abs(msi-pan);
[M,N]=size(pan);

rng(100); % k-means için gerekli
for i=1:3, a=f(:,:,i); [k,c]=kmeans(a(:),K); c=sort(c,'ascend'); a=reshape(k,M,N); f(:,:,i)=a; end
w = f; % init
userdata.labels=w;

% CLEAR CODE VERSION
 algo_CSA('objfunpan02',userdata,10,3*K,low,up,1000)
 [err , ps ]=objfunpan02(out.gbest,userdata); ps=uint8(ps);

% FAST-CODE VERSION
% algo_CSA('objfunpan02_optimized',userdata,10,3*K,low,up,1000)
% [err , ps ]=objfunpan02_optimized(out.gbest,userdata); ps=uint8(ps);

JRS40_WORDVIEW.sims{20}=ps;
JRS40_WORDVIEW.wdeOut=out;