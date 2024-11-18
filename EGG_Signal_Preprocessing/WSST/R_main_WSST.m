clear
close all
clc

%% Non-Responder 
m=1;
for i=17:34
filename = sprintf('Depressed_%i',i);
load(filename);
S=1;
Fs=256;
Time=30;
for j=1:length(EEG)/(Fs*Time)
Signal=EEG(S:(S+Time*Fs-1),:);
S=S+Fs*Time;
%% CWT
fb = cwtfilterbank('SignalLength',length(Signal),'SamplingFrequency',Fs,'FrequencyLimits',[0.5 20],'VoicesPerOctave',12);
for k=1:19
[cfs, frq] = wt(fb,Signal(:,k));
t = (0:length(Signal)-1)/Fs;
pcolor(t,frq,abs(cfs));
set(gca);
shading interp;

filename = sprintf('NR_CWT_%i.png',m);
saveas(gcf,filename);
m=m+1;
end
end
end

%% End
disp('tamam shud')