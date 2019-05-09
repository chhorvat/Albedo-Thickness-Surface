clear
close all

%% Preamble
fig_2_preamble; 

%% Data in mons
close all

mons = 5:7; 

tarea_nh_small = 14.06; 

shrinkrat = 1; % tarea_nh/tarea_nh_small; % tarea_nh / tarea_small; 

% This is the average sea ice albedo in this month for the control run
alb_ic_hist = shrinkrat*nanmean(nanmean(CONTROL.NH.SI_alb(mons,:)));

% Area used to compute SI albedo and concentration
% tarea_nh = 58.4383; 
% Area of Arctic - lots smaller.


% Plot 1: Sea Ice albedo against ice area
Ax{1} = subplot(2,2,1);

% Add the data from forced runs
[~,~] = plot_forced_CESM_data(FORCED.NH.SI_area,shrinkrat*FORCED.NH.SI_alb,N_ensemble,mons,0);

% Add the data from the control run
plot_control_CESM_data(CONTROL.NH.SI_area,shrinkrat*CONTROL.NH.SI_alb,N_ensemble,mons);

% 
% Add the control run average
xlim([2 11])
ylim([.4 .8])
xl = get(gca,'xlim');
plot(linspace(xl(1),xl(2),100),alb_ic_hist + 0 * (1:100),'--','color','k','linewidth',1)


xlabel('Ice Area (million sq km)','interpreter','latex')
ylabel('$\alpha_{\textrm{Arctic},i}$','interpreter','latex')
title('PIP Arctic Sea Ice Albedo','interpreter','latex')
Y = squeeze(reshape(mean(FORCED.NH.SI_alb,1),12,[])); 
Y = Y(mons,:); 
X = squeeze(reshape(mean(FORCED.NH.SI_area,1),12,[])); 
X = X(mons,:); 
% slope = regress(Y',X')

Ax{2} = subplot(2,2,2);

N_ensemble=33;

mons = 5:7; 

% Add the data from forced runs
[~,~] = plot_forced_CESM_data(FORCED.NH.SI_vol ./ FORCED.NH.SI_area,FORCED.NH.SI_alb,N_ensemble,mons,0);

% Add the data from the control run
plot_control_CESM_data(CONTROL.NH.SI_vol./CONTROL.NH.SI_area,CONTROL.NH.SI_alb,N_ensemble,mons);

title('PIP Arctic Sea Ice Albedo','interpreter','latex');
xlabel('Ice Thickness (m)','interpreter','latex')
% Add the control run average
xlim([0 max(get(gca,'xlim'))])
ylim([.4 .8])
xl = get(gca,'xlim');
plot(linspace(xl(1),xl(2),100),alb_ic_hist + 0 * (1:100),'--','color','k','linewidth',1)

%

%  Scatter Albedo against Volume
% Don't plot
% subplot(233)
% 
% [~,~] = plot_forced_CESM_data(FORCED.NH.SI_vol,FORCED.NH.SI_alb,N_ensemble,mons)
% 
% plot_control_CESM_data(CONTROL.NH.SI_vol,CONTROL.NH.SI_alb,N_ensemble,mons)
% xlim([0 max(get(gca,'xlim'))])
% xlabel('Sea Ice Volume (thousand cubic km)')
% xl = get(gca,'xlim');
% plot(linspace(xl(1),xl(2),100),alb_ic_hist + 0 * (1:100),'--k')


% Third plot: Compute the surface if there was no dependence of the ice
% albed on thickness against sea ice area

% Ax{2} = subplot(122);
% [A_clim,Alb_clim_noT] = plot_forced_CESM_data_2(FORCED.NH.SI_area,shrinkrat*FORCED.NH.NET_alb_noT,N_ensemble,mons,0);
% hold on
% [~,Alb_clim] = plot_forced_CESM_data(FORCED.NH.SI_area,shrinkrat*FORCED.NH.NET_alb,N_ensemble,mons,0);
% 
% plot_control_CESM_data(CONTROL.NH.SI_area,shrinkrat*CONTROL.NH.NET_alb,N_ensemble,mons)
% 
% xlabel('Ice Area (million sq km)')
% ylabel('Surface Albedo')
% xlim([0 9.5])
% ylim([.17 .55])
% 
% 
% Y = squeeze(reshape(mean(shrinkrat*FORCED.NH.NET_alb_noT,1),12,[])); 
% Y = Y(mons,:); 
% X = squeeze(reshape(mean(FORCED.NH.SI_area,1),12,[])); 
% X = X(mons,:); 
% slopeNOTN = regress([Y'],[ones(size(Y')) X'])
% 
% X = squeeze(reshape(mean(FORCED.NH.SI_area,1),12,[])); 
% X = X(mons,:); 
% Y = squeeze(reshape(mean(shrinkrat*FORCED.NH.NET_alb,1),12,[])); 
% Y = Y(mons,:); 
% slope_AN = regress([Y'],[ones(size(Y')) X'])

