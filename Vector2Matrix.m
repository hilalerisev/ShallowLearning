function [Wg,bh,Wc,bc]=Vector2Matrix(x,S,R)

Wg = [];
for i=1:R
    Wg = [Wg,x((i-1)*S+1:i*S,1)];
end
bh = x(S*R+1:S*R+S,1);
Wc = x(S*R+S+1:S*R+S+S,1)';
bc = x(end);



