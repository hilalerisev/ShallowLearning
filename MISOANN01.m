% MISOANN01
clear all
close all
clc

...Veriler aliniyor
% load bioreactor_data Xt Yt
% t = Xt(1:200,:);
% y = Yt(1:200,:);

% load CSTR2.mat INPUT OUTPUT
% t = INPUT(1:200,:);
%  y = OUTPUT(1:200,:);
% 
veriler=xlsread('veriler.xlsx');
t=veriler(1:263,1:7);
y=veriler(1:263,13);
% veri=csvread('Advertising.csv',1,1);
% t=veri(1:200,1:3);
% y=veri(1:200,4);
%----------------
% T = t; Y = y;
% t = [t - min(t)]./[max(t) - min(t)];
% y = [y - min(y)]./[max(y) - min(y)];
% veri=xlsread('kc_house_data.xlsx');
% y=veri(1:200,3);
% veri(:,3)=[];
% t=veri(1:200,3:end);
% veri=csvread('hou_all.csv');
% veri(:,15)=[];
% t=veri(1:end,1:13);
% y=veri(1:end,14);


%----------------
T = t; Y = y;
t = [t - min(t)]./[max(t) - min(t)];
y = [y - min(y)]./[max(y) - min(y)];

N = size(t,1); % veri sayisi
R = size(t,2); % giris sayisi
% veriler karistiriliyor
%..veriler ikiye ayriliyor
II = randperm(N);
TrainingIndex = II(1:round(N/2));
ValidationIndex = II(round(N/2)+1:N);
% TrainingIndex = 1:2:N;
% ValidationIndex = 2:2:N;



tTra = t(TrainingIndex,:);
yTra = y(TrainingIndex,:);
tVal = t(ValidationIndex,:);
yVal = y(ValidationIndex,:);


S = 3;

[xBEST,fValBEST] = MISOANN(tTra,yTra,tVal,yVal,S);
[yhatBEST] = MISOANNmodelGC(t,xBEST,S,R);

plot(TrainingIndex,yTra,'bx')
hold on
plot(ValidationIndex,yVal,'ro')
plot(yhatBEST,'k');
title(['F:',num2str(fValBEST)]);
pause(1)
