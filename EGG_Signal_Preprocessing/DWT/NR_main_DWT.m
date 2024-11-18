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
%% DWT

% Choose wavelet and decomposition level
wavelet = 'db4';
level = 5;

for k=1:19

% Perform Discrete Wavelet Transform (DWT)
[c, l] = wavedec(Signal(:,k), level, wavelet);

% Define the minimum and maximum scales for CWT
minScale = 1;
maxScale = 256;

% Generate scales based on the minimum and maximum scales
scales = 2.^((log2(minScale):log2(maxScale))/level);

% Create matrix for time-frequency representation
tf_representation = abs(cwt(Signal(:,k), scales, wavelet));

% Obtain time information
t = 0:1:length(Signal(:,k))-1;
t = t/(length(Signal(:,k))-1);
imagesc(t, scales, 10*log10(tf_representation));

filename = sprintf('NR_DWT_%i.png',m);
saveas(gcf,filename);
m=m+1;
end
end
end

%% End
disp('tamam shud')