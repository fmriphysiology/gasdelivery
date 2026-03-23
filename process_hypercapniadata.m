function [et_resamp fi_resamp]=process_hypercapniadata(subj,fname_start_times)

    sample_freq=1000; %Hz
    t_1stblock=120; %seconds
    t_total=420; %seconds

    fname=[char(subj) '_hypercapnia.txt'];
    data=load(fname);

    start_times=readtable(fname_start_times,'FileType','delimitedtext'); %start times are start of first hyperoxia block
    t_start=start_times.start_time1(find(strcmp(start_times.subject_id,subj)))-60*sample_freq;
    t_end=t_start+t_total*sample_freq;
    if t_end>length(data)
        t_end=length(data);
    end

    data=data(t_start:t_end,[1 6 7]);
    [et pc fi]=findETCO2(data,2,3);

    resample_delta=5; %seconds
    t_resamp=(0:resample_delta:t_total)';
    %et_resamp=in
    
    et_resamp=interp1(et(:,1),et(:,2:3),t_resamp,'linear','extrap');

    et_resamp=cat(2,t_resamp,et_resamp);
    
    fi_resamp=interp1(fi(:,1),fi(:,2:3),t_resamp,'linear','extrap');

    