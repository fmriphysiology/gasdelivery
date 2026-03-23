%function produce_figs

hypercapnia_start_times=readtable('hypercapnia_start_times.trs','FileType','delimitedtext');

for k=1:height(hypercapnia_start_times)
    disp(['Processing ' char(hypercapnia_start_times.subject_id(k))])
    [ethc(:,:,k) fihc(:,:,k)]=process_hypercapniadata(char(hypercapnia_start_times.subject_id(k)),'hypercapnia_start_times.trs');
end

hypercapnia_base=squeeze(mean(ethc([17:19 41:43 65:67]-12,2:3,:),1));
hypercapnia_stim=squeeze(mean(ethc([17:19 41:43 65:67],2:3,:),1));
hypercapnia_delta=hypercapnia_stim-hypercapnia_base;

hypercapnia_mean_base=mean(hypercapnia_base,2);
hypercapnia_std_base=std(hypercapnia_base,[],2);
hypercapnia_mean_delta=mean(hypercapnia_delta,2);
hypercapnia_std_delta=std(hypercapnia_delta,[],2);
hypercapnia_mean_pc=mean(hypercapnia_delta./hypercapnia_base.*100,2);
hypercapnia_std_pc=std(hypercapnia_delta./hypercapnia_base.*100,[],2);

disp('Hypercapnia Stimulus')

disp(['Group mean PETO2 baseline: ' num2str(round(hypercapnia_mean_base(1),1)) '±' num2str(round(hypercapnia_std_base(1),1)) 'mmHg'])
disp(['Group mean PETCO2 baseline: ' num2str(round(hypercapnia_mean_base(2),1)) '±' num2str(round(hypercapnia_std_base(2),1)) 'mmHg'])

disp(['Group mean PETO2 delta: ' num2str(round(hypercapnia_mean_delta(1),1)) '±' num2str(round(hypercapnia_std_delta(1),1)) 'mmHg'])
disp(['Group mean PETCO2 delta: ' num2str(round(hypercapnia_mean_delta(2),1)) '±' num2str(round(hypercapnia_std_delta(2),1)) 'mmHg'])

disp(['Group mean PETO2 percentage: ' num2str(round(hypercapnia_mean_pc(1),1)) '±' num2str(round(hypercapnia_std_pc(1),1)) '%'])
disp(['Group mean PETCO2 percentage: ' num2str(round(hypercapnia_mean_pc(2),1)) '±' num2str(round(hypercapnia_std_pc(2),1)) '%'])

disp(' ')

figure;

subplot(211)
errorbar(ethc(:,1,1),mean(ethc(:,3,:),3),std(ethc(:,3,:),[],3)./sqrt(height(hypercapnia_start_times)));
set(gca,'xtick',[0:60:420]);
xlim([0 420])
ylim([30 45])
grid on
xlabel('Time (s)')
ylabel('P_{ET}CO_2 (mmHg)')
ylim([30 45])

subplot(212)
errorbar(ethc(:,1,1),mean(ethc(:,2,:),3),std(ethc(:,2,:),[],3)./sqrt(height(hypercapnia_start_times)));
set(gca,'xtick',[0:60:420]);
xlim([0 420])
ylim([100 500])
grid on
xlabel('Time (s)')
ylabel('P_{ET}O_2 (mmHg)')


hyperoxia_start_times=readtable('hyperoxia_start_times.trs','FileType','delimitedtext');

for k=1:height(hyperoxia_start_times)
    disp(['Processing ' char(hyperoxia_start_times.subject_id(k))])
    [etho(:,:,k) fiho(:,:,k)]=process_hyperoxiadata(char(hyperoxia_start_times.subject_id(k)),'hyperoxia_start_times.trs');
end

hyperoxia_base=squeeze(mean(etho(1:12,2:3,:),1));
hyperoxia_stim=squeeze(mean(etho([40:46 88:94],2:3,:),1));
hyperoxia_delta=hyperoxia_stim-hyperoxia_base;

hyperoxia_mean_base=mean(hyperoxia_base,2);
hyperoxia_std_base=std(hyperoxia_base,[],2);
hyperoxia_mean_delta=mean(hyperoxia_delta,2);
hyperoxia_std_delta=std(hyperoxia_delta,[],2);
hyperoxia_mean_pc=mean(hyperoxia_delta./hyperoxia_base.*100,2);
hyperoxia_std_pc=std(hyperoxia_delta./hyperoxia_base.*100,[],2);

disp('Hyperoxia Stimulus')

disp(['Group mean PETO2 baseline: ' num2str(round(hyperoxia_mean_base(1),1)) '±' num2str(round(hyperoxia_std_base(1),1)) 'mmHg'])
disp(['Group mean PETCO2 baseline: ' num2str(round(hyperoxia_mean_base(2),1)) '±' num2str(round(hyperoxia_std_base(2),1)) 'mmHg'])

disp(['Group mean PETO2 delta: ' num2str(round(hyperoxia_mean_delta(1),1)) '±' num2str(round(hyperoxia_std_delta(1),1)) 'mmHg'])
disp(['Group mean PETCO2 delta: ' num2str(round(hyperoxia_mean_delta(2),1)) '±' num2str(round(hyperoxia_std_delta(2),1)) 'mmHg'])

disp(['Group mean PETO2 percentage: ' num2str(round(hyperoxia_mean_pc(1),1)) '±' num2str(round(hyperoxia_std_pc(1),1)) '%'])
disp(['Group mean PETCO2 percentage: ' num2str(round(hyperoxia_mean_pc(2),1)) '±' num2str(round(hyperoxia_std_pc(2),1)) '%'])

figure;

subplot(211)
errorbar(etho(:,1,1),mean(etho(:,3,:),3),std(etho(:,3,:),[],3)./sqrt(height(hyperoxia_start_times)));
set(gca,'xtick',[0:60:600]);
xlim([0 600])
ylim([50 65])
grid on
xlabel('Time (s)')
ylabel('P_{ET}CO_2 (mmHg)')

subplot(212)
errorbar(etho(:,1,1),mean(etho(:,2,:),3),std(etho(:,2,:),[],3)./sqrt(height(hyperoxia_start_times)));
set(gca,'xtick',[0:60:600]);
xlim([0 600])
ylim([100 500])
grid on
xlabel('Time (s)')
ylabel('P_{ET}O_2 (mmHg)')
