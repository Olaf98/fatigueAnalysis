%% Separation&Filteration&Normaization
close all
allData=dataSeparation(3,2);
freqAnalysis(allData,200);
[filteredData,rec_signal,envelope] = filteration(allData,200);
[factors, normData]= norm(envelope);

%% Rectified vs Normalized signal
figure('Name', 'Rectified vs Normalized signal');
p=1;
for i=1:3
    for t=1:2
        subplot(3,2,p)
        plot(rec_signal{p});
        hold on
        
        plot(normData{p},'r')
        xlabel('time')
        ylabel('volt')
        grid
        title( ['Subject ' int2str(i) '-' 'Trial ' int2str(t) ])
        p=p+1;
    end
end

%% Entropy
for i =1:2
    [~,lag]=phaseSpaceReconstruction(normData{i});
    entropy(1,i)=approximateEntropy(normData{i}, lag, 3);
end
for i =3:4
    [~,lag]=phaseSpaceReconstruction(normData{i});
    entropy(2,i-2)=approximateEntropy(normData{i}, lag, 3);
end
for i =5:6
    [~,lag]=phaseSpaceReconstruction(normData{i});
    entropy(3,i-4)=approximateEntropy(normData{i}, lag, 3);
end
m=mean(entropy,1);
entropy(4,:)=m;

%% Approximate entropy values at 3 & 5.5 kg plot
figure;
for i=1:3
    plot([3 5.5],entropy(i,1:2),'--gs','color','b')
    text(2.75,entropy(i,1),['subject' num2str(i)])
    hold on
end
plot([3 5.5],entropy(4,1:2),'--gs','color','r')
xlim([2.5 6])
title('Approximate entropy values at 3 & 5.5 kg')
xlabel('kg')
ylabel('Approximate entropy')

%% Average Approximate entropy per subject plot
m=mean(entropy,2);
entropy(:,3)=m;

figure;
plot(entropy(1:3,3),'--o','color','r')
%ylim([0 0.03])
title('Average Approximate entropy per subject')
xlabel('subject')
ylabel('Approximate entropy')
%% Fractal Dimension
%
FractalDimension=zeros(3,2);
for i =1:2
    FractalDimension(1,i)=FD(normData{i});
end
for i =3:4
    FractalDimension(2,i-2)=FD(normData{i});
end
for i =5:6
    FractalDimension(3,i-4)=FD(normData{i});
end
m=mean(FractalDimension,1);
FractalDimension(4,:)=m;

%% Fractal Dimensions at 3 & 5.5 kg plot
figure;
for i=1:3
    plot([3 5.5],FractalDimension(i,:),'--gs','color','b')
    text(2.75,FractalDimension(i,1),['subject' num2str(i)])
    hold on
end
plot([3 5.5],FractalDimension(4,:),'--gs','color','r')
xlim([2.5 6])
title('Fractal Dimensions at 3 & 5.5 kg')
xlabel('kg')
ylabel('Fractal Dimensions')

%% Average Fractal Dimension per subject plot
m=mean(FractalDimension,2);
FractalDimension(:,3)=m;

figure;
plot(FractalDimension(1:3,3),'--o','color','r')
%ylim([0 0.03])
title('Average Fractal Dimensions per subject')
xlabel('subject')
ylabel('Fractal Dimensions')

%% Lyapunov
%find the best expansion range
close all
LyapExp=zeros(3,2);
for i=1:6
    xdata = normData{i};
    %[~,lag] = phaseSpaceReconstruction(xdata,[],dim);
    [XR,eLag,eDim] = phaseSpaceReconstruction(xdata);
    eRange = 150;
    lyapunovExponent(xdata,200,eLag,eDim,'ExpansionRange',eRange);
end

%%
%expRange=[[30 200];[0 200];[0 200];[160 200];[46 148];[100 200]];
close all;
expRange=150;

for i =1:2
    xdata = normData{i};
    %[XR,eLag,eDim] = phaseSpaceReconstruction(xdata);
    LyapExp(1,i)=lyapunovExponent(xdata,200,eLag,eDim,'ExpansionRange',expRange);
    %%,[expRange(i,1) expRange(i,2)]);
end
for i =3:4
    xdata = normData{i};
    %[XR,eLag,eDim] = phaseSpaceReconstruction(xdata);
    LyapExp(2,i-2)=lyapunovExponent(xdata,200,eLag,eDim,'ExpansionRange',expRange);
end
for i =5:6
    xdata = normData{i};
    %[XR,eLag,eDim] = phaseSpaceReconstruction(xdata);
    LyapExp(3,i-4)=lyapunovExponent(xdata,200,eLag,eDim,'ExpansionRange',expRange);
    %,'ExpansionRange',expRange(i,1:2));
end
m=mean(LyapExp,1);
LyapExp(4,:)=m;

%% lyapunov Exponent at 3 & 5.5 kg plot
figure;
for i=1:3
    plot([3 5.5],LyapExp(i,:),'--gs','color','b')
    text(2.75,LyapExp(i,1),['subject' num2str(i)])
    hold on
end
plot([3 5.5],LyapExp(4,:),'--gs','color','r')
xlim([2.5 6])
title('lyapunov Exponent at 3 & 5.5 kg')
xlabel('kg')
ylabel('lyapunov Exponent')

%% Average lyapunov Exponent per subject plot
m=mean(LyapExp,2);
LyapExp(:,3)=m;

figure;
plot(LyapExp(1:3,3),'--o','color','r')
%ylim([0 0.03])
title('Average lyapunov Exponent per subject')
xlabel('subject')
ylabel('lyapunov Exponent')
