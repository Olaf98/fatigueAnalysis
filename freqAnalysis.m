function [outputArg1,outputArg2] = freqAnalysis(allData, fs)
figure('Name','FFT');
p=1;
for i=1:3
    for j=1:2
        L= length(allData{p});
        f= fs*(0:(L/2))/L;
        p1=fft(allData{p});
        p1=abs(p1/L);
        p1= p1(1:L/2+1);
        p1(2:end-1)=2*p1(2:end-1);

        subplot(3,2,p)
        p=p+1;
        plot(f,p1);
        title(['subject' num2str(i) 'Trial' num2str(j) ' FFT'])
        xlabel('Frequency in (Hz)')
        ylabel('intesity')
    end
end
figure('Name', 'STFT');
p=1;
for i=1:3
    for j=1:2
        subplot(3,2,p)
        stft(allData{p},200,'Window',kaiser(256,5),'OverlapLength',220,'FFTLength',512);
        view(-45,65)
        colormap jet
        p=p+1;
        title(['subject' num2str(i) 'Trial' num2str(j) ' STFT'])
    end
end
end

