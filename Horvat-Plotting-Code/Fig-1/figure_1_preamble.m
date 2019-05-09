%% Load in climate variables
clear

%addpath('../GCM-Files/Snapshot-Files/nh')
%addpath('../utils/')

a_ice = .01*ncread('../GCM-Files/Snapshot-Files/nh/b.e11.B1850C5CN.f09_g16.005.cice.h.aice_nh.210001-220012.nc','aice');
swdn = ncread('../GCM-Files/Snapshot-Files/nh/b.e11.B1850C5CN.f09_g16.005.cice.h.fswdn_nh.210001-220012.nc','fswdn');
swabs_ic = ncread('../GCM-Files/Snapshot-Files/nh/b.e11.B1850C5CN.f09_g16.005.cice.h.fswabs_ai_nh.210001-220012.nc','fswabs_ai');
h_ice = ncread('../GCM-Files/Snapshot-Files/nh/b.e11.B1850C5CN.f09_g16.005.cice.h.hi_nh.210001-220012.nc','hi');
swabs = ncread('../GCM-Files/Snapshot-Files/nh/b.e11.B1850C5CN.f09_g16.005.cice.h.fswabs_nh.210001-220012.nc','fswabs');
a_snow = ncread('../GCM-Files/Snapshot-Files/nh/b.e11.B1850C5CN.f09_g16.005.cice.h.fs_nh.210001-220012.nc','fs');

albedo = 1 - swabs./ (swdn);
albedo(swdn==0) = 0;
albedo(albedo < 0) = 0; 
albedo(albedo > 1) = 0; 

alb_ice = 1 - swabs_ic./ (swdn.*a_ice);

alb_ice(swdn==0) = 0;

% albedo = a_ice.*alb_ice + (1-a_ice).*(.06); 

V_ice = a_ice .* h_ice;

% for i = 1:5
%     
%     instr = sprintf('apond00%d',i); 
%     
%     apondn{i} = ncread(['b.e11.B1850C5CN.f09_g16.005.cice.h.' instr '_nh.210001-220012.nc'],instr); 
%     
%     instr = sprintf('aice00%d',i); 
%     
%     aicen{i} = ncread(['b.e11.B1850C5CN.f09_g16.005.cice.h.' instr '_nh.210001-220012.nc'],instr);
%     
%     a_pond = a_pond + apondn{i}.*aicen{i};
%     
% end
% 
% a_pond = a_pond ./ a_ice; 


%%

lat = ncread('../GCM-Files/Snapshot-Files/nh/b.e11.B1850C5CN.f09_g16.005.cice.h.aice_nh.210001-220012.nc','TLAT');
lon = ncread('../GCM-Files/Snapshot-Files/nh/b.e11.B1850C5CN.f09_g16.005.cice.h.aice_nh.210001-220012.nc','TLON');

sizer = size(swabs);

%% Only consider high-latitude points
latbig = lat > 66;
nind = sum(latbig(:));
inder = repmat(latbig,[1 1 sizer(3)]);


V_ice = reshape(V_ice(inder),nind,12,[]); 
alb_ice = reshape(alb_ice(inder),nind,12,[]); 
albedo = reshape(albedo(inder),nind,12,[]); 

swabs_ic = reshape(swabs_ic(inder),nind,12,[]);
swabs = reshape(swabs(inder),nind,12,[]);
swdn = reshape(swdn(inder),nind,12,[]);
a_ice = reshape(a_ice(inder),nind,12,[]);
a_snow = reshape(a_snow(inder),nind,12,[]);
h_ice = reshape(h_ice(inder),nind,12,[]);
h_ice(h_ice > 10) = 0;

cmap2 = [103,0,31
    178,24,43
    214,96,77
    244,165,130
    253,219,199
    256,256,256
    209,229,240
    146,197,222
    67,147,195
    33,102,172
    5,48,97]/256;

cmapnoblue = flipud([256 256 256
    255,245,240
    254,224,210
    252,187,161
    252,146,114
    251,106,74
    239,59,44
    203,24,29
    165,15,21
    103,0,13]/256);


%%
