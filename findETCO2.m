function [et pc fi]=findETCO2(data,o2ch,co2ch)

shift=450; %shift between co2 and o2 channels of powerlab (assume 1000Hz sampling rate)

[pks locs]=findpeaks(100-data(:,o2ch),'minpeakheight',mean(100-data(:,o2ch)),'minpeakwidth',500);

pc=[data(locs,1) data(locs,o2ch) data(locs+450,co2ch)];

%figure;
%plot(o2pc(:,1)./60,o2pc(:,2));

Patm=760; %standard pressure in mmHg
Ph20=47; %standard water vapour partial pressure in mmHg

et=[pc(:,1)-pc(1,1) pc(:,2)./100.*(Patm-Ph20) pc(:,3)./100.*(Patm-Ph20)]; %et partial pressure in mmHg

%fraction of inspired gases
[pks locs]=findpeaks(data(:,o2ch),'minpeakheight',mean(data(:,o2ch)),'minpeakwidth',500);

fi=[data(locs,1) data(locs,o2ch) data(locs+450,co2ch)];
