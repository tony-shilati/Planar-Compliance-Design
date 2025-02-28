function updateUI(x, y, ax, K, phase)

if phase == 1
    drawPoint(x,y,'N1',ax);
    [x1,y1,~] = generateLine(x, y, ax, K);
    drawLine(x1,y1,'L1',ax);

elseif phase == 2
    drawPoint(x,y,'N2',ax);
    [x1,y1,~] = generateLine(x, y, ax, K);
    drawLine(x1,y1,'L2',ax);

elseif phase == 3
    drawPoint(x,y,'N3',ax);

elseif phase == 4
    [x1,y1] = grabData('N3',ax);
    drawPoint(x,y,'N4',ax);
    drawLine([x1,x],[y1,y],'L3',ax);
    [p3x,p3y] = calcTwist(ax, 'P3', K);
    drawPoint(p3x,p3y,'P3',ax);
    

elseif phase == 5
    % Calculate y5 > h5 > line of interest (LP)
    drawPoint(x,y,'N5',ax);
    [x1,y1,~] = generateLine(x, y, ax, K);
    drawLine(x1,y1,'L4',ax);
    calcRatio(ax);
    goToPhase(6, ax);

elseif phase == 6

elseif phase == 7
    [x,y] = closestPoint(x,y,'V1',ax);
    drawPoint(x,y,'N6',ax);
    Outputs(ax, 'l');
    goToPhase(7, ax);


end