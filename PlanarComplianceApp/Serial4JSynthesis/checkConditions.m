function [errCode1, errCode2, errCode3] = checkConditions(ax, C)

%Conditon 1 - the compliant center must be on the opposite side of line l
%from the compliant center

%Condition 2 - line l3 cannot intersect the line segment between T1 and T2

%Condition 3 - line 4 cannot intersect the line segment between T1 and T2

%errCode = 0 - no errors
%errCode = 1 - there is an error

%Gets the neccesary information to check the conditions
[x, y] = compliantCenter(C, ax);
[x1, y1] = grabData('P1', ax);
[x2, y2] = grabData('P2', ax);
[x3, y3] = grabData('P3', ax);
[x4, y4] = grabData('N5', ax);
[x5, y5] = grabData('N6', ax);
[x6, y6] = grabData('N7', ax);

if ~isempty(any([x1, x2, y1, y2], 'all'))
    slope_l = (y2 - y1) / (x2 - x1);
    yint_l = y1 - slope_l*x1;
end


slope_l3 = (y5 - y4) / (x5 - x4);
yint_l3 = y4 - slope_l3*x4;

slope_l4 = (y6 - y3) / (x6 -x3);
yint_l4 = y3 - slope_l4*x3;

[Ix1, Iy1] = perpIntersect(x1, y1, slope_l, x3, y3);
[Ix2, Iy2] = perpIntersect(x1, y1, slope_l, x, y);

check_x1 = Ix1 - x3; check_y1 = Iy1 - y3;
check_x2 = Ix2 - x; check_y2 = Iy2 - y;

%Checks condition 1
if any(sign(check_x1) ~= sign(check_x2)) && any(sign(check_y1) ~= sign(check_y2))
    errCode1 = 0;
else
    errCode1 = 1;
end

%Checks conditon 2
if ~isempty(any([x1, x2, x4, x5, y1, y2, y4, y5], 'all'))
    A1 = [-slope_l, 1; -slope_l3, 1];
    
    Ab1 = [yint_l, 1;yint_l3, 1];
    
    xintersect1 = det(Ab1)/det(A1);
    
    
    
    if x1 > x2
        if xintersect1 < x1 && xintersect1 > x2
            errCode2 = 1;
        else
            errCode2 = 0;
        end
    elseif x2 > x1
        if xintersect1 > x1 && xintersect1 < x2
            errCode2 = 1;
        else
            errCode2 = 0;
        end
    end
end



%Checks condition 3
if ~isempty(x6) && ~isempty(y6)
    A2 = [-slope_l, 1; -slope_l4, 1];
    
    Ab2 = [yint_l, 1; yint_l4, 1];
    
    xintersect2 = det(Ab2)/det(A2);
    
    
    if x1 > x2
        if xintersect2 < x1 && xintersect2 > x2
            errCode3 = 1;
        else
            errCode3 = 0;
        end
    elseif x2 > x1
        if xintersect2 > x1 && xintersect2 < x2
            errCode3 = 1;
        else
            errCode3 = 0;
        end
    end
else
    errCode3 = 0;
end


if errCode1 == 0
    %do nothing
elseif errCode1 == 1
    try
        warndlg(['The twist ceter associated with line three must be on the opposite ' ...
            'side of the dashed segment from the compliance center.'], '', 'modal')
        uiwait
    catch 
    end
    
end

if errCode2 == 0 
    %Do nothing
elseif errCode2 == 1
    try
        warndlg(['The third line cannot intersect the dashed segment connecting ' ...
            'twist center 1 and 2.'], '', 'modal')
        uiwait
    catch 
    end
    
end

if errCode3 == 0
    %Do nothing
elseif errCode3 == 1
    try
    warndlg(['The fourth line cannot intersect the dashed segment connecting ' ...
        'twist center 1 and 2'], '', 'modal')
    uiwait
    catch
    end

end

end