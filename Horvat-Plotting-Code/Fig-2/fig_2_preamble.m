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
read_variables={'icearea';'icevolume';'Fswabs_ai';'Fsw_open';'Fswdn';'pondarea';'snowarea';'falbsno';'falbice';'falbpnd'}; 

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
foldstr = '../GCM-Files/cleaned/'; 

LEstr = 'LE-corr/';
H1str = 'nohalb/';
H2str = 'nohalb2/';
CTstr = 'PIcntl-corr/';

% foldstr_p1 = 'nohalb'; 
% foldstr_p2 = 'nohalb2';
    disp('Loading in the data')
    load_in_data; 

    
tarea_nh = 12.96062;
% tarea_nh = 14.06; 
% tarea_nh = 58.4383;

%% Take Control Run Averages



[CONTROL.NH,coalb_ic_nh] = compute_control_response(controldata,tarea_nh); 
% [CONTROL.SH,coalb_ic_sh] = compute_control_response(shpidata,tarea_sh); 

%% Compute forced response

FORCED.NH = compute_forced_response(data,tarea_nh,coalb_ic_nh); 
% FORCED.SH = compute_forced_response(shdata,tarea_sh,coalb_ic_sh); 

data_pert = reshape(data_pert,2,nvars,12,[]); 

