clear
close all
clc

%% Responder 
m=1;
for i=[1 2 3 5 6 7 9 10 11 13 14 15]
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

filename = sprintf('R_CWT_%i.png',m);
saveas(gcf,filename);
m=m+1;
end
end
end

%% End
disp('tamam shud')