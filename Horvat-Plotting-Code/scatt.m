addpath('/Users/Horvat/Dropbox/Research Projects/Active/Albedo-Thickness-Variability/Scripts/GCM-Files/LE-from-CC/');

% examples of filenames
%Fsw_ocn_nh_b.e11.B20TRC5CNBDRD.f09_g16.009.txt      icevolume_nh_b.e11.B20TRC5CNBDRD.f09_g16.009.txt

partA='b.e11.B20TRC5CNBDRD.f09_g16.';
partB='b.e11.BRCP85C5CNBDRD.f09_g16.';

if ~exist('icearea_exp')
    
    var={'icearea';'icevolume';'Fswabs_ai';'Fswthru_ai';'Fsw_open';'Fswdn';'Fswabs_icenowtg';'SHF_QSW'}
    hem='nh'; k=15;
    for n=1:8
        myfilenameA = [char(var(n)),'_',hem,'_',partA,sprintf('%03d.txt', k)];
        myfilenameB = [char(var(n)),'_',hem,'_',partB,sprintf('%03d.txt', k)];
        tmpA  = importdata(myfilenameA);
        tmpB  = importdata(myfilenameB);
        tmp = [tmpA; tmpB];
        eval([char(var(n)),'_exp=tmp;'])
    end
    
    Fswabs_open_exp=Fsw_open_exp*0.95;
    
    Nens=33;
    partC='b.e11.B1850C5CN.f09_g16.005.all.txt';
    
    for n=1:8
        nhdata = zeros( 5, Nens, 2052); % cut off 10 yrs so 1930-2100
        nhpidata = zeros( 5, 20400);
        eval([char(var(n)),'=zeros(Nens,2052);'])
        eval([char(var(n)),'_pi=zeros(20400,1);'])
        for k = 1:Nens
            myfilenameA = [char(var(n)),'_',hem,'_',partA,sprintf('%03d.txt', k)];
            myfilenameB = [char(var(n)),'_',hem,'_',partB,sprintf('%03d.txt', k)];
            tmpA  = importdata(myfilenameA);
            tmpB  = importdata(myfilenameB);
            if k==1, tmpA=tmpA(961:end); else tmpA=tmpA(121:end); end
            tmp = [tmpA; tmpB];
            eval([char(var(n)),'(k,:)=tmp;'])
        end
        myfilenameC = [char(var(n)),'_',hem,'_',partC];
        tmpPI  = importdata(myfilenameC);
        eval([char(var(n)),'_pi=tmpPI;'])
    end
    Fswabs_open_pi=Fsw_open_pi*0.95;
    Fswabs_open=Fsw_open*0.95;
    
    load tarea_nh.txt
    
    %reflected=albedo*down
    %absorbed=down-reflected=down*(1-albedo)
    %albedo=1-absorbed/down
    
    thickness=icevolume./icearea;
    thickness_exp=icevolume_exp./icearea_exp;
    thickness_pi=icevolume_pi./icearea_pi;
    icealbedo=1-Fswabs_icenowtg./Fswdn; % technically correct but bad cuz
    % has crazy values near he ice edge avg
    % in and also does not weigh by ice area
    % so those edge points count equally
    icealbedo_exp=1-Fswabs_icenowtg_exp./Fswdn_exp;
    icealbedo_pi=1-Fswabs_icenowtg_pi./Fswdn_pi;
    surfalbedo=1-(Fswabs_ai+SHF_QSW-Fswthru_ai)./Fswdn;
    surfalbedo_exp=1-(Fswabs_ai_exp+SHF_QSW_exp-Fswthru_ai_exp)./Fswdn_exp;
    surfalbedo_pi=1-(Fswabs_ai_pi+SHF_QSW_pi-Fswthru_ai_pi)./Fswdn_pi;
    
    
    % this seems to be what Chris did and then plotted June but called it July
    icefrac=icearea/tarea_nh;
    icefrac_exp=icearea_exp/tarea_nh;
    icefrac_pi=icearea_pi/tarea_nh;
    icealbedo=1-Fswabs_ai./Fswdn./icefrac;
    icealbedo_exp=1-Fswabs_ai_exp./Fswdn_exp./icefrac_exp;
    icealbedo_pi=1-Fswabs_ai_pi./Fswdn_pi./icefrac_pi;
    
    % definitely not
    %icevolume=icevolume/tarea_nh;
    %icevolume_exp=icevolume_exp/tarea_nh;
    %icevolume_pi=icevolume_pi/tarea_nh;
    
    
    %ens mean these
    var ={'icearea';'icevolume';'thickness';'icealbedo';'surfalbedo'}
    for n=1:5
        eval([char(var(n)),'_ens=squeeze(mean(',char(var(n)),'));']);
    end
    
    yrs_exp=1997+(0:467)/12;
    yrs_ens=1930+(0:2051)/12;
    
end


figure(2); mons=7; clf

subplot(131); plot(squeeze(icearea(:,mons:12:end)),...
    squeeze(icealbedo(:,mons:12:end)),...
    'r.'); xlabel('area');
hold
plot(icearea_ens(mons:12:end),icealbedo_ens(mons:12:end),'.','color',[.6 0 0])
plot(icearea_exp(mons:12:end),icealbedo_exp(mons:12:end),'g.')
plot(icearea_pi(mons:12:end),icealbedo_pi(mons:12:end),'k.')
hold
ylabel('ice albedo'), xlabel('ice area');
axis([0 11.75 0.43 0.8])

subplot(132); plot(squeeze(icearea(:,mons:12:end)),...
    squeeze(surfalbedo(:,mons:12:end)),...
    'r.'); xlabel('area');
hold
plot(icearea_ens(mons:12:end),surfalbedo_ens(mons:12:end),'.','color',[.6 0 0])
plot(icearea_exp(mons:12:end),surfalbedo_exp(mons:12:end),'g.')
plot(icearea_pi(mons:12:end),surfalbedo_pi(mons:12:end),'k.')
hold
ylabel('surface albedo'), xlabel('ice area');
axis([0 11.75 0.06 0.23])


subplot(133); plot(squeeze(icevolume(:,mons:12:end)),...
    squeeze(icealbedo(:,mons:12:end)),...
    'r.'); xlabel('area');
hold
plot(icevolume_ens(mons:12:end),icealbedo_ens(mons:12:end),'.','color',[.6 0 0])
plot(icevolume_exp(mons:12:end),icealbedo_exp(mons:12:end),'g.')
plot(icevolume_pi(mons:12:end),icealbedo_pi(mons:12:end),'k.')
hold
ylabel('ice albedo'), xlabel('ice volume');

subplot(133); plot(squeeze(thickness(:,mons:12:end)),...
    squeeze(icealbedo(:,mons:12:end)),...
    'r.'); xlabel('area');
hold
plot(thickness_ens(mons:12:end),icealbedo_ens(mons:12:end),'.','color',[.6 0 0])
plot(thickness_exp(mons:12:end),icealbedo_exp(mons:12:end),'g.')
plot(thickness_pi(mons:12:end),icealbedo_pi(mons:12:end),'k.')
hold
ylabel('ice albedo'), xlabel('ice thickness');
axis([0 4.4 0.43 0.8])




