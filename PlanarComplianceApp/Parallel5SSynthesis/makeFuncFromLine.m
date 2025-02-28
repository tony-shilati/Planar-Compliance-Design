function [ yfun ] = makeFuncFromLine( h )


x = get(h,'XData');
y = get(h,'YData');

m = (y(2)-y(1))/(x(2)-x(1)); % Calculate Slope

if x(1) == x(2)
   x(1) = x(1) + 1e-20; 
end

if isinf(m)
   m = 1e20*sign(m);
end

b = (y(1) - (m*x(1))); % Calculate Y-intercept

yfun = @(x) m*x + b;

