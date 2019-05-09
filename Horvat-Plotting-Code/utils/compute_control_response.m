function [DATA,coalb_ic] = compute_control_response(data,tarea)

coalb_oc = 0.93; 

%% Accumulate the data
DATA.SW_dn = reshape(data(5,:),12,[])/tarea;
DATA.SW_ic = reshape(data(3,:),12,[])/tarea;
DATA.SW_oc = coalb_oc*reshape(data(4,:),12,[])/tarea;
DATA.SW_ab = DATA.SW_ic + DATA.SW_oc; 
DATA.SI_area = reshape(data(1,:),12,[]); 
DATA.SI_conc = (DATA.SW_dn - reshape(data(4,:),12,[])/tarea) ./ DATA.SW_dn; 
DATA.SI_conc = reshape(data(1,:),12,[])/tarea;
DATA.SNOW_area = reshape(data(7,:),12,[])./(tarea); 
DATA.POND_area = reshape(data(6,:),12,[])./(tarea); 

DATA.SNOW_alb = reshape(data(8,:),12,[])./(tarea); 
DATA.ICE_alb = reshape(data(9,:),12,[])./(tarea); 
DATA.POND_alb = reshape(data(10,:),12,[])./(tarea); 


DATA.SI_alb = 1 - DATA.SW_ic ./ (DATA.SW_dn .*DATA.SI_conc);


coalb_ic = 1 - mean(DATA.SI_alb,2); 
DATA.SI_vol = reshape(data(2,:),12,[]); 

DATA.NET_alb = 1 - DATA.SW_ab./DATA.SW_dn; 
DATA.NET_alb = DATA.SI_conc.*(DATA.SI_alb) + (1-DATA.SI_conc).*(1-coalb_oc); 


% Create a climatology
DATA.SI_area_clim = squeeze(mean(DATA.SI_area,2)); 
DATA.SI_vol_clim = squeeze(mean(DATA.SI_vol,2)); 
DATA.SI_alb_clim = mean(reshape(DATA.SI_alb,12,[]),2);
DATA.SW_dn_clim = mean(reshape(DATA.SW_dn,12,[]),2);
DATA.SW_ab_clim = mean(reshape(DATA.SW_ab,12,[]),2);

DATA.NET_alb_noT = (1 - DATA.SI_conc) .* (1 - coalb_oc) + bsxfun(@times,DATA.SI_conc,(1 - coalb_ic)); 

DATA.T_effect_alb = (DATA.NET_alb-DATA.NET_alb_noT)./DATA.NET_alb_noT;
DATA.SI_alb_noT = DATA.SI_alb ./ DATA.T_effect_alb; 


end