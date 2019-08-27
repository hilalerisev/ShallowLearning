function [xBEST,fValBEST]=MISOANN(tTra,yTra,tVal,yVal,S)

R = size(tTra,2);
Ntra = size(tTra,1);
%...parametreler initialize ediliyor
Wg = rand(S,R) - 0.5;
bh = rand(S,1) - 0.5;
Wc = rand(1,S) - 0.5;
bc = rand(1,1) - 0.5;

[x] = Matrix2Vector(Wg,bh,Wc,bc);
fValBEST = inf;
Nmax = 50;
eps1 = 1e-6;
loop = 1; iteration = 0; I = eye(length(x)); mu = 1; mumax = 1e20;
while loop
    J = [];
    for i=1:Ntra
        for j=1:S*R
            k = mod(j-1,S)+1;
            m = fix((j-1)/S)+1;
            J(i,j) = -Wc(1,k)*tTra(i,m)*[1-tanh(Wg(k,:)*tTra(i,:)'+bh(k))^2];
        end
        for j=S*R+1:S*R+S
            J(i,j) = -Wc(1,j-S*R)*(1)*[1-tanh(Wg(j-S*R,:)*tTra(i,:)'+bh(j-S*R))^2];
        end
        for j=S*(R+1)+1:S*(R+2)
            J(i,j) = -tanh(Wg(j-(R+1)*S,:)*tTra(i,:)'+bh(j-(R+1)*S));
        end
        for j=S*(R+2)+1
            J(i,j) = -1;
        end
    end
    [yhat] = MISOANNmodelGC(tTra,x,S,R);
    ex = yTra - yhat;
    fx = ex'*ex;
    
    loop1 = 1;
    while loop1
        p = -inv(J'*J + mu*I)*J'*ex; % aday yon
        z = x + p; % gecici guncelleme
        [yhatz] = MISOANNmodelGC(tTra,z,S,R);
        ez = yTra - yhatz;
        fz = ez'*ez;
        if fz<fx
            x = x + p;
            [Wg,bh,Wc,bc] = Vector2Matrix(x,S,R);
            mu = mu/10;
            loop1 = 0;
        else
            mu = mu*10;
            if mu>mumax; loop1 = 0; loop = 0; end
        end
    end
    NormGrad = norm(2*J'*ex);
    fprintf('k:%4.0f\t  ftra:%4.6f\t fval:%4.6f\t ||g||:%4.6f\n',iteration, fx, fValBEST, NormGrad)

    
    iteration = iteration + 1;
    if [NormGrad<eps1] | [iteration>=Nmax];
        loop = 0;
    end
    
    [yhat] = MISOANNmodelGC(tVal,x,S,R);
    fVal = (yVal - yhat)'*(yVal - yhat);
 
    if fVal<fValBEST
        fValBEST = fVal;
        xBEST = x;
    end
end