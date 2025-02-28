function [] = MouseDrag(~, ~, ax)

global phase dragN dragL tmpCoor K

fig = get(ax, 'Parent');

%find the current position of the cursor
[x, y] = getCurrentXY(ax);


%find the boundaries of the axes in the figure
ylim = get(ax,'ylim');
xlim = get(ax,'xlim');

%if the cursor is in bounds of the axes on the figure
if xlim(1) < x && x < xlim(2) && ylim(1) < y && y< ylim (2)

    %delete the children of axes with the tag 'xy'
    delete(findobj(ax, 'tag', 'xy'))

    %find children of the figure with the given tags
    xpos = findobj(fig, 'tag', 'xpos');
    ypos = findobj(fig, 'tag', 'ypos');

    %Change the number of decimals to 2
    xpos1 = sprintf('%0.2f', x);
    ypos1 = sprintf('%0.2f', y);

    %Display the x and y values on the gui
    set(xpos, 'String', xpos1);
    set(ypos, 'String', ypos1);

end 


if any(dragN)
    
    if phase == 2
        if dragN(1) == 1
            drawPoint(x,y,'N1',ax);
            [x1,y1,~] = generateLine(x,y, ax, K);
            drawLine(x1,y1,'L1',ax);
        end
    elseif phase == 3
        if dragN(2) == 1
            drawPoint(x,y,'N2',ax);
            [x1,y1,~] = generateLine(x,y, ax, K);
            drawLine(x1,y1,'L2',ax);
        end
    elseif phase == 4
        if dragN(3) == 1
            drawPoint(x,y,'N3',ax);
        end
    elseif phase == 5
        if dragN(3) == 1
            [ec1, ~] = checkConditions(ax);
            if ec1 == 1
                phase = goToPhase(3, ax);
                MouseRelease(0,0)
                
                return
            end

            drawPoint(x,y,'N3',ax);
            [x2,y2] = grabData('N4',ax);
            drawLine([x,x2],[y,y2],'L3',ax);
            [p3x,p3y] = calcTwist(ax, 'P3', K);
            drawPoint(p3x,p3y,'P3',ax);

        elseif dragN(4) == 1

            [ec1, ~] = checkConditions(ax);
            if ec1 == 1
                phase = goToPhase(3, ax);
                MouseRelease(0,0)
                
                return
            end

            drawPoint(x,y,'N4',ax);
            [x1,y1] = grabData('N3',ax);
            drawLine([x1,x],[y1,y],'L3',ax);
            [p3x,p3y] = calcTwist(ax, 'P3', K);
            drawPoint(p3x,p3y,'P3',ax);
        end
    elseif phase == 6
        if dragN(5) == 1

            [~, ec2] = checkConditions(ax);
            if ec2 == 1
                phase = goToPhase(5, ax);
                MouseRelease(0,0)
                
                return
            end

            drawPoint(x,y,'N5',ax);
            [x1,y1,~] = generateLine(x,y, ax, K);
            drawLine(x1,y1,'L4',ax);
            calcRatio(ax);
            
        end
    elseif phase == 7
        if dragN(6) == 1

            [x,y] = closestPoint(x,y,'V1',ax);
            drawPoint(x,y,'N6',ax);
            calcIntersections(ax);
            Outputs(ax, 'l');
        end
    end
end

if any(dragL)
    
    [x,y] = getCurrentXY(ax);
    
    if dragL(1) == 1

        [ec1, ~] = checkConditions(ax);
        if ec1 == 1
           
            phase = goToPhase(3, ax);
            MouseRelease(0,0)
            return
        end
        
        dx = x-tmpCoor(1);
        dy = y-tmpCoor(2);
        
        [x1,y1] = grabData('N3',ax);
        [x2,y2] = grabData('N4',ax);
        drawLine([x1,x2]+dx,[y1,y2]+dy,'L3',ax);
        drawPoint(x1+dx,y1+dy,'N3',ax);
        drawPoint(x2+dx,y2+dy,'N4',ax);
        [p3x,p3y] = calcTwist(ax, 'P3', K);
        drawPoint(p3x,p3y,'P3',ax);
        
        tmpCoor = [x,y];
        
    end
    
end

