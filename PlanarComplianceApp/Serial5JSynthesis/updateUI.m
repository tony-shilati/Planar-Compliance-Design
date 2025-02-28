function [] = updateUI(x, y, ax, C, phase)

if phase == 1
    drawPoint(x, y, 'N1', ax)

elseif phase == 2
    [n1x, n1y] = grabData('N1', ax);
    drawPoint(x, y, 'N2', ax)
    x1 = [x, n1x]; y1 = [y, n1y];
    drawLine(x1, y1, 'L1', ax)
    [~, ~, ~, r] = twistFromLine(ax, 'T1', C);
    drawPoint(r(1), r(2), 'P1', ax)

elseif phase == 3
    drawPoint(x, y, 'N3', ax)

elseif phase == 4
    drawPoint(x, y, 'N4', ax)
    [n3x, n3y] = grabData('N3', ax);
    x1 = [x, n3x]; y1 = [y, n3y];
    drawLine(x1, y1, 'L2', ax)
    [~, ~, ~, r] = twistFromLine(ax, 'T2', C);
    drawPoint(r(1), r(2), 'P2', ax)

elseif phase == 5
    drawPoint(x, y, 'P3', ax)
    %Check that condition is satisfied

elseif phase == 6
    drawPoint(x,y,'N5',ax)

elseif phase == 7
    drawPoint(x,y,'N6',ax)
    [n5x,n5y] = grabData('N5', ax);
    x1 = [x, n5x]; y1 = [y, n5y];
    drawLine(x1, y1, 'L3', ax)

    %Draw P4 from L3
    [~, ~, ~, r] = twistFromLine(ax, 'T3', C);
    [j5x, j5y] = grabData('P3', ax);
    drawPoint(r(1), r(2), 'P4', ax)

    x2 = [j5x, r(1)]; y2 = [j5y, r(2)];
    %Plot line lp through J5 and P4
    drawLine(x2, y2, 'PL', ax)

    %Calculate the distance ratio from the paper, plot point P on line lp
    calcDistanceRatio(ax, C)

elseif phase == 8
    drawPoint(x, y, 'N7', ax)
    %Draw the line through PP and N7
    [ppx, ppy] = grabData('P6P', ax);

    x1 = [x, ppx]; y1 = [y, ppy];
    drawLine(x1, y1, 'L4', ax)

    %Draw the Joints
    calcJoints(ax)
    outputs(ax, C)


end

    
end

