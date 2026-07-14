function produce_figs

resp_src='/Users/mbznpb/Analysis/uon/gasdelivery/respdata/';
hcbold_src='/Users/mbznpb/Analysis/uon/gasdelivery/dCVR-data/';
hobold_src='/Users/mbznpb/Analysis/uon/gasdelivery/hmqBOLD-data/';

hypercapnia_start_times=readtable([resp_src 'hypercapnia_start_times.trs'],'FileType','delimitedtext');

for k=1:height(hypercapnia_start_times)
    disp(['Processing ' char(hypercapnia_start_times.subject_id(k))])
    [ethc(:,:,k) fihc(:,:,k)]=process_hypercapniadata(char(hypercapnia_start_times.subject_id(k)),'hypercapnia_start_times.trs',resp_src);
end

% co2 time window
hypercapnia_base(2,:)=squeeze(mean(ethc([17:19 41:43 65:67]-12,3,:),1))';
hypercapnia_stim(2,:)=squeeze(mean(ethc([17:19 41:43 65:67],3,:),1))';
hypercapnia_delta(2,:)=hypercapnia_stim(2,:)-hypercapnia_base(2,:);

% o2 time window - delayed by 30 s wrt co2
hypercapnia_base(1,:)=squeeze(mean(ethc([17:19 41:43 65:67]-12+6,2,:),1))';
hypercapnia_stim(1,:)=squeeze(mean(ethc([17:19 41:43 65:67]+6,2,:),1))';
hypercapnia_delta(1,:)=hypercapnia_stim(1,:)-hypercapnia_base(1,:);

hypercapnia_mean_base=mean(hypercapnia_base,2);
hypercapnia_std_base=std(hypercapnia_base,[],2);
hypercapnia_mean_delta=mean(hypercapnia_delta,2);
hypercapnia_std_delta=std(hypercapnia_delta,[],2);
hypercapnia_mean_pc=mean(hypercapnia_delta./hypercapnia_base.*100,2);
hypercapnia_std_pc=std(hypercapnia_delta./hypercapnia_base.*100,[],2);

for k=1:height(hypercapnia_start_times)
    disp(['Processing BOLD ' char(hypercapnia_start_times.subject_id(k))])
    hcboldSignal(:,k)=process_hypercapniaBOLD(hcbold_src,char(hypercapnia_start_times.subject_id(k)));
end

hcboldTime=(1:300)'.*1.4;
meanhcboldSignal=mean((hcboldSignal./mean(hcboldSignal([57:64 143:150 229:236]-43+25,:),1)-1).*100,2);
stdhcboldSignal=std((hcboldSignal./mean(hcboldSignal([57:64 143:150 229:236]-43+25,:),1)-1).*100,[],2);
hypercapnia_mean_bold=mean(meanhcboldSignal([57:64 143:150 229:236]+25,:),1);
%hypercapnia_mean_bold=mean(hcboldSignal([57:64 143:150 229:236],:),"all")./mean(hcboldSignal([57:64 143:150 229:236]-43,:),"all");
hypercapnia_std_bold=sqrt(sum(stdhcboldSignal([57:64 143:150 229:236]+25,:).^2)./length([57:64 143:150 229:236]));

disp('Hypercapnia Stimulus')

disp(['Group mean PETO2 baseline: ' num2str(round(hypercapnia_mean_base(1),1)) '±' num2str(round(hypercapnia_std_base(1),1)) 'mmHg'])
disp(['Group mean PETCO2 baseline: ' num2str(round(hypercapnia_mean_base(2),1)) '±' num2str(round(hypercapnia_std_base(2),1)) 'mmHg'])

disp(['Group mean PETO2 delta: ' num2str(round(hypercapnia_mean_delta(1),1)) '±' num2str(round(hypercapnia_std_delta(1),1)) 'mmHg'])
disp(['Group mean PETCO2 delta: ' num2str(round(hypercapnia_mean_delta(2),1)) '±' num2str(round(hypercapnia_std_delta(2),1)) 'mmHg'])

disp(['Group mean PETO2 percentage: ' num2str(round(hypercapnia_mean_pc(1),1)) '±' num2str(round(hypercapnia_std_pc(1),1)) '%'])
disp(['Group mean PETCO2 percentage: ' num2str(round(hypercapnia_mean_pc(2),1)) '±' num2str(round(hypercapnia_std_pc(2),1)) '%'])

disp(['Group mean CO2 BOLD percentage: ' num2str(round(hypercapnia_mean_bold,1)) '±' num2str(round(hypercapnia_std_bold,1)) '%'])

disp(' ')

figure;

subplot(311)
errorbar(ethc(:,1,1),mean(ethc(:,3,:),3),std(ethc(:,3,:),[],3)./sqrt(height(hypercapnia_start_times)));
set(gca,'xtick',[0:60:420]);
xlim([0 420])
ylim([30 45])
grid on
xlabel('Time (s)')
ylabel('P_{ET}CO_2 (mmHg)')
ylim([30 45])

subplot(312)
errorbar(ethc(:,1,1),mean(ethc(:,2,:),3),std(ethc(:,2,:),[],3)./sqrt(height(hypercapnia_start_times)));
set(gca,'xtick',[0:60:420]);
xlim([0 420])
ylim([100 140])
grid on
xlabel('Time (s)')
ylabel('P_{ET}O_2 (mmHg)')

