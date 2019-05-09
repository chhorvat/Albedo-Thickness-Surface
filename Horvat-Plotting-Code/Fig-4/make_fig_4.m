clear
close all

% addpath('~/Dropbox (Brown)/Matlab_Utilities/Plotting-Scripts/');

%% Preamble
% load('../Processed-Data/processed_LES');
run('../Fig-2/fig_2_preamble');
clearvars -except FORCED CONTROL time_axis tarea_nh coalb*

%% Make plot of PIP SI Thickness Versus Albedo

% Ax{1} = subplot(2,2,1);
% 
% N_ensemble=33;
% 
% mons = 5:7; 
% 
% % Add the data from forced runs
% [~,~] = plot_forced_CESM_data(FORCED.NH.SI_vol ./ FORCED.NH.SI_area,FORCED.NH.SI_alb,N_ensemble,mons,0);
% 
% % Add the data from the control run
% plot_control_CESM_data(CONTROL.NH.SI_vol./CONTROL.NH.SI_area,CONTROL.NH.SI_alb,N_ensemble,mons);
% 
% title('PIP Sea Ice Albedo','interpreter','latex');
% xlabel('Ice Thickness (m)','interpreter','latex')
% ylabel('$\alpha_{\mathrm{Arctic,i}}$','interpreter','latex');
% xlim([0 max(get(gca,'xlim'))])


%% 
mons = 7; 
window = 40; 
N_ens = 33;
N_runs = size(FORCED.NH.NET_alb,1);

del = N_runs - N_ens;
% Data in mons
% This is the average sea ice albedo in this month for the control run

alb_ic_hist = nanmean(nanmean(CONTROL.NH.SI_alb(mons,:)));
alb_ic_forc = reshape(FORCED.NH.SI_alb,35,12,[]);
alb_ic_forc = nanmean(nanmean(alb_ic_forc(:,mons,:),1),3);

% Area used to compute SI albedo and concentration
% tarea_comp = 12.96062;
% Area of Arctic - lots smaller.
tarea_Arctic = 14.06;

% This factor corrects for the fact that we include more than 66N and
% above.
corr_frac = 1; % tarea_nh/tarea_Arctic;


%

Ax{1} = subplot(211);

% Total areas
ICE = reshape(corr_frac*FORCED.NH.SI_conc,N_runs,12,[]);
BARE = reshape(corr_frac*FORCED.NH.BARE_area,N_runs,12,[]);
SNOW = reshape(corr_frac*FORCED.NH.SNOW_area,N_runs,12,[]);
POND = reshape(corr_frac*FORCED.NH.POND_area,N_runs,12,[]);

ICEA = reshape(FORCED.NH.SI_alb,N_runs,12,[]);
ICEA(ICEA > 1) = nan;
ICEA(ICEA <=0) = nan;

% Compute the surface albedos.
BAREA = corr_frac*reshape(FORCED.NH.ICE_alb,N_runs,12,[])./BARE;
BAREA(BAREA > 1) = nan;
BAREA(BAREA <=0) = nan;
Balbhis = squeeze(nanmean(nanmean(nanmean(BAREA(:,mons,1:150)))));

PONDA = corr_frac*reshape(FORCED.NH.POND_alb,N_runs,12,[])./POND;
PONDA(PONDA > 1) = nan;
PONDA(PONDA <=0) = nan;
Palbhis = squeeze(nanmean(nanmean(nanmean(PONDA(:,mons,1:150)))))

SNOWA = corr_frac*reshape(FORCED.NH.SNOW_alb,N_runs,12,[])./SNOW;
SNOWA(SNOWA > 1) = nan;
SNOWA(SNOWA <=0) = nan;
Salbhis = squeeze(nanmean(nanmean(nanmean(SNOWA(:,mons,1:150)))))

