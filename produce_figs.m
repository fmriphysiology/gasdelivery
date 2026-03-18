%function produce_figs

hypercapnia_start_times=readtable('hypercapnia_start_times.trs','FileType','delimitedtext');

for k=1:height(hypercapnia_start_times)
    disp(['Processing ' char(hypercapnia_start_times.subject_id(k))])
    [ethc(:,:,k) fihc(:,:,k)]=process_hypercapniadata(char(hypercapnia_start_times.subject_id(k)),'hypercapnia_start_times.trs');
end

hypercapnia_base=squeeze(mean(ethc([17:19 41:43 65:67]-12,3,:),1));
hypercapnia_stim=squeeze(mean(ethc([17:19 41:43 65:67],3,:),1));
hypercapnia_delta=hypercapnia_stim-hypercapnia_base;

hypercapnia_mean=mean([hypercapnia_base hypercapnia_stim hypercapnia_delta],1);
hypercapnia_std=std([hypercapnia_base hypercapnia_stim hypercapnia_delta],[],1);


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

hyperoxia_base=squeeze(mean(etho(1:12,2,:),1));
hyperoxia_stim=squeeze(mean(etho([40:46 88:94],2,:),1));
hyperoxia_delta=hyperoxia_stim-hyperoxia_base;

hyperoxia_mean=mean([hyperoxia_base hyperoxia_stim hyperoxia_delta],1);
hyperoxia_std=std([hyperoxia_base hyperoxia_stim hyperoxia_delta],[],1);

figure;

subplot(211)
errorbar(etho(:,1,1),mean(etho(:,3,:),3),std(etho(:,3,:),[],3)./sqrt(height(hyperoxia_start_times)));
set(gca,'xtick',[0:60:600]);
xlim([0 600])
ylim([30 45])
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
