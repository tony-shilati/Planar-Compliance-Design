function [ x,y,wnorm ] = convertToPoint(xarr,yarr)

global K

k = (yarr(2)-yarr(1))/(xarr(2)-xarr(1));

if isinf(k)
   k = 1e20; 
end

wnorm = [1;k;(k*xarr(1) - yarr(1))];

t2 = K\wnorm;

t2 = t2/t2(3);

x = -t2(2);
y = t2(1);




end