%
% Ensemble members
plot(time_axis,squeeze(mean(ICE(1:N_ens,mons,:),2)),'color',[204,204,204]/256);
hold on
plot(time_axis,squeeze(mean(BARE(1:N_ens,mons,:),2)),'color',[186,228,179]/256);
plot(time_axis,squeeze(mean(POND(1:N_ens,mons,:),2)),'color',[107,174,214]/256);
plot(time_axis,squeeze(mean(SNOW(1:N_ens,mons,:),2)),'color',[252,174,145]/256);




% Ensemble means
p0 = smooth(squeeze(mean(mean(ICE(1:N_ens,mons,:),2),1)),10);
v0 = smooth(squeeze(std(mean(ICE(1:N_ens,mons,:),2),1,1)),10);

h0 = plot(time_axis,p0,'-','color',[82,82,82]/256);
plot(time_axis,p0+v0,'--','color',[82,82,82]/256);
plot(time_axis,p0-v0,'--','color',[82,82,82]/256);

p1 = smooth(squeeze(mean(mean(BARE(1:N_ens,mons,:),2),1)),10);
v1 = smooth(squeeze(std(mean(BARE(1:N_ens,mons,:),2),1,1)),10);

h1 = plot(time_axis,p1,'-','color',[35,139,69]/256);
plot(time_axis,p1+v1,'--','color',[35,139,69]/256);
plot(time_axis,p1-v1,'--','color',[35,139,69]/256);

p2 = smooth(squeeze(mean(mean(POND(1:N_ens,mons,:),2),1)),10);
v2 = smooth(squeeze(std(mean(POND(1:N_ens,mons,:),2),1,1)),10);

h2 = plot(time_axis,p2,'-','color',[33,113,181]/256);
plot(time_axis,p2+v2,'--','color',[33,113,181]/256);
plot(time_axis,p2-v2,'--','color',[33,113,181]/256);

p3 = smooth(squeeze(mean(mean(SNOW(1:N_ens,mons,:),2),1)),10);
v3 = smooth(squeeze(std(mean(SNOW(1:N_ens,mons,:),2),1,1)),10);

h3 = plot(time_axis,p3,'-','color',[203,24,29]/256);
plot(time_axis,p3+v3,'--','color',[203,24,29]/256);
plot(time_axis,p3-v3,'--','color',[203,24,29]/256);


legend([h0 h1 h2 h3],'Sea Ice','Bare Ice','Melt Pond','Snow','location','eastoutside')

grid on
box on

title('July Ocean Surface Types','interpreter','latex');
ylabel('Fraction','interpreter','latex');
xlabel('Year','interpreter','latex')
% plot(time_axis,squeeze(mean(mean(field(15,mons,:),2),1)),'color','r');

% for i = 1:del
%     plot(time_axis,squeeze(mean(field(N_ens+i:end,mons,:),2)),'color',colrs(i,:));
% end

xlim([1920 + window 2100])
ylim([0 .75])

hold off

%%
Ax{2} = subplot(223);
cla
% Total areas
ICE = reshape(corr_frac*FORCED.NH.SI_conc,N_runs,12,[]);
BAREF = reshape(corr_frac*FORCED.NH.BARE_area,N_runs,12,[])./ICE;
SNOWF = reshape(corr_frac*FORCED.NH.SNOW_area,N_runs,12,[])./ICE;
PONDF = reshape(corr_frac*FORCED.NH.POND_area,N_runs,12,[])./ICE;


%
% Ensemble members
% plot(time_axis,squeeze(mean(ICEA(1:N_ens,mons,:),2)),'color',[204,204,204]/256);
% hold on
% plot(time_axis,squeeze(mean(BAREA(1:N_ens,mons,:),2)),'color',[186,228,179]/256);
% plot(time_axis,squeeze(mean(PONDA(1:N_ens,mons,:),2)),'color',[107,174,214]/256);
% plot(time_axis,squeeze(mean(SNOWA(1:N_ens,mons,:),2)),'color',[252,174,145]/256);
% 
% Ensemble means
p0 = smooth(squeeze(mean(mean(ICE(1:N_ens,mons,:),2),1)),10);
% v0 = smooth(squeeze(std(mean(ICEA(1:N_ens,mons,:),2),1,1)),10);

