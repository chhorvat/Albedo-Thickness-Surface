addpath('/Users/Horvat/Dropbox (Brown)/Research Projects/Active/Albedo-Thickness-Variability/Scripts/');
addpath('/Users/Horvat/Dropbox (Brown)/Research Projects/Active/Albedo-Thickness-Variability/Scripts/Utils/');

% I downloaded
%addpath('/Users/Horvat/Dropbox/Research Projects/Active/Albedo-Thickness-Variability/Scripts/GCM-Files/Ensemble-Output/');
% CC downloaded
% addpath('/Users/Horvat/Dropbox/Research Projects/Active/Albedo-Thickness-Variability/Scripts/GCM-Files/LE-from-CC/');


%%
% Nens is the number of ensemble members
N_ensemble=33;

% variables to read in. These are available as .txt files
read_variables={'icearea','icevolume','Fswabs_ai','Fsw_open','Fswdn','pondarea','snowarea','falbice','falbsno','falbpnd'}; 
havecontrol = [1 1 1 1 1 0 0 0 0 0]; 
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
    foldstr = '../GCM-Files/LE-From-CC/'; 
    foldstr_pert = '../GCM-Files/nohalb2/';
    disp('Loading in the data')
    load_in_data; 
 
end

%%

SI_C = reshape(data(1,:,:,:),35,12,[])/tarea_nh; 
SI_V = reshape(data(2,:,:,:),35,12,[]); 
SI_H = SI_V ./ reshape(data(1,:,:,:),35,12,[]); 

Pond_C = reshape(data(6,:,:,:),35,12,[])/tarea_nh; 
Snow_C = reshape(data(7,:,:,:),35,12,[])/tarea_nh;
Bare_C = SI_C - Pond_C - Snow_C; 
% Bare_C(Bare_C < 0) = 0; 

SW_open = 0.96*reshape(data(4,:,:,:),35,12,[])/tarea_nh; 
SW_ic = reshape(data(3,:,:,:),35,12,[])/tarea_nh; 
SW_dn = reshape(data(5,:,:,:),35,12,[])/tarea_nh; 

Albedo = 1 - (SW_ic + SW_open)./SW_dn; 


Albedo_O = (Albedo - (SI_C - SW_ic./SW_dn))./(1 - SI_C); 
Albedo_S = reshape(data(9,:,:,:),35,12,[])./(tarea_nh*Snow_C);
Albedo_P = reshape(data(10,:,:,:),35,12,[])./(tarea_nh*Pond_C);

Albedo_B = (Albedo - (1-SI_C).*Albedo_O - Snow_C.*Albedo_S - Pond_C.*Albedo_P)./(SI_C - Pond_C - Snow_C); 

Albedo_B2 = reshape(data(8,:,:,:),35,12,[])./(tarea_nh*(Bare_C));

Albedo_I = 1 - SW_ic./(SI_C.*SW_dn); 


