function [filteredData,rec_signal,envelope] = filteration(allData,fs)
window=100;
wo = 50/(fs/2);  
bw = wo/35;
[b,a] = iirnotch(wo,bw);

fnyq= fs/2;
fcuthigh= 10;
fcutlow = 80;

[b1,a1]= butter(4,[fcuthigh,fcutlow]/fnyq, 'bandpass' );
%figure('Name','RMS');
for i=1:6
%%NOTCH
NotchFiltered= filter(b,a,allData{i});
%%BP
filteredData{i}= filtfilt(b1,a1,NotchFiltered );

%%RECTIFICATION
rec_signal{i} = abs(filteredData{i})*1000;

%%RMS
envelope{i}= sqrt(movmean((rec_signal{i}.^2),window));

%%smoothing
%smoothed{i} = smooth(envelope{i});

% subplot(3,2,i)
% plot(envelope{i}) 
% xlabel('time in s')
% ylabel('voltage in mv')
end

end

