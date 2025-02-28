function [] = MouseClick( obj, ~, ax)

global phase dragN dragL tmpCoor K

tag = get(obj, 'Tag');

[x,y] = getCurrentXY(ax);
ylim = get(ax,'ylim');
xlim = get(ax,'xlim');

if y > ylim(2) || y < ylim(1) || x > xlim(2) || x < xlim(1)
    return;
end

if strcmp(get(obj,'type'),'axes') || (~strcmp(tag, 'N1') ...
        && ~strcmp(tag, 'N2') && ~strcmp(tag, 'N3') ...
        && ~strcmp(tag, 'N4') && ~strcmp(tag, 'N5') ...
        && ~strcmp(tag, 'L1') && ~strcmp(tag, 'L3'))
    
    if phase == 1
        drawPoint(x,y,'N1',ax);
        [x1,y1,~] = generateLine(x,y,K, ax);
        drawLine(x1,y1,'L1',ax);
        dragN(1) = 1;
        phase = 2;
        goToPhase(2, ax);
        
    elseif phase == 2
        % Do Nothing
    elseif phase == 3
        % Click N3
        drawPoint(x,y,'N3',ax);
        dragN(3) = 1;
        phase = 4;
        goToPhase(4, ax);
    elseif phase == 4
        drawPoint(x,y,'N4',ax);
        [x3,y3] = grabData('N3',ax);
        drawLine([x,x3],[y,y3],'L3',ax);
        [x,y] = calcP3(ax);
        drawPoint(x,y,'P3',ax);
        
        [ec1, ec2] = checkConditions(ax, K);
        if ec1 == 1 || ec2 == 1
            phase = goToPhase(3, ax);
            return
        end

        dragN(4) = 1;
        phase = 5;
        goToPhase(5, ax);
        
    end
    
elseif strcmp(get(obj,'tag'),'N1')
    phase = goToPhase(2,ax);
    dragN(1) = 1;
    
elseif strcmp(get(obj,'tag'),'N2')
    phase = goToPhase(3,ax);
    if phase == 3
        dragN(2) = 1;
    end
    
elseif strcmp(get(obj,'tag'),'N3')
    dragN(3) = 1;
    
elseif strcmp(get(obj,'tag'),'N4')
    phase = goToPhase(5,ax);
    dragN(4) = 1;

elseif strcmp(get(obj,'tag'),'N5')
    
    phase = goToPhase(6,ax);
    dragN(5) = 1;
    
elseif strcmp(get(obj,'tag'),'L1')

    [x,y] = closestPoint(x,y,'L1',ax);
    drawPoint(x,y,'N2',ax);
    [x2,y2,~] = generateLine(x,y,K,ax);
    drawLine(x2,y2,'L2',ax);
    connectPoints('N1','N2',ax);
    
    dragN(2) = 1;
    tmpCoor = [x,y];
    phase = goToPhase(3, ax);
    
    
elseif strcmp(get(obj,'tag'),'L3')
    
    [xmin,xmax] = getP4Limits(ax);
    [x,y] = closestPoint(x,y,'L3',ax);
    
    if x > xmin && x < xmax && phase == 5
        drawPoint(x,y,'N5',ax);
        calcIntersections(ax);
        dragN(5) = 1;
        phase = goToPhase(6, ax);
        Outputs(ax, 'l');
        
        
    else
        phase = goToPhase(6,ax);
        dragL(3) = 1;
        tmpCoor = [x,y];
    end

end
