% MISOANN01
clear all
close all
clc

%...Veriler aliniyor
% load bioreactor_data Xt Yt
% t = Xt(1:2000,:);
% y = Yt(1:2000,:);

% load CSTR2.mat INPUT OUTPUT
% t = INPUT(1:200,:);
% y = OUTPUT(1:200,:);

%veriler alýnýyor
veriler=xlsread('veriler.xlsx');
t=veriler(1:263,1:7);
y=veriler(1:263,13);

% veri=csvread('housing.csv',1,0);
% t=veri(1:20640,1:)

% load telco.mat 
% t=telco(1:200,2:20);
% y=telco(1:200,21);
% 
% tinput=dummyvar(t);

% veri=xlsread('kc_house_data.xlsx');
% y=veri(1:2000,3);
% veri(:,3)=[];
% t=veri(1:2000,3:end);

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

FVALBEST = []; S = [];
for s = 1:10;
    top = 0;
    top1=0;
    for i=1:5
        [xBEST,fValBEST] = MISOANN(tTra,yTra,tVal,yVal,s);
        top = top + fValBEST;
    end
    fValBEST = top/5;
    yhatBEST=top1/5;
    S = [S; s];
    FVALBEST = [FVALBEST, fValBEST];
    s
    fValBEST
end
fprintf("s:%d",s);
stem(S,FVALBEST)
xlabel('S')
ylabel('Fval^{*}')


