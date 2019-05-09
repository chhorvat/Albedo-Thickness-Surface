make_fig_5; 
scatt; 
%%
CHH_alb_ens = mean(FORCED.NH.SI_alb,1); 
CHH_alb_ens_july = CHH_alb_ens(mons:12:end);

CHH_alb_noT = NOALB.SI_alb;
CHH_alb_15 = FORCED.NH.SI_alb(15,:); 

CHH_alb_noT_july = CHH_alb_noT(mons:12:end); 
CHH_alb_15_july = CHH_alb_15(mons:12:end); 
CHH_length_noT = length(CHH_alb_noT_july); 

% clearvars -except CHH*

%%

%%
CMB_alb_ens = mean(icealbedo,1); 
CMB_alb_ens_july = CMB_alb_ens(mons:12:end); 

CMB_alb_noT = icealbedo_exp;
CMB_alb_15 =  icealbedo(15,:);

CMB_alb_noT_july = CMB_alb_noT(mons:12:end); 
CMB_alb_15_july = CMB_alb_15(mons:12:end); 
CMB_length_noT = length(CMB_alb_noT_july); 



close all
%% Plot Chris' Data
subplot(121); cla

t_0 = 1930:2100; 
t_1 = 1997:1997+CHH_length_noT-1; 
plot(t_0,CHH_alb_ens_july);
hold on
plot(t_0,CHH_alb_15_july); 
plot(t_1,CHH_alb_noT_july); 
xlim([1970 2050]) 
ylim([.3 .75]);
grid on; box on;
title('Chris')
legend('Ensemble','No 15','Exp')

%% Plot CC's Data
subplot(122); cla; 
t_0 = 1930:2100; 
t_1 = 1997:1997+CMB_length_noT-1; 
plot(t_0,CMB_alb_ens_july);
hold on
plot(t_0,CMB_alb_15_july); 
plot(t_1,CMB_alb_noT_july); 
xlim([1970 2050]) 
ylim([.3 .75]);
grid on; box on;
title('CC')
legend('Ensemble','No 15','Exp')
%%
subplot(121)


subplot(122)



%%
y = detrend(CHH_alb_ens_july);

plot(CHH_alb_ens_july - y);
trendline = CHH_alb_ens_july - detrend(CHH_alb_ens_july);
A = CHH_alb_noT(mons,:);
B = CHH_alb_15(mons,:);
ttest2(A,B)
ttest2(A-trendline,B-trendline)

plot(A)
hold on
plot(B)
plot(A-trendline)
plot(B-trendline)
grid on
box on
xlabel('Years')
ylabel('SI Albedo')
legend('noT','LE15','noT-trend','LE15-trend')
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');
set(gcf,'windowstyle','normal','position',[0 0 pos],'paperposition',[0 0 pos],'papersize',pos,'units','inches','paperunits','inches');
save('comp_trends.pdf')
saveas(gcf,'comp_trends.pdf')