Ax{3} = subplot(2,1,2); 

N_ens = 33; 
N_runs = size(FORCED.NH.NET_alb,1); 

del = N_runs - N_ens; 
% Data in mons
% This is the average sea ice albedo in this month for the control run

alb_ic_hist = mean(mean(CONTROL.NH.SI_alb(mons,:)));

% Area used to compute SI albedo and concentration
tarea_nh = 58.4383; 
% Area of Arctic - lots smaller.
tarea_nh_small = 14.06; 
coalb_oc = 0.96; 
% ALB_I = reshape(FORCED.NH.SI_alb,N_runs,12,[]); 

ALB_N = reshape(FORCED.NH.NET_alb,N_runs,12,[]); 
ALB_W = reshape(FORCED.NH.NET_alb_noT,N_runs,12,[]);
varN = squeeze(std(ALB_N(1:N_ens,mons,:),0,1)); 
varW = squeeze(std(ALB_W(1:N_ens,mons,:),0,1)); 

% plot(time_axis,squeeze(mean(ALB_I(1:N_ens,mons,:),2)),'color',[222,235,247
% ]/256); 
% hold on
plot(time_axis,squeeze(mean(ALB_N(1:N_ens,mons,:),2)),'color',[229,245,224]/256); 
hold on
plot(time_axis,squeeze(mean(ALB_W(1:N_ens,mons,:),2)),'color',[254,230,206]/256); 

p1 = smooth(squeeze(mean(mean(ALB_N(1:N_ens,mons,:),2),1)),10);
p2 = smooth(squeeze(mean(mean(ALB_W(1:N_ens,mons,:),2),1)),10);
p3 = p2 - p1; 

h1 = plot(time_axis,p1,'color',[49,163,84]/256); 
% h2 = plot(time_axis,smooth(squeeze(mean(mean(ALB_W(1:N_ens,mons,:),2),1))),'color',[49,163,84]/256); 
h2 = plot(time_axis,p2,'color',[217,95,14]/256); 

plot(time_axis,smooth(squeeze(mean(varN,1)),10) + smooth(squeeze(mean(mean(ALB_N(1:N_ens,mons,:),2),1)),10),'--','color',[49,163,84]/256)
plot(time_axis,-smooth(squeeze(mean(varN,1)),10) + smooth(squeeze(mean(mean(ALB_N(1:N_ens,mons,:),2),1)),10),'--','color',[49,163,84]/256)
plot(time_axis,smooth(squeeze(mean(varW,1)),10) + smooth(squeeze(mean(mean(ALB_W(1:N_ens,mons,:),2),1)),10),'--','color',[217,95,14]/256)
plot(time_axis,-smooth(squeeze(mean(varW,1)),10) + smooth(squeeze(mean(mean(ALB_W(1:N_ens,mons,:),2),1)),10),'--','color',[217,95,14]/256)

scatter(2019,p1(170),50,'filled','markerfacecolor',[49,163,84]/256); 
scatter(2019,p2(170),50,'filled','markerfacecolor',[217,95,14]/256); 

legend([h1 h2],'$\alpha_{\textrm{Arctic},i}$ Free','$\alpha_{\textrm{Arctic},i}$ Fixed','location','southwest','interpreter','latex')

grid on
box on
hold off
xlim([1920 2100])
ylim([.25 .65])

xlabel('Year','interpreter','latex')
ylabel('$\alpha_{Arctic}$','interpreter','latex')
title('PIP Arctic Surface Albedo','interpreter','latex'); 


%%


%%



hold all
letter = {'(a)','(b)','(c)','(d)','(e)','(f)','(g)','(e)','(c)'};

delete(findall(gcf,'Tag','legtag'))

for i = 1:length(Ax)
    set(Ax{i},'fontname','helvetica','fontsize',10,'xminortick','on','yminortick','on')
    posy = get(Ax{i},'position');
    annotation('textbox',[posy(1)-.035 posy(2)+posy(4)+.05 .025 .025], ...
        'String',letter{i},'LineStyle','none','FontName','Helvetica', ...
        'FontSize',10,'Tag','legtag');
    
end

%
pos = [6 3.5]; 
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');

%%
saveas(gcf,'/Users/chorvat/Dropbox (Brown)/Apps/Overleaf/Albedo-Feedback-Thickness/Figures/Figure-2/Fig-2.fig')
saveas(gcf,'/Users/chorvat/Dropbox (Brown)/Apps/Overleaf/Albedo-Feedback-Thickness/Figures/Figure-2/Fig-2.pdf')
