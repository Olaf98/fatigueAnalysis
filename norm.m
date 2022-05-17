function [normfactors,data] = norm(data)
%record the maximum value from the contraction at 5.5Kg and divide the data
%of eac hsubject by the corresponding value
index=1;
ind=[2,4,6];
normfactors=zeros(1,3);
%figure('Name','normalized');

for i =1:length(ind)
    normfactors(index)= max(data{ind(i)});
    index=index+1;
end

for i=1:2
    data{i}=data{i}./normfactors(1);
   %subplot(3,2,i)
   %plot(data{i},'r')
   % grid
end
for i=3:4
    data{i}=data{i}./normfactors(2);
    %subplot(3,2,i)
    %plot(data{i},'r')
    %grid
end
for i=5:6
    data{i}=data{i}./normfactors(3);
    %subplot(3,2,i)
    %plot(data{i},'r')
    %grid
end
end

