% select one or the other hemis
hem='nh';

% northern hemisphere data
% #vars by # ensemble members by 171 years (1850-2100)
% 1 ensemble member goes from 1850-2100
% 32 go from 1920-2100
% 1 goes from 1996 to 2047 (nhpert)
data = nan(nvars, N_ensemble, 3012); %

data_pert = nan(2,nvars,3012);

% 1700 years of control run
controldata = nan(nvars, 20400);

for n=1:nvars
    % for each variable and for each ensemble member
    for k = 1:N_ensemble
        
        myfilenameA = [foldstr LEstr char(read_variables(n)),'_',hem,'_',part_1900s,sprintf('%03d.txt', k)];
        myfilenameB = [foldstr LEstr char(read_variables(n)),'_',hem,'_',part_RCP8p5,sprintf('%03d.txt', k)];
        
        % 156 years from 1850-2005
        century20 = nan(1872,1);
        % 95 years from 2006-2100
        RCP85 = nan(1140,1);
        
        % NH average daily data for each variable
        % load in historical data
        pastdata  = importdata(myfilenameA);
        % load in RCP8.5 data
        futuredata  = importdata(myfilenameB);
        
        % first member starts at 1850, not 1920
        
        century20(end-length(pastdata)+1:end) = pastdata;
        
        RCP85(1:length(futuredata)) = futuredata;
        
        %%
        
        
        % Concatenate
        data(n,k,:) = [century20; RCP85];
        
        
    end
    
    %% Get first perturbation run
    myfilename_nohalb_A = [foldstr H1str char(read_variables(n)),'_',hem,'_',part_1900s,'015.nohalb.txt'];
    myfilename_nohalb_B = [foldstr H1str char(read_variables(n)),'_',hem,'_',part_RCP8p5,'015.nohalb.txt'];
    
    % Starts at 1996
    pastdata  = importdata(myfilename_nohalb_A);
    % Starts at 2006
    futuredata  = importdata(myfilename_nohalb_B);
    
    % 156 years from 1850-2005
    century20 = nan(1872,1);
    % 95 years from 2006-2100
    RCP85 = nan(1140,1);
    
    century20(end-length(pastdata)+1:end) = pastdata;
    RCP85(1:length(futuredata)) = futuredata;
    
    data_pert(1,n,:) = [century20; RCP85];
    
    
    %% Get second perturbation run
    myfilename_nohalb_A = [foldstr H2str char(read_variables(n)),'_',hem,'_',part_1900s,'015.nohalb2.txt'];
    myfilename_nohalb_B = [foldstr H2str char(read_variables(n)),'_',hem,'_',part_RCP8p5,'015.nohalb2.txt'];
    
    % Starts at 1996
    pastdata  = importdata(myfilename_nohalb_A);
    % Starts at 2006
    futuredata  = importdata(myfilename_nohalb_B);
    
    % 156 years from 1850-2005
    century20 = nan(1872,1);
    % 95 years from 2006-2100
    RCP85 = nan(1140,1);
    
    century20(end-length(pastdata)+1:end) = pastdata;
    RCP85(1:length(futuredata)) = futuredata;
    
    data_pert(2,n,:) = [century20; RCP85];
    
    
    %    Load in data from control run
     myfilenameC = [foldstr CTstr char(read_variables(n)),'_',hem,'_',part_control];
     controldata(n,:)  = importdata(myfilenameC);
    
    
end

data(:,34,:) = squeeze(data_pert(1,:,:));
data(:,35,:) = squeeze(data_pert(2,:,:));

time_axis = 1850:2100;

%% Now do the Southern Hemisphere

% hem='sh';
% shdata = zeros(nvars, N_ensemble, 2052);
% shpidata = zeros(nvars, 20400);
%
% for n=1:nvars
%
%     for k = 1:N_ensemble
%
%         myfilenameA = [ char(read_variables(n)),'_',hem,'_',part_1900s,sprintf('%03d.txt', k)];
%         myfilenameB = [ char(read_variables(n)),'_',hem,'_',part_RCP8p5,sprintf('%03d.txt', k)];
%         tmpA  = importdata(myfilenameA);
%         tmpB  = importdata(myfilenameB);
%
%         if k==1
%             tmpA=tmpA(961:end);
%         else
%             tmpA=tmpA(121:end);
%         end
%
%         shdata(n,k,:) = [tmpA; tmpB];
%
%     end
%
%     % Load in control run files
%     myfilenameC = [ char(read_variables(n)),'_',hem,'_',part_control];
%     shpidata(n,:)  = importdata(myfilenameC);
%
% end

%%
% load in the
% load ../GCM-Files/LE-from-CC/tarea_nh.txt
tarea_nh = 14.06; 

% load GCM-Files/Ensemble-Output/tarea_sh.txt
