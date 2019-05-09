%% Interpolate the data correctly. 

% for i = 5:8
%     %%
%     if i ~=1
%         m2 = i;
%         m1 = i-1;
%     else
%         m2 = i;
%         m1 = 12;
%     end
%     
%     sizer = size(a_ice);
%     
%     
%     yrs = 1:100;
%     
%     dA = squeeze(a_ice(:,m2,yrs) - a_ice(:,m1,yrs));
%     dH = squeeze(h_ice(:,m2,yrs) - h_ice(:,m1,yrs));
%     % dV = squeeze(V_ice(:,m2,yrs) - V_ice(:,m1,yrs));
%     dalb = squeeze(albedo(:,m2,yrs) - albedo(:,m1,yrs));
%     dsno = squeeze(a_snow(:,m2,yrs) - a_snow(:,m1,yrs)); 
%     % lossV = dV < 0;
%     
%     % dendH = squeeze(h_ice(:,m1,yrs));
%     % reldH = dH ./ (dendH);
%     % reldH(reldH > 1000) = nan;
%     % dalb(isnan(reldH)) = nan;
%     
%     meanA = .5*squeeze(a_ice(:,m1,yrs) + a_ice(:,m2,yrs));
%     meanH = .5*squeeze(h_ice(:,m1,yrs) + h_ice(:,m2,yrs));
%     
%     
%     
%     propdH = meanA .* dH;
%     propdH(abs(propdH) > 3) = nan;
%     propdA = meanH .* dA;
%     propdA(abs(propdA) > 3) = nan;
%     
%     dalb(isnan(propdH(:)) | isnan(propdA(:)) | isnan(dsno(:))) = nan;
%     %dsnow(isnan(propdH(:)) | isnan(propdA(:))) = nan;
% 
%     
%     % dendA = squeeze(a_ice(:,m1,yrs));
%     % reldA = dA./dendA ;
%     % reldA(reldA > 1000) = nan;
%     % dalb(isnan(reldA)) = nan;
%     
%     
%     % [dV,~] = gradient(reshape(V_ice,[sizer(1) sizer(2)*sizer(3)]),1,1);
%     % [dH,~] = gradient(reshape(h_ice,[sizer(1) sizer(2)*sizer(3)]),1,1);
%     % [dA,~] = gradient(reshape(a_ice,[sizer(1) sizer(2)*sizer(3)]),1,1);
%     % [dalb,~] = gradient(reshape(albedo,[sizer(1) sizer(2)*sizer(3)]),1,1);
% %%    
%     % [grid_A{i},grid_H{i},gridded_dalb{i}] = make_grid_pcolor(dA(~isnan(dalb)),dH(~isnan(dalb)),dalb(~isnan(dalb)),.05,.1);
%     [grid_A{i},grid_H{i},gridded_dalb_AH{i},N_each{i,1}] = make_grid_pcolor(propdA(~isnan(dalb)),propdH(~isnan(dalb)),dalb(~isnan(dalb)),.1,.1);
%     disp('AH')
%     [~,grid_S{i,1},gridded_dalb_AS{i},N_each{i,2}] = make_grid_pcolor(propdA(~isnan(dalb)),dsno(~isnan(dalb)),dalb(~isnan(dalb)),.1,.1);
%     disp('AS')
%     [grid_H{i},grid_S{i,2},gridded_dalb_HS{i},N_each{i,3}] = make_grid_pcolor(propdH(~isnan(dalb)),dsno(~isnan(dalb)),dalb(~isnan(dalb)),.1,.1);
%     disp('HS')
%     % now make a histogram to contour the number of counts within each
%     % grid;
%     X = [propdA(~isnan(dalb)) propdH(~isnan(dalb))];
%     ctrs = {grid_A{i},grid_H{i}};
%     gridded_dalb_AH{i}(N_each{i,1}==0) = nan;
%     gridded_dalb_AS{i}(N_each{i,2}==0) = nan;
%     gridded_dalb_HS{i}(N_each{i,3}==0) = nan;
%     
% end


%% Do the aggregate

%% Now add the aggregate info

yrs = 1:100; 

m2 = 6:7;
m1 = 5:6;

dA = squeeze(a_ice(:,m2,yrs) - a_ice(:,m1,yrs));
dH = squeeze(h_ice(:,m2,yrs) - h_ice(:,m1,yrs));
dsno = squeeze(a_snow(:,m2,yrs) - a_snow(:,m1,yrs));
dalb = squeeze(albedo(:,m2,yrs) - albedo(:,m1,yrs));
% dalb = squeeze(alb_ice(:,m2,yrs) - alb_ice(:,m1,yrs));

meanA = .5*squeeze(a_ice(:,m2,yrs) + a_ice(:,m1,yrs));
meanH = .5*squeeze(h_ice(:,m2,yrs) + h_ice(:,m1,yrs));

propdH = meanA .* dH;
propdH(abs(propdH) > 3) = nan;
propdA = meanH .* dA;
propdA(abs(propdA) > 3) = nan;

dalb(isnan(propdH(:)) | isnan(propdA(:))) = nan;
dalb(isinf(dalb)) = nan; 
%%
[g_A,g_H,g_dalpha,N_e] = make_grid_pcolor(propdA(~isnan(dalb)),propdH(~isnan(dalb)),dalb(~isnan(dalb)),.1,.1);
% [g_A,g_S,g_dalpha_AS,N_e_AS] = make_grid_pcolor(propdA(~isnan(dalb)),dsno(~isnan(dalb)),dalb(~isnan(dalb)),.05,.05);
% [g_H,g_S,g_dalpha_HS,N_e_HS] = make_grid_pcolor(propdH(~isnan(dalb)),dsno(~isnan(dalb)),dalb(~isnan(dalb)),.05,.05);

%%

N_e(N_e < 1) = nan;
g_dalpha(isnan(N_e)) = nan;

g_dalpha = smooth2a(g_dalpha,2,2);

