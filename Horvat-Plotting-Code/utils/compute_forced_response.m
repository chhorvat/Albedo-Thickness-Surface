function DATA = compute_forced_response(data,tarea,coalb_ic)

coalb_oc = 0.93;

%% Accumulate the data into a structure
DATA.SW_dn = squeeze(data(5,:,:))/tarea;
DATA.SW_ic = squeeze(data(3,:,:))/tarea;
DATA.SW_oc = coalb_oc*squeeze(data(4,:,:))/tarea;
DATA.SW_ab = DATA.SW_ic + DATA.SW_oc; 
DATA.SI_area = squeeze(data(1,:,:)); 
% DATA.SI_conc = (DATA.SW_dn - squeeze(data(4,:,:))/tarea) ./ DATA.SW_dn; 
DATA.SI_conc = squeeze(data(1,:,:))/tarea; 
DATA.SNOW_area = squeeze(data(7,:,:))/tarea; %,12,[])/tarea; 
DATA.POND_area = squeeze(data(6,:,:))/tarea; %,12,[])/tarea; 
DATA.BARE_area = squeeze(data(1,:,:) - data(7,:,:) -data(6,:,:))/tarea; %,12,[])/tarea; 


DATA.SNOW_alb = reshape(data(8,:),12,[])./(tarea); 
DATA.ICE_alb = reshape(data(9,:),12,[])./(tarea); 
DATA.POND_alb = reshape(data(10,:),12,[])./(tarea); 

DATA.SI_alb = 1 - DATA.SW_ic ./ (DATA.SW_dn .*DATA.SI_conc);

DATA.SI_vol = squeeze(data(2,:,:));

DATA.NET_alb = 1-DATA.SW_ab./DATA.SW_dn;
DATA.NET_alb = DATA.SI_conc.*(DATA.SI_alb) + (1-DATA.SI_conc)*(1-coalb_oc); 


if size(DATA.SW_dn,2) == 1
     DATA.SW_dn = squeeze(DATA.SW_dn)'; 
     DATA.SW_ic = squeeze(DATA.SW_ic)'; 
     DATA.SW_oc = squeeze(DATA.SW_oc)'; 
     DATA.SW_ab = squeeze(DATA.SW_ab)'; 
      DATA.NET_alb = squeeze(DATA.NET_alb)'; 
    DATA.SI_area = squeeze(DATA.SI_area)'; 
    DATA.SI_conc = squeeze(DATA.SI_conc)'; 
    DATA.SI_alb = squeeze(DATA.SI_alb)'; 
    DATA.SI_vol = squeeze(DATA.SI_vol)'; 
end

%%
dum = reshape(DATA.SI_conc,size(DATA.SI_conc,1),12,[]); 
DATA.NET_alb_noT = (1 - dum) .* (1 - coalb_oc) + bsxfun(@times,dum,(1 - permute(coalb_ic,[3 1 2]))); 
DATA.NET_alb_noT = reshape(DATA.NET_alb_noT,size(DATA.SI_conc,1),[]); 

%DATA.T_NET_effect_alb = DATA.NET_alb./DATA.NET_alb_noT;
DATA.T_NET_effect_alb = 100*(DATA.NET_alb-DATA.NET_alb_noT)./DATA.NET_alb_noT;

% DATA.T_SI_effect_alb = bsxfun(@rdivide,reshape(DATA.SI_alb,size(DATA.SI_conc,1),12,[]) ,1-permute(coalb_ic,[3 1 2])); 

DATA.T_SI_effect_alb = 100*bsxfun(@minus,reshape(DATA.SI_alb,size(DATA.SI_conc,1),12,[]),1-permute(coalb_ic,[3 1 2])); 
DATA.T_SI_effect_alb = bsxfun(@rdivide,DATA.T_SI_effect_alb,1-permute(coalb_ic,[3 1 2])); 

DATA.T_SI_effect_alb = reshape(DATA.T_SI_effect_alb,size(DATA.SI_conc,1),[]); 

%% Take Ensemble Means
DATA.SI_area_mean = (mean(DATA.SI_area,1));   %ensmeans
DATA.SI_vol_mean = (mean(DATA.SI_vol,1));
DATA.SI_alb_mean = (mean(DATA.SI_alb,1));
DATA.SW_dn_mean = (mean(DATA.SW_dn,1));
DATA.SW_ab_mean = (mean(DATA.SW_ab,1));

DATA.SI_area_clim = (mean(reshape(DATA.SI_area_mean,12,[]),2));   %ensmeans
DATA.SI_vol_clim = (mean(reshape(DATA.SI_vol_mean,12,[]),2));
DATA.SW_alb_clim = (mean(reshape(DATA.SI_alb_mean,12,[]),2));
DATA.SW_dn_clim = (mean(reshape(DATA.SW_dn_mean,12,[]),2));
DATA.SW_ab_clim = (mean(reshape(DATA.SW_ab_mean,12,[]),2));


end

