function [xcoord, ycoord] = perpIntersect(x1, y1, m, x, y)
% x1 and y1 define a point on the line
% m is the slope of the line
% x and y define the independent point
format long
%% Calculate perp intersection point

%y-intercept of given line
b = y1 - m*x1;

%y-intercept of perpendicular line
c = y + x/m;

%Perpendicular intersection location
xcoord = (c - b)/(m + 1/m);
ycoord = m*xcoord + b;

%Unique cases
if isinf(m)
    xcoord = x1;
    ycoord = y;
elseif m == 0
    xcoord = x;
    ycoord = y1;
end 

