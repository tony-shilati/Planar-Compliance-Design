function [] = UpdateUI(x, y, ax, K, phase)
fig = get(ax, 'parent');

if phase == 1
    drawPoint(x, y, 'P1', ax) %P1 == T12

elseif phase == 2
    drawPoint(x, y, 'P2', ax) %P2 == T34

elseif phase == 3
    drawPoint(x, y, 'N1', ax) %N1 is a handle for w1
    [p1x, p1y] = grabData('P1', ax);
    drawLine([p1x, x], [p1y, y], 'L1', ax) %L1 == w1

elseif phase == 4
    drawPoint(x, y, 'N2', ax) %N2 is a handle for w2
    [p1x, p1y] = grabData('P1', ax);
    drawLine([p1x, x], [p1y, y], 'L2', ax) %L2 == w2

elseif phase == 5 
    drawPoint(x, y, 'N3', ax) %N3 is a handle for w3
    [p2x, p2y] = grabData('P2', ax);
    drawLine([p2x, x], [p2y, y], 'L3', ax) %L3 == w3

elseif phase == 6
    drawPoint(x, y, 'N4', ax) %N4 is a handel for w4
    [p2x, p2y] = grabData('P2', ax);
    drawLine([p2x, x], [p2y, y], 'L4', ax) %L4 == w4

elseif phase == 7 
    drawPoint(x, y, 'P3', ax) %P3 == T56
    drawQuadCurve(ax, K, 1);

elseif phase == 8
    drawPoint(x, y, 'N5', ax) %N5 is a handle for w5
    [p3x, p3y] = grabData('P3', ax);
    drawLine([p3x, x], [p3y, y], 'L5', ax) %L5 == w5

elseif phase == 9
    drawPoint(x, y, 'N6', ax) %N6 is a handle for w6
    [p3x, p3y] = grabData('P3', ax);
    drawLine([p3x, x], [p3y, y], 'L6', ax) %L6 == w6
    %Check if the condition in step 4 of the syntheis is satisfied
    Outputs(ax, K)
    [ec1, ec2, ec3] = checkConditons(K, ax);

    if ec1 == 1
        warndlg(['At least one wrench line must intersect the circle surrounding the compliance center, ' ...
            'and at least one wrench line must not intersect the same circle.'], '', 'modal')
        uiwait 
    end
    
    if ec2 == 1
        warndlg(['The perpendicular vectors from the compliance center to the wrench lines' ...
            'must be distributed between the regions defined by the red lines passing through' ...
            ' the compliance center.'])
        uiwait
    end
    
    if ec3 == 1
        warndlg(['For wrench 5 and wrench 6: one of the wrenches must intersect ' ...
            'the red quadratic curve, and the other wrench must not intersect the ' ...
            'quadratic curve.'])
    end

    set(findobj(fig, 'Tag', 'ent1lab'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'ent2lab'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'ent1'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'ent2'), 'Visible', 'on')


end


end