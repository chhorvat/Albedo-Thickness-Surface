function plot_control_CESM_data(ensemble_x,ensemble_y,N_ens,mos)

x_bymo = squeeze(mean(ensemble_x(mos,:),1)); 
y_bymo = squeeze(mean(ensemble_y(mos,:),1));  

scatter(x_bymo(:),y_bymo(:),1,'markeredgecolor','k','linewidth',0.25)

hold on

scatter(mean(x_bymo),mean(y_bymo),25,'g','filled')

grid on
box on

xl = get(gca,'xlim');
xl(1) = min(xl(1),min(x_bymo(:))); 
xl(2) = max(xl(2),max(x_bymo(:))); 


yl = get(gca,'ylim');
yl(1) = min(yl(1),min(y_bymo(:))); 
yl(2) = max(yl(2),max(y_bymo(:))); 

xlim(xl)
ylim(yl)

end
