close all

cplots = [228,26,28
55,126,184
77,175,74
152,78,163]/256;


xlimmer = [-1.5 1.6];
ylimmer = [-1.5 1.6];

yp = zeros(1,50);
xp = linspace(min(xlimmer),max(xlimmer),100);
yp = linspace(min(ylimmer),max(ylimmer),100);

alblim = .25*[-1 0];

nmonth = [6 7 8];
titles = {'J','F','M','A','M','J','J','A','S','O','N','D'};

%%

mid = 7; % july

plotter = smooth2a(g_dalpha,3,3);
plot_x = g_A;
plot_y = g_H;

Nplot = N_e;

Ax{1} = subplot(121);
pcolor(plot_x,plot_y',plotter);
shading interp
hold on
% contour(plot_x,plot_y',log10(Nplot),[0 1 2 3 4 5 6],'--k','showtext','on')

% colorbar
grid on
set(gca,'layer','top','fontname','helvetica','fontsize',12,'xminorgrid','on','yminorgrid','on','xminortick','on','yminortick','on')
drawnow
ylim([ylimmer(1) 0])
xlim([xlimmer(1) 0])
title('Surface Albedo Change ','interpreter','latex')
xlabel('$\overline{H} \Delta C$ (m$^3$/m$^2$)','interpreter','latex')
ylabel('$\overline{C} \Delta H$ (m$^3$/m$^2$)','interpreter','latex')
grid on
set(gca,'clim',alblim);
colorbar(Ax{1},'position',[.042 .1443 .0125 .7804],'fontsize',8,'ticks',[-.3 -.2 -.1 0]);
set(gca,'yaxislocation','left','ytick',[-1 0 1])


% plot(0*xp,yp,'--k');
% plot(xp,0*yp,'--k');
add_bg_hatch;



%% Plot aggregate data
posbig = [.5703 .100 .3347 .51];


Ax{2} = subplot(122);

zeropoint_H = floor(size(plotter,2)/2) + 1;
zeropoint_A = floor(size(plotter,1)/2) + 1;

weights = Nplot;

weighted_gd = plotter.*weights;

plot(plot_x,smooth(nansum(weighted_gd,1)./nansum(weights,1)),'color',cplots(1,:),'linewidth',1)
hold on
plot(plot_y,smooth(nansum(weighted_gd,2)./nansum(weights,2)),'color',cplots(2,:),'linewidth',1)

plotter_A = weighted_gd(zeropoint_H-5:zeropoint_H+5,:);
denom = weights(zeropoint_H-5:zeropoint_H+5,:);

plot(plot_x,smooth(nansum(plotter_A,1)./nansum(weights,1)),'--','color',cplots(1,:),'linewidth',1);

plotter_H = weighted_gd(:,zeropoint_A-5:zeropoint_A+5);
denom = weights(:,zeropoint_A-5:zeropoint_A+5);

plot(plot_y,smooth(nansum(plotter_H,2)./nansum(weights,2)),'--','color',cplots(2,:),'linewidth',1);

title('Surface Albedo Change ','interpreter','latex')
legend({'A Effect','H Effect'},'location','southeast');% ,'\Delta H=0','\Delta A = 0'},'fontname','helvetica')
grid on
box on
ylim([-.23 0])
xlim([xlimmer(1) 0]);
xlabel('$\Delta V$ (m$^3$/m$^2$)','interpreter','latex')
ylabel('$\Delta \alpha$, (unitless)','interpreter','latex')


%%

hold all
letter = {'(a)','(b)','(c)','(d)','(e)','(f)','(g)','(e)','(c)'};

delete(findall(gcf,'Tag','legtag'))

for i = 1:length(Ax)
    set(Ax{i},'fontname','helvetica','fontsize',10,'xminortick','on','yminortick','on')
    posy = get(Ax{i},'position');
    annotation('textbox',[posy(1)-.05 posy(2)+posy(4)+.05 .025 .025], ...
        'String',letter{i},'LineStyle','none','FontName','Helvetica', ...
        'FontSize',10,'Tag','legtag');
    
end

cmap3 = [256 256 256
    255,247,236
254,232,200
253,212,158
253,187,132
252,141,89
239,101,72
215,48,31
179,0,0
127,0,0]/256;

colormap(flipud(cmap3));


annotation('textbox',[.0225 .99 .025 .025], ...
        'String','$\Delta \alpha$','LineStyle','none','FontName','Helvetica', ...
        'FontSize',10,'Tag','legtag','interpreter','latex');

%%
pos = [6 2];
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');

%%
saveas(gcf,'/Users/chorvat/Dropbox (Brown)/Apps/Overleaf/Albedo-Feedback-Thickness/Figures/Figure-1/Fig-1.fig')
saveas(gcf,'/Users/chorvat/Dropbox (Brown)/Apps/Overleaf/Albedo-Feedback-Thickness/Figures/Figure-1/Fig-1.pdf')
saveas(gcf,'/Users/chorvat/Dropbox (Brown)/Apps/Overleaf/Albedo-Feedback-Thickness/Figures/Figure-1/Fig-1.jpg')