% h0 = plot(time_axis,p0,'-','color',[82,82,82]/256);
% hold on
% plot(time_axis,p0+v0,'--','color',[82,82,82]/256);
% plot(time_axis,p0-v0,'--','color',[82,82,82]/256);

p1 = smooth(squeeze(mean(mean(BAREF(1:N_ens,mons,:),2),1)),10);
% v1 = smooth(squeeze(std(mean(BAREA(1:N_ens,mons,:),2),1,1)),10);

% h1 = plot(time_axis,p1,'-','color',[35,139,69]/256);
% plot(time_axis,p1+v1,'--','color',[35,139,69]/256);
% plot(time_axis,p1-v1,'--','color',[35,139,69]/256);

p2 = smooth(squeeze(mean(mean(PONDF(1:N_ens,mons,:),2),1)),10);
% v2 = smooth(squeeze(std(mean(PONDA(1:N_ens,mons,:),2),1,1)),10);

% h2 = plot(time_axis,p2,'-','color',[33,113,181]/256);
% plot(time_axis,p2+v2,'--','color',[33,113,181]/256);
% plot(time_axis,p2-v2,'--','color',[33,113,181]/256);

p3 = smooth(squeeze(mean(mean(SNOWF(1:N_ens,mons,:),2),1)),10);
% v3 = smooth(squeeze(std(mean(SNOWA(1:N_ens,mons,:),2),1,1)),10);

% h3 = plot(time_axis,p3,'-','color',[203,24,29]/256);
% plot(time_axis,p3+v3,'--','color',[203,24,29]/256);
% plot(time_axis,p3-v3,'--','color',[203,24,29]/256);

%
b = bar(time_axis,100*[p1 p2 p3],'stacked');
% set(b(1),'FaceColor',[82,82,82]/256); 
set(b(1),'FaceColor',[35,139,69]/256); 
set(b(2),'FaceColor',[33,113,181]/256); 
set(b(3),'FaceColor',[203,24,29]/256);

legend('Bare','Pond','Snow','location','northwest')

grid on
box on

title('July Sea Ice Types','interpreter','latex');
ylabel('\%','interpreter','latex');
xlabel('Year','interpreter','latex')
% plot(time_axis,squeeze(mean(mean(field(15,mons,:),2),1)),'color','r');

% for i = 1:del
%     plot(time_axis,squeeze(mean(field(N_ens+i:end,mons,:),2)),'color',colrs(i,:));
% end

xlim([1920 + window 2100])
ylim([0 100])

hold off

%%

% N_ensemble=33;

% Add the data from forced runs
%[~,~] = plot_forced_CESM_data(FORCED.NH.SI_vol ./ FORCED.NH.SI_area,FORCED.NH.SI_alb,N_ensemble,mons,0);

% % Add the data from the control run
% plot_control_CESM_data(CONTROL.NH.SI_vol./CONTROL.NH.SI_area,CONTROL.NH.SI_alb,N_ensemble,mons);
% 
% title('Arctic Sea Ice Albedo','interpreter','latex');
% xlabel('Ice Thickness (m)','interpreter','latex')
% ylabel('$\alpha_{\mathrm{Arctic,i}}$','interpreter','latex');
% xlim([0 max(get(gca,'xlim'))])

%
Ax{3} = subplot(224);

alb_combo = Balbhis*BARE./ICE + Palbhis*POND./ICE + Salbhis*SNOW./ICE;
alb_combo = squeeze(mean(alb_combo(:,mons,:),2));

alb_hist = reshape(FORCED.NH.SI_alb,35,12,[]);
alb_hist = squeeze(mean(alb_hist(:,mons,:),2));

