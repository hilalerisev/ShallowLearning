% MISOANN04
clear all
close all
clc

%...Veriler aliniyor
% B = 5.0;
% N = 400;
% T = [];
% for i=1:N/2
%    theta = pi/2 + (i-1)*[(2*B-1)/N]*pi;
%    T = [T , [theta*cos(theta);theta*sin(theta)]];
% end
% T = [T,-T];
% Tmax = pi/2+[(N/2-1)*(2*B-1)/N]*pi;
% T = [T]/Tmax;
% Y = [-ones(1,N/2),ones(1,N/2)];
% t = T'; y = Y'; clear T Y
%----------------


% Veriler normalize ediliyor
tn = [t - min(t)]./[max(t) - min(t)];
%yn = [y - min(y)]./[max(y) - min(y)]; % siniflandirmada cikis normalize
%edilmez


%........................
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


S = 35;

[xBEST,fValBEST] = MISOANN(tTra,yTra,tVal,yVal,S);
[yhatBEST] = MISOANNmodelGC(t,xBEST,S,R);
yhatBEST = sign(yhatBEST);

NumOfMisClass = length(find(y~=yhatBEST))

subplot(211)
IplusTra = find(yTra==+1); IminusTra = find(yTra==-1); 
IplusVal = find(yVal==+1); IminusVal = find(yVal==-1); 
plot(tTra(IplusTra,1),tTra(IplusTra,2),'bo'); hold on
plot(tTra(IminusTra,1),tTra(IminusTra,2),'bx'); 
plot(tVal(IplusVal,1),tVal(IplusVal,2),'ro'); 
plot(tVal(IminusVal,1),tVal(IminusVal,2),'rx'); 

subplot(212)
Iplus = find(yhatBEST==+1);
Iminus = find(yhatBEST==-1);
plot(t(Iplus,1),t(Iplus,2),'mo'); hold on
plot(t(Iminus,1),t(Iminus,2),'mx'); 

mint1 = floor(min(t(:,1))); maxt1 = ceil(max(t(:,1)));
mint2 = floor(min(t(:,2))); maxt2 = ceil(max(t(:,2)));
T1 = []; T2 = []; PrevOutput = 0;
for t1=mint1:0.01:maxt1
    for t2=mint2:0.01:maxt2
        input = [t1,t2];
        [yhatBEST] = MISOANNmodelGC(input,xBEST,S,R);
        if PrevOutput*yhatBEST<0
            T1 = [T1; t1];
            T2 = [T2; t2];
        end
        PrevOutput = yhatBEST;
    end
end
plot(T1,T2,'k.')

set(gcf,'Color',[1 1 1])
set(gcf,'Position',[377 41 632 740])

 





