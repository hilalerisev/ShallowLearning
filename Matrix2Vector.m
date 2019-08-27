function [x]=Matrix2Vector(Wg,bh,Wc,bc)
[S,R] = size(Wg);
x = [];
for i=1:R
    x = [x; Wg(:,i)];
end
x = [x; bh; Wc'; bc];