%% Only consider high-latitude points
latbig = lat > 70; 
nind = sum(latbig(:)); 
inder = repmat(latbig,[1 1 sizer(3)]); 


swabs_ic = reshape(swabs_ic_0(inder),nind,12,[]); 
swabs = reshape(swabs_0(inder),nind,12,[]);  
swdn = reshape(swdn_0(inder),nind,12,[]); 
a_ice = reshape(a_ice_0(inder),nind,12,[]); 
h_ice = reshape(h_ice_0(inder),nind,12,[]); 

%%

albedo = 1 - swabs./ (swdn);
alb_ice = 1 - swabs_ic./ (swdn.*a_ice);
albedo(albedo < 0) = 0; 
% h_ice(h_ice > 10) = 0; 

% worldmap([60 90],[0 360])
% pcolorm(lat,lon,h_ice(:,:,9,end));

month = 8;

thick = squeeze(h_ice(:,month,:)); 
area = squeeze(a_ice(:,month,:)); 
alb = squeeze(albedo(:,month,:)); 

nints = 25; 

thick_int = linspace(0,5,26);
a_int = linspace(0,1,nints); 

[cts,ind_h] = histc(thick(:),thick_int); 
[cts,ind_a] = histc(area(:),a_int); 


for i = 1:length(thick_int)
    
    
    dum = alb(ind_h == i); 
    
    alb_mean_h(i) = mean(dum); 
    
    dum = alb(ind_a == i); 
    alb_mean_a(i) = mean(dum); 
    
end

%%

months = 6:9;
years = 1

thick = squeeze(h_ice(:,:,months,years)); 
area = squeeze(a_ice(:,:,months,years)); 
alb = squeeze(albedo(:,:,months,years)); 
% subplot(211)
% 
% scatter(thick(:),alb(:),0.25,'k')
% 
% hold on
% plot(thick_int,alb_mean_h,'r')
% 
% subplot(212)
% 
% scatter(area(:),alb(:),0.25,'k')
% 
% hold on
% plot(a_int,alb_mean_a,'r')


%% Try to capture degree to which changes in volume lead to changes in albedo




%% Now we want gridded albedo, lets see which is more relevant. 


[grid_h,grid_c,gridded_albedo] = make_grid_pcolor(thick(~isnan(alb)),area(~isnan(alb)),alb(~isnan(alb)),.2,.05);
% gridded_albedo(isnan(gridded_albedo)) = min(gridded_albedo(:)); 
vec_h = grid_h(1,:); 
vec_c = grid_c(:,1); 


%%
smoothed_alb = gridded_albedo; 
% smoothed_alb = smooth2a(gridded_albedo,1,1); %,20,20);

[dadh,dadc] = gradient(smoothed_alb,vec_h,vec_c); 


dadv_c = dadc ./ grid_h; 
% dadv_c(dadv_c <= 0) = eps; 

dadv_h = dadh ./ grid_c; 
% dadv_h(dadv_h<= 0) = eps; 
%%
cmap2 = [247,251,255
222,235,247
198,219,239
158,202,225
107,174,214
66,146,198
33,113,181
8,81,156
8,48,107]/256; 

subplot(221)
pcolor(grid_h,grid_c,smoothed_alb)
shading interp
set(gca,'clim',[0.5 0.85]) 


subplot(222)
pcolor(grid_h,grid_c,dadv_c); 
shading interp

subplot(223)
pcolor(grid_h,grid_c,dadv_h); 
shading interp


subplot(224)

rat = dadv_h./dadv_c;
% rat(dadv_c == 0 ) = 0; 
pcolor(grid_h,grid_c,(rat)); 
% set(gca,'clim',[0 10]); 
shading interp
ylim([min(vec_c) max(vec_c)])
xlim([min(vec_h) max(vec_h)])

colormap(flipud(cmap2)); 

%%
titles = {'Albedo', ...
    '$\left(\partial \alpha / \partial V\right)_{c}$', ...
    '$\left(\partial \alpha / \partial V\right)_{h}$', ...
    '$S_c/S_h$'}; 

for i = 1:4
    
    subplot(2,2,i) 
    grid on
    box on
    shading interp
    xlabel('Ice Thickness')
    ylabel('Concentration')
    set(gca,'fontname','helvetica','fontsize',12,'xminortick','on','yminortick','on')
   %  set(gca,'color',cmap2(1,:));
   
    colorbar
    title(titles{i},'interpreter','latex','fontsize',12);
   % add_bg_hatch;

end
