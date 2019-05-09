addpath('utils')
addpath('files')

% Nens is the number of ensemble members
N_ensemble=33;

% coalbedo of ice


% variables to read in. These are already here as .txt files
read_variables={'icearea';'icevolume';'Fswabs_ice';'Fsw_ocn';'Fswdn'}
nvars = length(read_variables);

% examples of filenames
%Fsw_ocn_nh_b.e11.B20TRC5CNBDRD.f09_g16.009.txt      icevolume_nh_b.e11.B20TRC5CNBDRD.f09_g16.009.txt

% parA is the 20th century part
part_1900s='b.e11.B20TRC5CNBDRD.f09_g16.';
% part B is the RCP 8p5 scenario, from 2006-2100
part_RCP8p5='b.e11.BRCP85C5CNBDRD.f09_g16.';
% part C is the control run from 1850 onwards
part_control='b.e11.B1850C5CN.f09_g16.005.all.txt';

%%
if ~exist('nhdata')
    
    disp('Loading in the data')
    load_in_data; 
 
end

%% Compute the albedo of the ice-covered ocean in both hemispheres


%% Take Control Run Averages

[CONTROL.NH,coalb_ic_nh] = compute_control_response(nhpidata,tarea_nh); 
[CONTROL.SH,coalb_ic_sh] = compute_control_response(shpidata,tarea_sh); 

%% Compute forced response

FORCED.NH = compute_forced_response(nhdata,tarea_nh,coalb_ic_nh); 
FORCED.SH = compute_forced_response(shdata,tarea_sh,coalb_ic_sh); 

%% Plot the data

%% Data in mons
mons = 6:8; 

figure; 

alb_ic_hist = mean(mean(CONTROL.NH.SI_alb(mons,:)));


%subplot(3,1,1)
% %% Scatter SI area against SW absorption
% plot_forced_CESM_data(FORCED.NH.SI_area,FORCED.NH.SW_ab,N_ensemble,mons)
% 
% plot_control_CESM_data(CONTROL.NH.SI_area,CONTROL.NH.SW_ab,N_ensemble,mons)
% 
% %% Scatter "SI thickness" against SW absorption
% plot_forced_CESM_data(FORCED.NH.SI_vol./FORCED.NH.SI_area,FORCED.NH.SW_ab,N_ensemble,mons)
% 
% plot_control_CESM_data(CONTROL.NH.SI_vol./CONTROL.NH.SI_area,CONTROL.NH.SW_ab,N_ensemble,mons)

% Scatter Albedo against Area

subplot(231)

[~,~] = plot_forced_CESM_data(FORCED.NH.SI_area,FORCED.NH.SI_alb,N_ensemble,mons)

plot_control_CESM_data(CONTROL.NH.SI_area,CONTROL.NH.SI_alb,N_ensemble,mons)

xlabel('Ice Area (million sq km)')
ylabel('Ice Albedo')
xlim([0 max(get(gca,'xlim'))])
xl = get(gca,'xlim');
plot(linspace(xl(1),xl(2),100),alb_ic_hist + 0 * (1:100),'--k')


% Scatter Albedo against Thickness
subplot(232)

[~,~] = plot_forced_CESM_data(FORCED.NH.SI_vol./FORCED.NH.SI_area,FORCED.NH.SI_alb,N_ensemble,mons)

plot_control_CESM_data(CONTROL.NH.SI_vol./CONTROL.NH.SI_area,CONTROL.NH.SI_alb,N_ensemble,mons)

xlabel('Ice Thickness (m)')
xlim([0 max(get(gca,'xlim'))])
xl = get(gca,'xlim');
plot(linspace(xl(1),xl(2),100),alb_ic_hist + 0 * (1:100),'--k')

% Scatter Albedo against Volume

subplot(233)

[~,~] = plot_forced_CESM_data(FORCED.NH.SI_vol,FORCED.NH.SI_alb,N_ensemble,mons)

plot_control_CESM_data(CONTROL.NH.SI_vol,CONTROL.NH.SI_alb,N_ensemble,mons)
xlim([0 max(get(gca,'xlim'))])
xlabel('Sea Ice Volume (thousand cubic km)')
xl = get(gca,'xlim');
plot(linspace(xl(1),xl(2),100),alb_ic_hist + 0 * (1:100),'--k')


%
subplot(234)
[A_clim,Alb_clim_noT] = plot_forced_CESM_data_2(FORCED.NH.SI_area,FORCED.NH.NET_alb_noT,N_ensemble,mons);
hold on
[~,Alb_clim] = plot_forced_CESM_data(FORCED.NH.SI_area,FORCED.NH.NET_alb,N_ensemble,mons);

plot_control_CESM_data(CONTROL.NH.SI_area,CONTROL.NH.NET_alb,N_ensemble,mons)

xlabel('Ice Area (million sq km)')
ylabel('Surface Albedo')
xlim([0 max(get(gca,'xlim'))])


% Scatter Albedo against Thickness
subplot(235)

[H_clim,~] =plot_forced_CESM_data_2(FORCED.NH.SI_vol./FORCED.NH.SI_area,FORCED.NH.NET_alb_noT,N_ensemble,mons);

[~,~] = plot_forced_CESM_data(FORCED.NH.SI_vol./FORCED.NH.SI_area,FORCED.NH.NET_alb,N_ensemble,mons);

plot_control_CESM_data(CONTROL.NH.SI_vol./CONTROL.NH.SI_area,CONTROL.NH.NET_alb,N_ensemble,mons)

xlabel('Ice Thickness (m)')
xlim([0 max(get(gca,'xlim'))])


% Scatter Albedo against Volume
%%
 subplot(236)
% 
% [V_clim,~] = plot_forced_CESM_data_2(FORCED.NH.SI_vol,FORCED.NH.NET_alb_noT,N_ensemble,mons);
% cl
% [~,~] = plot_forced_CESM_data(FORCED.NH.SI_vol,FORCED.NH.NET_alb,N_ensemble,mons);
% 
% plot_control_CESM_data(CONTROL.NH.SI_vol,CONTROL.NH.NET_alb,N_ensemble,mons)



xlim([0 max(get(gca,'xlim'))])

xlabel('Sea Ice Volume (thousand cubic km)')

[H_clim,~] =plot_forced_CESM_data_2(FORCED.NH.SI_vol./FORCED.NH.SI_area,FORCED.NH.T_NET_effect_alb,N_ensemble,mons);

[H_clim,~] =plot_forced_CESM_data(FORCED.NH.SI_vol./FORCED.NH.SI_area,FORCED.NH.T_SI_effect_alb,N_ensemble,mons);

% plot_control_CESM_data(CONTROL.NH.SI_area,CONTROL.NH.SI_alb_noT,N_ensemble,mons)

%%

hold all
letter = {'(f)','(b)','(d)','(c)','(a)','(e)','(d)','(e)','(c)'};

hAllAxes = findobj(gcf,'type','axes');
hLeg = findobj(hAllAxes,'tag','legend');
hAxes = setdiff(hAllAxes,hLeg); % All axes which are not

delete(findall(gcf,'Tag','legtag'))

for i = 1:length(hAxes)
    
    posy = get(hAxes(i),'position');
    annotation('textbox',[posy(1)-.035 posy(2)+posy(4)+.01 .025 .025], ...
        'String',letter{i},'LineStyle','none','FontName','Helvetica', ...
        'FontSize',12,'Tag','legtag');
    
end

pos = [12 8]; 
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');

saveas(gcf,sprintf('Figures/albedo%d.pdf',mons))
