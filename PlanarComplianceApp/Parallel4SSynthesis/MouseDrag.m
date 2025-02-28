function [] = MouseDrag(~, ~, ax)

global phase dragN dragL tmpCoor K


fig = get(ax, 'Parent');

%find the current position of the cursor
[x, y] = getCurrentXY(ax);

%Get acces to the coordinate input boxes
pt1x = findobj(fig, 'Tag', 'pt1x');
pt1y = findobj(fig, 'Tag', 'pt1y');
pt2x = findobj(fig, 'Tag', 'pt2x');
pt2y = findobj(fig, 'Tag', 'pt2y');

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
    
    [x,y] = getCurrentXY(ax);
    if phase == 2
        if dragN(1) == 1
            drawPoint(x,y,'N1',ax);
            [x1,y1,~] = generateLine(x,y,K,ax);
            drawLine(x1,y1,'L1',ax);

            
        end
    elseif phase == 3
        if dragN(2) == 1
            %fun = makeFuncFromLine('L1',ax);
            %y = fun(x);
            [x,y] = closestPoint(x,y,'L1',ax);
            drawPoint(x,y,'N2',ax);
            [x2,y2,~] = generateLine(x,y,K,ax);
            drawLine(x2,y2,'L2',ax);
            connectPoints('N1','N2',ax);
        end
    elseif phase == 4
        if dragN(3) == 1
            drawPoint(x,y,'N3',ax);
        end
    elseif phase == 5
        if dragN(3) == 1

            [ec1, ec2] = checkConditions(ax, K);
            if ec1 == 1 || ec2 == 1
                MouseRelease(0, 0)
                phase = goToPhase(3, ax);
                return
            end

            drawPoint(x,y,'N3',ax);
            [x4,y4] = grabData('N4',ax);
            drawLine([x,x4],[y,y4],'L3',ax);
            [x,y] = calcP3(ax);
            drawPoint(x,y,'P3',ax);
            
            
        elseif dragN(4) == 1

            [ec1, ec2] = checkConditions(ax, K);
            if ec1 == 1 || ec2 == 1
                MouseRelease(0, 0)
                phase = goToPhase(3, ax);
                return
            end

            drawPoint(x,y,'N4',ax);
            [x3,y3] = grabData('N3',ax);
            drawLine([x,x3],[y,y3],'L3',ax);
            [x,y] = calcP3(ax);
            drawPoint(x,y,'P3',ax);

            
        end
    elseif phase == 6
        if dragN(5) == 1

            delete(findall(ax,'tag','J4'));
            [x,y] = closestPoint(x,y,'L3',ax);
            [xmin,xmax] = getP4Limits(ax);
            
            if x > xmin && x < xmax
                drawPoint(x,y,'N5',ax);
                calcIntersections(ax);
                Outputs(ax, 'l');
            end
        end
        
    end
end

if any(dragL)
    
    [x,y] = getCurrentXY(ax);
    
    if dragL(3) == 1

        [ec1, ec2] = checkConditions(ax, K);
        if ec1 == 1 || ec2 == 1
            MouseRelease(0, 0)
            phase = goToPhase(3, ax);
            return
        end
        
        dx = x-tmpCoor(1);
        dy = y-tmpCoor(2);
        
        [x1,y1] = grabData('N3',ax);
        [x2,y2] = grabData('N4',ax);
        drawLine([x1,x2]+dx,[y1,y2]+dy,'L3',ax);
        drawPoint(x1+dx,y1+dy,'N3',ax);
        drawPoint(x2+dx,y2+dy,'N4',ax);
        [p1x,p1y] = calcP3(ax);
        drawPoint(p1x,p1y,'P3',ax);

        
        tmpCoor = [x,y];
        
    end
    
end

end

