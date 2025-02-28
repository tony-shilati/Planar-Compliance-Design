function [] = UpdateUI(ax, C, x, y, phase)

if phase == 1
    drawPoint(ax, 'N2', x, y)
    [n1x, n1y] = grabData('N1', ax);
    drawLine([x, n1x], [y, n1y], 'L1', ax)
    [~, ~, ~, r12] = twistFromLine(ax, 'T1', C);
    drawPoint(ax, 'P1', r12(1), r12(2))

elseif phase == 2
    drawPoint(ax, 'N3', x, y)

elseif phase == 3
    drawPoint(ax, 'N4', x, y)
    [n3x, n3y] = grabData('N3', ax);
    drawLine([x, n3x], [y, n3y], 'L2', ax)
    [~, ~, ~, r34] = twistFromLine(ax, 'T2', C);
    drawPoint(ax, 'P2', r34(1), r34(2))
    drawPoint(ax, 'J1', 0, 0)

elseif phase == 4
    [l1x, l1y] = grabData('L1', ax);
    m1 = (l1y(1) - l1y(2)) / (l1x(1) - l1x(2));
    [ix2, iy2] = perpIntersect(l1x(1), l1y(1), m1, x, y);
    drawPoint(ax, 'J2', ix2, iy2)

elseif phase == 5
    [l2x, l2y] = grabData('L2', ax);
    m2 = (l2y(1) - l2y(2)) / (l2x(1) - l2x(2));
    [ix3, iy3] = perpIntersect(l2x(1), l2y(1), m2, x, y);
    drawPoint(ax, 'J3', ix3, iy3)

elseif phase == 6
    [l2x, l2y] = grabData('L2', ax);
    m2 = (l2y(1) - l2y(2)) / (l2x(1) - l2x(2));
    [ix4, iy4] = perpIntersect(l2x(1), l2y(1), m2, x, y);
    drawPoint(ax, 'J4', ix4, iy4)
    drawQuadCurve(ax, C, 1);

elseif phase == 7 
    drawPoint(ax, 'J5', x, y)

elseif phase == 8
    drawPoint(ax, 'J6', x, y)
    connectJoints(ax)
    Outputs(ax, C)

elseif phase == 9 


end


end