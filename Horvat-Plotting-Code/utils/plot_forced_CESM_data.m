function [mean_x,mean_y] = plot_forced_CESM_data(ensemble_x,ensemble_y,N_ens,mos,do_plot_pert)

del = 0;

if N_ens < size(ensemble_x,1)
    
    del = size(ensemble_x,1) - N_ens;
    dpertx = reshape(ensemble_x(N_ens+1:end,:,:),del,12,[]);
    dperty = reshape(ensemble_y(N_ens+1:end,:,:),del,12,[]);
    x_pert_bymo = squeeze(mean(dpertx(:,mos,:),2));
    y_pert_bymo = squeeze(mean(dperty(:,mos,:),2));
    
    ensemble_x = ensemble_x(1:N_ens,:,:);
    ensemble_y = ensemble_y(1:N_ens,:,:);
    
end

ensemble_x = reshape(ensemble_x,N_ens,12,[]);
ensemble_y = reshape(ensemble_y,N_ens,12,[]);


x_bymo = squeeze(mean(ensemble_x(:,mos,:),2));
y_bymo = squeeze(mean(ensemble_y(:,mos,:),2));



scatter(x_bymo(:),y_bymo(:),1,'markeredgecolor',[227,74,51]/256,'linewidth',0.25)

hold on
%%
if del > 0 && do_plot_pert
    
    clabs = [
        77,175,74
        255,255,51
        153,153,153]/256;
    
    for i = 1:del
        
        scatter(x_pert_bymo(i,:),y_pert_bymo(i,:),15,'filled','markeredgecolor',clabs(i,:),'linewidth',0.25)
        
    end
    
end



%%
mean_x = mean(x_bymo,1);
mean_y = mean(y_bymo,1);

scatter(mean_x,mean_y,25,[179,0,0]/256,'filled')

grid on
box on

xlim([min(x_bymo(:)) max(x_bymo(:))])
ylim([min(y_bymo(:)) max(y_bymo(:))]);


yrnow = 169; 

nowx = mean(x_bymo(1:N_ens,yrnow)); 
nowy = mean(y_bymo(1:N_ens,yrnow)); 

scatter(nowx,nowy,100,'x','markeredgecolor','blue'); 

yr2050 = 200; 

nowx = mean(x_bymo(1:N_ens,yr2050)); 
nowy = mean(y_bymo(1:N_ens,yr2050)); 

scatter(nowx,nowy,100,'x','markeredgecolor','black'); 

end
