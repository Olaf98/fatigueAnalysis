function allData = dataSeparation (subnum,trialnum)
%the 3 channels (raw, rectified, and RMS) recorded by the device were all
%concatenated to one signal, we had to separate the raw sEMG
allData= cell (1,subnum*trialnum);
ind=1;
figure('Name', 'Raw data');
for s=1:subnum
    for t=1:trialnum
        filename = ['subject' num2str(s) '-' 'trial' num2str(t) '.mat'];
        emg = load(filename, 'data' );
        index = length(emg.data)/3;
        allData{ind}= emg.data(:,index+1:index*2);
        subplot(3,2,ind);
        plot(allData{ind})
        title(['subject' num2str(s) '-' 'trial' num2str(t)])
        ind=ind+1;
    end
end

