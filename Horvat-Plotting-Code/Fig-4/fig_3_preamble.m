addpath('/Users/Horvat/Dropbox/Research Projects/Active/Albedo-Thickness-Variability/Scripts/');
addpath('/Users/Horvat/Dropbox/Research Projects/Active/Albedo-Thickness-Variability/Scripts/Utils/');

%%
% variables to read in. These are available as .txt files
read_variables={'icearea';'icevolume';'Fswabs_ai';'Fsw_open';'Fswdn'}
nvars = length(read_variables);

% examples of filenames
%Fsw_ocn_nh_b.e11.B20TRC5CNBDRD.f09_g16.009.txt      icevolume_nh_b.e11.B20TRC5CNBDRD.f09_g16.009.txt


%% Import the data
fname_spinup = '_nh_b.e11.B20TRC5CNBDRD.f09_g16.015.txt';
fname_run = '_nh_b.e11.BRCP85C5CNBDRD.f09_g16.015.txt';

foldname = '../GCM-Files/Alb-Runs-Output/';

for n=1:nvars
    
    myfilenameA = [foldname read_variables{n} fname_spinup];
    myfilenameB = [foldname read_variables{n} fname_run];
    
    % NH average daily data for each variable
    % load in historical data
    tmpA  = importdata(myfilenameA);
    % tmpA = tmpA(37:end); 
    
    
    % load in RCP8.5 data
    tmpB  = importdata(myfilenameB);
    extra = mod(length(tmpB),12); 
    tmpB = tmpB(1:length(tmpB)-extra); 
    
    data(n,1,:) = [tmpA; tmpB];
    
end


coalb_ic_nh = [0.2255
    0.1923
    0.1812
    0.1824
    0.1939
    0.2448
    0.3445
    0.3124
    0.2022
    0.1894
    0.2473
    0.3283]; 

spinL = length(tmpA);
forcedL = length(tmpB);

load ../GCM-Files/Ensemble-Output/tarea_nh.txt
load ../GCM-Files/Ensemble-Output/tarea_sh.txt

NOALB = compute_forced_response(data,tarea_nh,coalb_ic_nh); 

timer{1} = 2006 - spinL/12:1/12:2006+(forcedL-1)/12;
timer{2} = 1920:1/12:2100-1/12;



