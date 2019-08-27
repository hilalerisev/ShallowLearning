% MISOANN03
clear all
close all
clc

%...Veriler aliniyor
% load SunSpot
% R = 30;
% t = []; y = [];
% for i=1:3000
%     input = Z(i:i+R-1)'; output = Z(i+R);
%     t = [t; input]; y = [y; output];
% end
% 
% 
% load henondata2 y
% Z = y; clear y
% R = 5;
% t = []; y = []; M = 300;
% for i=1:M
%     input = Z(i:i+R-1); output = Z(i+R);
%     t = [t; input]; y = [y; output];
% end

% Z = rand;
% for i=1:350
%     Z(i+1) = 3.9*Z(i)*(1-Z(i));
% end
% for i=1:350
%     Z(i+1) = 0.994*Z(i);
% end

load HavaDurumu
R = 5;
t = []; y = []; M =3000;
for i=1:M
    input = havadurumuparsed(i:i+R-1)'; output = havadurumuparsed(i+R);
    t = [t; input]; y = [y; output];
end

T = t; Y = y;
t = [t - min(t)]./[max(t) - min(t)];
y = [y - min(y)]./[max(y) - min(y)];

%----------------

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

Smax = floor([size(tTra,1) - 1]/(R+2))

S = 5;

[xBEST,fValBEST] = MISOANN(tTra,yTra,tVal,yVal,S);
[yhatBEST] = MISOANNmodelGC(t,xBEST,S,R);

plot(TrainingIndex,y(TrainingIndex),'bx')
hold on
plot(ValidationIndex,y(ValidationIndex),'ro')
plot(yhatBEST,'k');
title(['F:',num2str(fValBEST)]);


Zhat = havadurumuparsed((1:M))';

%..tahmin yapiliyor
for i=M-R+1:M+30
    input = Zhat(i:i+R-1); 
    [yhat] = MISOANNmodelGC(input,xBEST,S,R);
    %yhat=yhatBEST*(max(Y)-min(Y)) + min(Y)
    Zhat = [Zhat, yhat];
    
end
plot(Zhat,'g')
plot(havadurumuparsed(1:M+30),'m')


