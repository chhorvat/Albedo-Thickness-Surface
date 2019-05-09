%% 
mos = 7:9; 
yrs = 1:100; 

m2 = mos; 
m1 = mos - 1; 

dA = squeeze(a_ice(:,m2,yrs) - a_ice(:,m1,yrs));
dH = squeeze(h_ice(:,m2,yrs) - h_ice(:,m1,yrs));
dV = squeeze(V_ice(:,m2,yrs) - V_ice(:,m1,yrs));
dalb = squeeze(albedo(:,m2,yrs) - albedo(:,m1,yrs));
dsno = squeeze(a_snow(:,m2,yrs) - a_snow(:,m1,yrs)); 


%%
matrix = [ones(size(dA(:))), dA(:),dH(:),dV(:),dsno(:)]; 

inder = logical((~isnan(dalb)) .* (dalb < 0)); 
 

[b,bint,r,rint,stats] = regress(dalb(inder(:)),matrix(inder(:),:)); 

% [coeff,score,latent,tsquared,explained] = pca(matrix); 