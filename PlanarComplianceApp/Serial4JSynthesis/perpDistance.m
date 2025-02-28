function [d] = perpDistance(x1, y1, chngx, chngy, x, y)

 
%this function calcultes the perpendicular distance between line and point
%slope of given line
m = chngy/chngx;

%slope of perpendicular line
perpm = -1/m;

%y-intercept of given line
b = y1 - m*x1;
%y-intercept of perpendicular line
c = y + x/m;

xcoord = (c - b)/(m + 1/m);

ycoord = m*xcoord + b;

if isinf(m)
    c = y;
    b = 0;
    m = 1;
    xcoord = x1;
    ycoord = y;
elseif m == 0
    c = 0;
    m = 1;
    xcoord = x;
    ycoord = y1;
end 


d = sqrt((xcoord-x)^2 + (ycoord-y)^2);

end