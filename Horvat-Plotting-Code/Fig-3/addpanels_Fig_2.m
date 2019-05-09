close all

% addpath('~/Dropbox (Brown)/Matlab_Utilities/Plotting-Scripts/');

%% Preamble
% load('../Processed-Data/processed_LES');
run('../Fig-2/fig_2_preamble');
clearvars -except FORCED CONTROL time_axis tarea_nh coalb*

% We want to show the relative contribution of SW changes for each month. 

% Historical SW input in each month
yrs = 1850:2100;
mos = 5:9; 
months = {'May','Jun','Jul','Aug','Sep','All'};

SW_dn_hist = squeeze(nanmean(CONTROL.NH.SW_dn(:,:),2));
SW_dn = squeeze(nanmean(FORCED.NH.SW_dn(1:33,:),1)); 
SW_dn = reshape(SW_dn,[12 251]); 
SW_dn = SW_dn(:,:); 
SW_dn_diff = bsxfun(@minus,SW_dn,SW_dn_hist); 

SW_ab_hist = squeeze(nanmean(CONTROL.NH.SW_ab(:,:),2));
SW_ab = squeeze(nanmean(FORCED.NH.SW_ab(1:33,:),1)); 
SW_ab = reshape(SW_ab,[12 251]); 
SW_ab = SW_ab(:,:); 
SW_ab_diff = bsxfun(@minus,SW_ab,SW_ab_hist); 

SI_conc_hist = squeeze(nanmean(CONTROL.NH.SI_conc(:,:),2));
SI_conc = squeeze(nanmean(FORCED.NH.SI_conc(1:33,:),1)); 
SI_conc = reshape(SI_conc,[12 251]); 
SI_conc = SI_conc(:,:); 
SI_conc_diff = bsxfun(@minus,SI_conc,SI_conc_hist); 

SI_alb_hist = squeeze(nanmean(CONTROL.NH.SI_alb(:,:),2));
SI_alb = squeeze(nanmean(FORCED.NH.SI_alb(1:33,:),1)); 
SI_alb = reshape(SI_alb,[12 251]); 
SI_alb = SI_alb(:,:); 
SI_alb_diff = bsxfun(@minus,SI_alb,SI_alb_hist); 

NET_alb_hist = squeeze(nanmean(CONTROL.NH.NET_alb(:,:),2));
NET_alb = squeeze(nanmean(FORCED.NH.NET_alb(1:33,:),1)); 
NET_alb = reshape(NET_alb,[12 251]); 
NET_alb = NET_alb(:,:); 
NET_alb_diff = bsxfun(@minus,NET_alb,NET_alb_hist); 

%
Ax{1} = subplot(121);
cla

GWper = 130:169; 

GW_dalb = SW_dn_hist.*(NET_alb(:,GWper(end)) - NET_alb(:,GWper(1)));
contrib_SI = SW_dn_hist.*squeeze(mean(SI_conc(:,GWper(:)),2)).*(SI_alb(:,GWper(end)) - SI_alb(:,GWper(1))); 
contrib_conc = SW_dn_hist.*(squeeze(mean(SI_alb(:,GWper(:)),2))-.07).*(SI_conc(:,GWper(end)) - SI_conc(:,GWper(1))); 

contrib_conc(contrib_conc > 0) = nan; 
contrib_SI(contrib_SI > 0) = nan; 

contrib_SI(end+1) = nanmean(contrib_SI); 
contrib_SI = contrib_SI([mos 13]); 

contrib_conc(end+1) = nanmean(contrib_conc); 
contrib_conc = contrib_conc([mos 13]); 


%
data_per1 = [contrib_SI contrib_conc]; 
b = bar(-data_per1,'stacked');
set(b(1),'FaceColor',[178,24,43]/256); 
set(b(2),'FaceColor',[5,48,97]/256); 

ylim([0 50]);
legend('Ice Albedo','Ice Area','location','northeast')
set(gca,'xtick',1:12,'xticklabel',months)

grid on
box on
hold off
xlim([0.5 6.5])
xlabel('Month','interpreter','latex')
ylabel('W/m$^2$','interpreter','latex')
title([sprintf('%d-%d',yrs(GWper(1)),yrs(GWper(end))) ' Arctic $\Delta$SW'],'interpreter','latex');
% ylim([0 1])

%%
Ax{2} = subplot(122);
cla

GWper = 170:209; 

GW_dalb = SW_dn_hist.*(NET_alb(:,GWper(end)) - NET_alb(:,GWper(1)));
contrib_SI = SW_dn_hist.*squeeze(mean(SI_conc(:,GWper(:)),2)).*(SI_alb(:,GWper(end)) - SI_alb(:,GWper(1))); 
contrib_conc = SW_dn_hist.*(squeeze(mean(SI_alb(:,GWper(:)),2))-.07).*(SI_conc(:,GWper(end)) - SI_conc(:,GWper(1))); 

contrib_conc(contrib_conc > 0) = nan; 
contrib_SI(contrib_SI > 0) = nan; 

contrib_SI(end+1) = nanmean(contrib_SI); 
contrib_SI = contrib_SI([mos 13]); 

contrib_conc(end+1) = nanmean(contrib_conc); 
contrib_conc = contrib_conc([mos 13]); 

data_per2 = [contrib_SI contrib_conc]; 
b = bar(-data_per2,'stacked');
set(b(1),'FaceColor',[178,24,43]/256); 
set(b(2),'FaceColor',[5,48,97]/256); 

% legend('Ice Albedo','Ice Area','location','northeast')
grid on
box on
hold off
xlim([0.5 6.5])
set(gca,'xtick',1:12,'xticklabel',months)
ylim([0 50]);
xlabel('Month','interpreter','latex')
ylabel('','interpreter','latex')
title([sprintf('%d-%d',yrs(GWper(1)),yrs(GWper(end))) ' Arctic $\Delta$SW'],'interpreter','latex');

letter = {'(a)','(b)','(c)','(d)','(e)','(f)','(g)','(e)','(c)'};

delete(findall(gcf,'Tag','legtag'))

for i = 1:length(Ax)
    set(Ax{i},'fontname','helvetica','fontsize',10,'xminortick','on','yminortick','on')
    posy = get(Ax{i},'position');
    annotation('textbox',[posy(1)-.05 posy(2)+posy(4)+.1 .025 .025], ...
        'String',letter{i},'LineStyle','none','FontName','Helvetica', ...
        'FontSize',10,'Tag','legtag');
    
end

%% 
pos = [6 2]; 
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');

%%
saveas(gcf,'/Users/chorvat/Dropbox (Brown)/Apps/Overleaf/Albedo-Feedback-Thickness/Figures/Figure-3/Fig-3.fig')
saveas(gcf,'/Users/chorvat/Dropbox (Brown)/Apps/Overleaf/Albedo-Feedback-Thickness/Figures/Figure-3/Fig-3.pdf')

