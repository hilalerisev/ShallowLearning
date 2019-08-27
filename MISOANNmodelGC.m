function [yhat]=MISOANNmodelGC(input,x,S,R)
[Wg,bh,Wc,bc] = Vector2Matrix(x,S,R);
N = size(input,1); % giris vektörü sayisi
R = size(input,2); % girisi sayisi


for i=1:N
    yhat(i,1) = Wc*tanh(Wg*input(i,:)' + bh) + bc;
end