thick = FORCED.NH.SI_vol./FORCED.NH.SI_area;
thick = reshape(thick,35,12,[]);
thick = squeeze(mean(thick(:,mons,:),2));

clear bsave

rsqall = zeros(1,251);
rsqt = rsqall;
rsqc = rsqall;
%
starter = 1; 

for i = 1:251-starter-window+1
    
    timper = starter+i:starter+i+window-1;
    
    %     for j = 1:35
    %
    %
    %         albvec = ((alb_hist(j,timper))');
    %         albvec = (albvec - mean(albvec))/std(albvec);
    %
    %         tvec = thick(j,timper)';
    %         tvec = (tvec - mean(tvec))/std(tvec);
    %
    %         combovec = alb_combo(j,timper)';
    %         combovec = (combovec - mean(combovec))/std(combovec);
    %
    %         [b,bint,r,rint,stats] = regress(albvec,[ones(size(tvec)) combovec]);
    %
    %         rsqc(j,timper(end)) = stats(1);
    %
    %         [b,bint,r,rint,stats] = regress(albvec,[ones(size(tvec)) tvec combovec]);
    %
    %         rsqall(j,timper(end)) = stats(1);
    %
    %         [b,bint,r,rint,stats] = regress(albvec,[ones(size(tvec)) tvec]);
    %
    %         rsqt(j,timper(end)) = stats(1);
    %
    %     end
    
            albvec = (nanmean(alb_hist(:,timper),1)');
        albvec = (albvec - mean(albvec))/std(albvec);
        
        tvec = nanmean(thick(:,timper),1)';
        tvec = (tvec - mean(tvec))/std(tvec);
        
        combovec = nanmean(alb_combo(:,timper),1)';
        combovec = (combovec - mean(combovec))/std(combovec);
        
        
        [b,bint,r,rint,stats] = regress(albvec,[ones(size(tvec)) combovec]);
        
        RC(timper(end)) = stats(1);
        
        [b,bint,r,rint,stats] = regress(albvec,[ones(size(tvec)) tvec combovec]);
        
        RA(timper(end)) = stats(1);

        [b,bint,r,rint,stats] = regress(albvec,[ones(size(tvec)) tvec]);
        
        RT(timper(end)) = stats(1);

end

plot(time_axis,smooth(100*RC,window/2),'color',[228,26,28]/256)
hold on
plot(time_axis,smooth(100*RT,window/2),'color',[55,126,184]/256)

xlim([1920 + window 2100])
ylim([55 100])
grid on
box on

title('\% of $\alpha_{\textrm{Arctic},i}$ explained','interpreter','latex');
ylabel('\% Explained','interpreter','latex');
xlabel('Year','interpreter','latex')
legend('Surface Change','Direct Thinning','location','southwest')
hold off



%%

letter = {'(a)','(b)','(c)','(d)','(e)','(f)','(g)','(e)','(c)'};

delete(findall(gcf,'Tag','legtag'))

for i = 1:length(Ax)
    set(Ax{i},'fontname','helvetica','fontsize',10,'xminortick','on','yminortick','on')
    posy = get(Ax{i},'position');
    annotation('textbox',[posy(1)-.05 posy(2)+posy(4)+.05 .025 .025], ...
        'String',letter{i},'LineStyle','none','FontName','Helvetica', ...
        'FontSize',10,'Tag','legtag');
    
end

%% 
drawnow
pos = [6 3.5]; 
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');

%%
saveas(gcf,'/Users/chorvat/Dropbox (Brown)/Apps/Overleaf/Albedo-Feedback-Thickness/figures/Figure-4/Fig-4.fig')
saveas(gcf,'/Users/chorvat/Dropbox (Brown)/Apps/Overleaf/Albedo-Feedback-Thickness/figures/Figure-4/Fig-4.pdf')
