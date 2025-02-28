function [y_n] = checkSides(lx, ly, x1, y1, x2, y2)
%This function checks if two points are on the same side of a line 

%If the function returns 0, then the points are not seperated by the line
%If the function returns 1, then the points are seperated by the line

%lx and ly are vectors with the cordinated of points on the line
% x1, y1, x2, y2 are all coordinate values for the two points being checked

%% calculate the locations of the perpedicular intersections of the points and the lines
%slope of line

m = (ly(2) -ly(1)) / (lx(2) - lx(1));

    %Point 1
[xint1, yint1] = perpIntersect(lx(1), ly(1), m, x1, y1);

    %Point 2
[xint2, yint2] = perpIntersect(lx(1), ly(1), m, x2, y2);

%% Checks to see if the points are on the same side of the line

chk1x = sign(xint1 - x1); chk1y = sign(yint1 - y1);
chk2x = sign(xint2 - x2); chk2y = sign(yint2 - y2);

%% Returns a value for y_n
if (chk1x == chk2x) && (chk1y == chk2y)
    y_n = 0;

elseif (chk1x ~= chk2x) && (chk1y ~= chk2y)
    y_n = 1;

end

if isinf(m) 
    if (chk1x == chk2x)
        y_n = 0;

    elseif (chk1x ~= chk2x)
        y_n = 1;

    end

elseif m == 0
    if (chk1y == chk2y)
        y_n = 0;

    elseif (chk1y ~= chk2y)
        y_n = 1;

    end

end



end