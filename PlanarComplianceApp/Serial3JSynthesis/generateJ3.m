function [ x,y ] = generateJ3( x2, y2, C, func )

K = inv(C);

t2 = [y2; -x2; 1];

w2 = K*t2;

mag = norm(w2(1:2));
n = w2(1:2)/mag;
d = w2(3)/mag;

slope2 = n(2)/n(1);

r = -d*[0 -1; 1 0]*n;

b2 = r(2) - (slope2*r(1));

b1 = func(0);
slope1 = func(1) - b1;

x = (b1 - b2)/(slope2 - slope1);
y = func(x);

end

