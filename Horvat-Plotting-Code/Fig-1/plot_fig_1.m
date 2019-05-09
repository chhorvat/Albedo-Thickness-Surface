close all

xlimmer = [-1.5 1.5];
ylimmer = [-1.5 1.5];

yp = zeros(1,50);
xp = linspace(min(xlimmer),max(xlimmer),100);
yp = linspace(min(ylimmer),max(ylimmer),100);

alblim = .2*[-1 1];

nplot = [1 2 3];
nmonth = [6 7 8];
titles = {'J','F','M','A','M','J','J','A','S','O','N','D'};

% for i = 1:1
%     
%     pid = nplot(i);
%     mid = nmonth(i);
%     
%     Ax{i} = subplot(3,3,pid);
%     
%     pcolor(g_A},grid_H{mid},smooth2a(gridded_dalb{mid},3,3));
%     shading interp
%     hold on
%     contour(grid_A{mid},grid_H{mid}',log10(N_each{mid}),0:6,'--k','showtext','on')
%     
%     xlabel('$\overline{H} \Delta A$','interpreter','latex')
%     
%     if i ==1
%         ylabel('$\overline{A} \Delta H$','interpreter','latex')
%     end
%     grid on
%     % clim = max(abs(get(gca,'clim')));
%     set(gca,'clim',alblim);
%     % colorbar
%     grid on
%     set(gca,'layer','top','fontname','helvetica','fontsize',12,'xminortick','on','yminortick','on')
%     drawnow
%     ylim(xlimmer)
%     xlim(ylimmer)
%     title(titles{mid});
%     add_bg_hatch;
%     plot(0*xp,yp,'--k');
%     plot(xp,0*yp,'--k');
%     
% end

%%

posbig = [.1300 .100 .3347 .51];

Ax{4} = subplot('position',posbig);
pcolor(g_A,g_H,g_dalpha);
shading interp
hold on
contour(g_A,g_H,log10(N_e),[0 1 2 3 4 5 6],'--k','showtext','on')

% colorbar
grid on
set(gca,'layer','top','fontname','helvetica','fontsize',12,'xminorgrid','on','yminorgrid','on','xminortick','on','yminortick','on')
drawnow
ylim(ylimmer)
xlim(xlimmer)
title('All Summer Months')
xlabel('$\overline{H} \Delta A$','interpreter','latex')
ylabel('$\overline{A} \Delta H$','interpreter','latex')
grid on
set(gca,'clim',alblim);
add_bg_hatch;
colorbar(Ax{4},'position',[.042 .100 .0125 .8250],'fontsize',8,'ticks',[-.2 -.1 0 .1 .2]);
set(gca,'yaxislocation','left','ytick',[-1 0 1])


plot(0*xp,yp,'--k');
plot(xp,0*yp,'--k');



%% Plot aggregate data
posbig = [.5703 .100 .3347 .51];


Ax{5} = subplot('position',posbig);

zeropoint_H = floor(size(g_dalpha,2)/2) + 1;
zeropoint_A = floor(size(g_dalpha,1)/2) + 1;

weights = N_e;

weighted_gd = g_dalpha.*weights;

plot(g_A,nansum(weighted_gd,1)./nansum(weights,1))
hold on
plot(g_H,nansum(weighted_gd,2)./nansum(weights,2))

plotter = weighted_gd(zeropoint_H-5:zeropoint_H+5,:);
denom = weights(zeropoint_H-5:zeropoint_H+5,:);

plot(g_A,nansum(plotter,1)./nansum(weights,1));

plotter = weighted_gd(:,zeropoint_A-5:zeropoint_A+5);
denom = weights(:,zeropoint_A-5:zeropoint_A+5);

plot(g_H,nansum(plotter,2)./nansum(weights,2));


legend({'Mean A Effect','Mean H Effect','A effect with no \Delta H','H effect with no \Delta a'},'fontname','helvetica','fontsize')
grid on
box on
ylim(alblim)
xlim(xlimmer);
xlabel('$\Delta V$','interpreter','latex')
ylabel('$\Delta \alpha$','interpreter','latex')


%%

hold all
letter = {'(a)','(b)','(c)','(d)','(e)','(f)','(g)','(e)','(c)'};

delete(findall(gcf,'Tag','legtag'))

for i = 1:length(Ax)
    set(Ax{i},'fontname','helvetica','fontsize',10,'xminortick','on','yminortick','on')
    posy = get(Ax{i},'position');
    annotation('textbox',[posy(1)-.05 posy(2)+posy(4)+.04 .025 .025], ...
        'String',letter{i},'LineStyle','none','FontName','Helvetica', ...
        'FontSize',10,'Tag','legtag');
    
end


colormap(cmap2);

%%
pos = [6.5 4];
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');

%%
% saveas(gcf,'/Users/Horvat/Dropbox/Collaborations/Albedo/Writeup/Figures/Figure-3/Fig-3.fig')
% saveas(gcf,'/Users/Horvat/Dropbox/Collaborations/Albedo/Writeup/Figures/Figure-3/Fig-3.pdf')
