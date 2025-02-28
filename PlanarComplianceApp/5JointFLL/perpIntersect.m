function [x2, y2] = perpIntersect(x1, y1, m, x, y)

%slope of perpendicular line
perpm = -1/m;

%y-intercept of given line
b = y1 - m*x1;
%y-intercept of perpendicular line
c = y + x/m;

x2 = (c - b)/(m + 1/m);

y2 = m*x2 + b;

if isinf(m)
    x2 = x1;
    y2 = y;
elseif m == 0
    x2 = x;
    y2 = y1;
end 

end