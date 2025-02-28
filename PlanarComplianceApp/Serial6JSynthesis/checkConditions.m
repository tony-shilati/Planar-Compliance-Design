function [errCode1, errCode3] = checkConditions(ax, C, phase)

%if an errCode = 1 than the condition it is associated with is not
%satified. If an errCode is 0 then the condition is satisfied

%First condtion - t12 and t34 must be on the same sides of w12 and w34

%Second condition - The segment connectiong j5 and j6 must cross the
%quadrilateral formed by j1-j4 exactly once


fig = get(ax, 'Parent');
[x, y, C] = compliantCenter(C, ax);

%Get neccesary information
[p1x, p1y] = grabData('P1', ax);    %twist 12
[p2x, p2y] = grabData('P2', ax);    %twist 34

if phase > 3
    [j1x, j1y] = grabData('J1', ax);
    [j2x, j2y] = grabData('J2', ax);
    [j3x, j3y] = grabData('J3', ax);
    [j4x, j4y] = grabData('J4', ax);
end

%%Calculate the conditions
if phase == 3
    %% condition 1
    [l1x, l1y] = grabData('L1', ax);    %wrench 12
    [l2x, l2y] = grabData('L2', ax);    %wrench 34
    m12 = (l1y(1) - l1y(2)) / (l1x(1) - l1x(2));
    m34 = (l2y(1) - l2y(2)) / (l2x(1) - l2x(2));

    %check that both twists are on the same side of line 12
    [i1x, i1y] = perpIntersect(l1x(1), l1y(1), m12, p1x, p1y);
    [i2x, i2y] = perpIntersect(l1x(1), l1y(1), m12, p2x, p2y);
    chck1x = i1x - p1x; chck1y = i1y - p1y;
    chck2x = i2x - p2x; chck2y = i2y - p2y;

        %cl1 = check line 1; if cl1 == 1 then the condition is satisfied
    cl1 = 0;
    if sign(chck1x) == sign(chck2x) && sign(chck1y) == sign(chck2y)
        cl1 = 1;
    else
        cl1 = 0;
    end

    %check that both twists are on the same side of line 12
    [i3x, i3y] = perpIntersect(l2x(1), l2y(1), m34, p1x, p1y);
    [i4x, i4y] = perpIntersect(l2x(1), l2y(1), m34, p2x, p2y);
    chck3x = i3x - p1x; chck3y = i3y - p1y;
    chck4x = i4x - p2x; chck4y = i4y - p2y;

        %cl2 = check line 2; if cl2 == 1 the the condition is satisfied
    cl2 = 0;
    if sign(chck3x) == sign(chck4x) && sign(chck3y) == sign(chck4y)
        cl2 = 1;
    else
        cl2 = 0;
    end

    %Assign the eeror code a value
    if cl1 == 1 && cl2 == 1
        errCode1 = 0;
    else
        errCode1 = 1;
    end
    errCode3 = 0;





elseif phase >= 8
    %% condition 2
    ind = drawQuadCurve(ax, C, 2);

    %Assign the errCode a value
    if ind == 1
        errCode3 = 0;
    else
        errCode3 = 1;
    end

    errCode1 = 0;
end 



%Output error message if neccesary

if errCode1 == 1
    warndlg(['The twists associated with wrench 12 and wrench 34 must be on t' ...
        'he same side of wrench 12 and wrench 34.'], '', 'modal')
    uiwait
end

if errCode3 == 1
    warndlg(['The link connecting joint 5 and joint 6 must cross the quadratic ' ...
        'curve exactly once.'], '', 'modal')
    uiwait
end




end