subplot(313)
errorbar(hcboldTime,meanhcboldSignal,stdhcboldSignal./sqrt(height(hypercapnia_start_times)));
set(gca,'xtick',[0:60:420]);
xlim([0 420])
ylim([-2 4])
grid on
xlabel('Time (s)')
ylabel('BOLD signal change (%)')

hyperoxia_start_times=readtable([resp_src 'hyperoxia_start_times.trs'],'FileType','delimitedtext');

for k=1:height(hyperoxia_start_times)
    disp(['Processing ' char(hyperoxia_start_times.subject_id(k))])
    [etho(:,:,k) fiho(:,:,k)]=process_hyperoxiadata(char(hyperoxia_start_times.subject_id(k)),'hyperoxia_start_times.trs',resp_src);
end

hyperoxia_base=squeeze(mean(etho(1:18,2:3,:),1)); %0 to 55s
hyperoxia_stim=squeeze(mean(etho([40:52 88:100],2:3,:),1)); %195 to 225s & 435 to 465s
hyperoxia_delta=hyperoxia_stim-hyperoxia_base;

hyperoxia_mean_base=mean(hyperoxia_base,2);
hyperoxia_std_base=std(hyperoxia_base,[],2);
hyperoxia_mean_delta=mean(hyperoxia_delta,2);
hyperoxia_std_delta=std(hyperoxia_delta,[],2);
hyperoxia_mean_pc=mean(hyperoxia_delta./hyperoxia_base.*100,2);
hyperoxia_std_pc=std(hyperoxia_delta./hyperoxia_base.*100,[],2);

for k=1:height(hyperoxia_start_times)
    disp(['Processing BOLD ' char(hyperoxia_start_times.subject_id(k))])
    hoboldSignal(:,k)=process_hyperoxiaBOLD(hobold_src,char(hyperoxia_start_times.subject_id(k)));
end

hoboldTime=(1:200)'.*3;
meanhoboldSignal=mean((hoboldSignal./mean(hoboldSignal([1:18]+12,:),1)-1).*100,2); %baseline 0 to 57s
stdhoboldSignal=std((hoboldSignal./mean(hoboldSignal([1:18]+12,:),1)-1).*100,[],2); %baseline 0 to 57s
hyperoxia_mean_bold=mean(meanhoboldSignal([65:85 145:165]+12,:),1);
%hyperoxia_mean_bold=mean(hoboldSignal([65:85 145:165],:),"all")./mean(hoboldSignal(1:20,:),"all");
hyperoxia_std_bold=sqrt(sum(stdhoboldSignal([65:85 145:165]+12,:).^2)./length([65:85 145:165]));

disp('Hyperoxia Stimulus')

disp(['Group mean PETO2 baseline: ' num2str(round(hyperoxia_mean_base(1),1)) '±' num2str(round(hyperoxia_std_base(1),1)) 'mmHg'])
disp(['Group mean PETCO2 baseline: ' num2str(round(hyperoxia_mean_base(2),1)) '±' num2str(round(hyperoxia_std_base(2),1)) 'mmHg'])

disp(['Group mean PETO2 delta: ' num2str(round(hyperoxia_mean_delta(1),1)) '±' num2str(round(hyperoxia_std_delta(1),1)) 'mmHg'])
disp(['Group mean PETCO2 delta: ' num2str(round(hyperoxia_mean_delta(2),1)) '±' num2str(round(hyperoxia_std_delta(2),1)) 'mmHg'])

disp(['Group mean PETO2 percentage: ' num2str(round(hyperoxia_mean_pc(1),1)) '±' num2str(round(hyperoxia_std_pc(1),1)) '%'])
disp(['Group mean PETCO2 percentage: ' num2str(round(hyperoxia_mean_pc(2),1)) '±' num2str(round(hyperoxia_std_pc(2),1)) '%'])

disp(['Group mean O2 BOLD percentage: ' num2str(round(hyperoxia_mean_bold(1),1)) '±' num2str(round(hyperoxia_std_bold,1)) '%'])

figure;

%convert PETCO2 to % change due to lack of co2 sensor calibration
ethopc=(etho(:,3,:)./etho(1,3,:)-1).*100;

subplot(311)
errorbar(etho(:,1,1),mean(ethopc(:,1,:),3),std(ethopc(:,1,:),[],3)./sqrt(height(hyperoxia_start_times)));
set(gca,'xtick',[0:60:600]);
xlim([0 600])
ylim([-10 10])
grid on
xlabel('Time (s)')
ylabel('\Delta P_{ET}CO_2 (%)')

subplot(312)
errorbar(etho(:,1,1),mean(etho(:,2,:),3),std(etho(:,2,:),[],3)./sqrt(height(hyperoxia_start_times)));
set(gca,'xtick',[0:60:600]);
xlim([0 600])
ylim([100 500])
grid on
xlabel('Time (s)')
ylabel('P_{ET}O_2 (mmHg)')

subplot(313)
errorbar(hoboldTime,meanhoboldSignal,stdhoboldSignal./sqrt(height(hyperoxia_start_times)));
set(gca,'xtick',[0:60:600]);
xlim([0 600])
ylim([-2 4])
grid on
xlabel('Time (s)')
ylabel('BOLD signal change (%)')
