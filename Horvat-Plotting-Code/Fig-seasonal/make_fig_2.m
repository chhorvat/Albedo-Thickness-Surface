
% We want to show the relative contribution of SW changes for each month. 

% Historical SW input in each month
yrs = 1850:2100;
mos = 1:12; 

SW_dn_hist = squeeze(nanmean(CONTROL.NH.SW_dn(mos,:),2));
SW_dn = squeeze(nanmean(FORCED.NH.SW_dn(1:33,:),1)); 
SW_dn = reshape(SW_dn,[12 251]); 
SW_dn = SW_dn(mos,:); 
SW_dn_diff = bsxfun(@minus,SW_dn,SW_dn_hist); 

SW_ab_hist = squeeze(nanmean(CONTROL.NH.SW_ab(mos,:),2));
SW_ab = squeeze(nanmean(FORCED.NH.SW_ab(1:33,:),1)); 
SW_ab = reshape(SW_ab,[12 251]); 
SW_ab = SW_ab(mos,:); 
SW_ab_diff = bsxfun(@minus,SW_ab,SW_ab_hist); 

SI_conc_hist = squeeze(nanmean(CONTROL.NH.SI_conc(mos,:),2));
SI_conc = squeeze(nanmean(FORCED.NH.SI_conc(1:33,:),1)); 
SI_conc = reshape(SI_conc,[12 251]); 
SI_conc = SI_conc(mos,:); 
SI_conc_diff = bsxfun(@minus,SI_conc,SI_conc_hist); 

SI_alb_hist = squeeze(nanmean(CONTROL.NH.SI_alb(mos,:),2));
SI_alb = squeeze(nanmean(FORCED.NH.SI_alb(1:33,:),1)); 
SI_alb = reshape(SI_alb,[12 251]); 
SI_alb = SI_alb(mos,:); 
SI_alb_diff = bsxfun(@minus,SI_alb,SI_alb_hist); 

NET_alb_hist = squeeze(nanmean(CONTROL.NH.NET_alb(mos,:),2));
NET_alb = squeeze(nanmean(FORCED.NH.NET_alb(1:33,:),1)); 
NET_alb = reshape(NET_alb,[12 251]); 
NET_alb = NET_alb(mos,:); 
NET_alb_diff = bsxfun(@minus,NET_alb,NET_alb_hist); 

%
subplot(121)

GWper = 130:157; 

GW_dalb = SW_dn_hist.*(NET_alb(:,GWper(end)) - NET_alb(:,GWper(1)));
contrib_SI = SW_dn_hist.*squeeze(mean(SI_conc(:,GWper(:)),2)).*(SI_alb(:,GWper(end)) - SI_alb(:,GWper(1))); 
contrib_conc = SW_dn_hist.*(squeeze(mean(SI_alb(:,GWper(:)),2))-.07).*(SI_conc(:,GWper(end)) - SI_conc(:,GWper(1))); 

data = [contrib_SI contrib_conc]; 
bar(data,'stacked')
legend('Thickness','Extent')
xlabel('Month')
title('1979-2006')
xlim([5.5 9.5])
% ylim([0 1])

subplot(122)


GWper = 158:201; 

GW_dalb = SW_dn_hist.*(NET_alb(:,GWper(end)) - NET_alb(:,GWper(1)));
contrib_SI = SW_dn_hist.*squeeze(mean(SI_conc(:,GWper(:)),2)).*(SI_alb(:,GWper(end)) - SI_alb(:,GWper(1))); 
contrib_conc = SW_dn_hist.*(squeeze(mean(SI_alb(:,GWper(:)),2))-.07).*(SI_conc(:,GWper(end)) - SI_conc(:,GWper(1))); 

data = [contrib_SI contrib_conc]; 
bar(data,'stacked')
legend('Thickness','Extent')
xlabel('Month')
title('2007-2050')

xlim([5.5 9.5])
% ylim([0 1])
