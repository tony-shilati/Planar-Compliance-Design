function [errCode1, errCode2] = checkConditions(ax, K)

%Conditon 1 - the compliant center must be on the opposite side of line l
%from the compliant center

%Condition 2 - line l3 cannot intersect the line segment between T1 and T2

%errCode = 0 - no errors
%errCode = 1 - there is an error

%Gets the neccesary information to check the conditions
[x, y] = stiffnessCenter(K, ax);
[x1, y1] = grabData('N1', ax);
[x2, y2] = grabData('N2', ax);
[x3, y3] = grabData('N3', ax);
[x4, y4] = grabData('N4', ax);
[p3x, p3y] = grabData('P3', ax);

slope_l = (y2 - y1) / (x2 - x1);
yint_l = y1 - slope_l*x1;

slope_l3 = (y4 - y3) / (x4 - x3);
yint_l3 = y3 - slope_l3*x3;

[Ix1, Iy1] = perpIntersect(x1, y1, slope_l, p3x, p3y);
[Ix2, Iy2] = perpIntersect(x1, y1, slope_l, x, y);

check_x1 = Ix1 - p3x; check_y1 = Iy1 - p3y;
check_x2 = Ix2 - x; check_y2 = Iy2 - y;

%Checks the conditions
if sign(check_x1) ~= sign(check_x2) && sign(check_y1) ~= sign(check_y2)
    errCode1 = 0;
else
    errCode1 = 1;
end

fun_l = @(x) slope_l * x + yint_l;

fun_l3 = @(x) slope_l3 * x + yint_l3;

funsolve = @(x) fun_l(x) - fun_l3(x);

try
xintersect = fzero(funsolve, 0);
catch
    errCode1 = 0;
    errCode2 = 0;
    return
end

yintersect = fun_l(xintersect);

if x1 > x2
    if xintersect < x1 && xintersect > x2
        errCode2 = 1;
    else
        errCode2 = 0;
    end
elseif x2 > x1
    if xintersect > x1 && xintersect < x2
        errCode2 = 1;
    else
        errCode2 = 0;
    end
end





if errCode1 == 0
    %do nothing
elseif errCode1 == 1
    warndlg(['The twist ceter associated with line three must be on the opposite ' ...
        'side of the dashed segment from the compliance center.'], '', 'modal')
end

if errCode2 == 0 
    %Do nothing
elseif errCode2 == 1
    warndlg(['The third line cannot intersect the dashed segment connecting ' ...
        'twist center 1 and 2.'], '', 'modal')
end

end