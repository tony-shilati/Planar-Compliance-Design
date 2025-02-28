function [] = MouseDrag( ~, ~, ax)

global phase dragN dragL tmpCoor C

fig = get(ax, 'Parent');

xlim = get(ax, 'xlim');
ylim = get(ax, 'ylim');
[x, y] = getCurrentXY(ax);

if x > xlim(1) && x < xlim(2) && y > ylim(1) && y < ylim(2)
    X = sprintf('%0.3f', x);
    Y = sprintf('%0.3f', y);
    xpos = findobj(fig, 'Tag', 'xpos');
    ypos = findobj(fig, 'Tag', 'ypos');
    set(xpos, 'String', X)
    set(ypos, 'String', Y)
end

if any(dragN)
    
    [x,y] = getCurrentXY(ax);
    if phase == 2
        if dragN(1) == 1
            drawPoint(x,y,'N1',ax);
        end
    elseif phase == 3
        if dragN(1) == 1
            drawPoint(x,y,'N1',ax);
            [x2,y2] = grabData('N2',ax);
            drawLine([x,x2],[y,y2],'L1',ax);
            [p1x,p1y] = calcTwist(ax, 'TwistOne');
            drawPoint(p1x,p1y,'P1',ax);
        elseif dragN(2) == 1
            drawPoint(x,y,'N2',ax);
            [x1,y1] = grabData('N1',ax);
            drawLine([x1,x],[y1,y],'L1',ax);
            [p1x,p1y] = calcTwist(ax, 'TwistOne');
            drawPoint(p1x,p1y,'P1',ax);
        end
    elseif phase == 4
        if dragN(3) == 1
            drawPoint(x,y,'N3',ax);
            [p1x,p1y] = grabData('P1',ax);
            drawLine([x,p1x],[y,p1y],'L2',ax);
            [p2x,p2y] = calcTwist(ax, 'TwistTwo');
            drawPoint(p2x,p2y,'P2',ax);
            connectPoints('P1','P2',ax);
        end
    elseif phase == 5
        if dragN(5) == 1
            drawPoint(x,y,'N5',ax);
            
            try
                [ec1, ec2, ~] = checkConditions(ax, C);
    
                if ec1 == 1 || ec2 == 1
                    MouseRelease(0, 0)
                    phase = goToPhase(4, ax);
                    return
    
                end
            catch
            end
        end
    elseif phase == 6
        if dragN(5) == 1

            [ec1, ec2, ~] = checkConditions(ax, C);

            if ec1 == 1 || ec2 == 1
                MouseRelease(0, 0)
                phase = goToPhase(4, ax);
                return

            end

            drawPoint(x,y,'N5',ax);
            [x2,y2] = grabData('N6',ax);
            drawLine([x,x2],[y,y2],'L3',ax);
            [p3x,p3y] = calcTwist(ax, 'TwistThree');
            drawPoint(p3x,p3y,'P3',ax);

        elseif dragN(6) == 1

            [ec1, ec2, ~] = checkConditions(ax, C);
            if ec1 == 1 || ec2 == 1
                MouseRelease(0, 0)
                phase = goToPhase(4, ax);
                return

            end
            
            drawPoint(x,y,'N6',ax);
            [x1,y1] = grabData('N5',ax);
            drawLine([x1,x],[y1,y],'L3',ax);
            [p3x,p3y] = calcTwist(ax, 'TwistThree');
            drawPoint(p3x,p3y,'P3',ax);
        end
        
    elseif phase == 7
        if dragN(7) == 1
            
            [~, ~, ec3] = checkConditions(ax, C);

            if ec3 == 1
                MouseRelease(0, 0)
                phase = goToPhase(6, ax);
                return
            end

            drawPoint(x,y,'N7',ax);
            [p3x,p3y] = grabData('P3',ax);
            drawLine([x,p3x],[y,p3y],'L4',ax);
            [t4x, t4y] = calcTwist(ax, 'TwistFour');
            drawPoint(t4x, t4y, 'P4', ax)
            [X, Y] = calcIntersections(ax);

            [c1, c2, c3, c4, Cmat] = calcCompliance(X(1,1), Y(1,1), X(1,2), Y(1,2), X(1,3), Y(1,3), X(1,4), Y(1,4));

            Cout = findobj(fig, 'Tag', 'Cout');
            set(Cout, 'Data', Cmat)
            comp1 = findobj(fig, 'Tag', 'comp1');
            comp2 = findobj(fig, 'Tag', 'comp2');
            comp3 = findobj(fig, 'Tag', 'comp3');
            comp4 = findobj(fig, 'Tag', 'comp4');

            C1 = sprintf('%0.4f', c1);
            C2 = sprintf('%0.4f', c2);
            C3 = sprintf('%0.4f', c3);
            C4 = sprintf('%0.4f', c4);

            set(comp1, 'String', C1)
            set(comp2, 'String', C2)
            set(comp3, 'String', C3)
            set(comp4, 'String', C4)


        end
    end
end
    
if any(dragL)
    
    [x,y] = getCurrentXY(ax);
    
    if dragL(1) == 1
       
        dx = x-tmpCoor(1);
        dy = y-tmpCoor(2);
        
        [x1,y1] = grabData('N1',ax);
        [x2,y2] = grabData('N2',ax);
        drawLine([x1,x2]+dx,[y1,y2]+dy,'L1',ax);
        drawPoint(x1+dx,y1+dy,'N1',ax);
        drawPoint(x2+dx,y2+dy,'N2',ax);
        [p1x,p1y] = calcTwist(ax, 'TwistOne');
        drawPoint(p1x,p1y,'P1',ax);
        
        tmpCoor = [x,y];
        

        
    elseif dragL(3) == 1
        [ec1, ec2, ~] = checkConditions(ax, C);

        if ec1 == 1 || ec2 == 1
            MouseRelease(0, 0)
            phase = goToPhase(4, ax);
            return

        end

        
        dx = x-tmpCoor(1);
        dy = y-tmpCoor(2);
        
        [x1,y1] = grabData('N5',ax);
        [x2,y2] = grabData('N6',ax);
        drawLine([x1,x2]+dx,[y1,y2]+dy,'L3',ax);
        drawPoint(x1+dx,y1+dy,'N5',ax);
        drawPoint(x2+dx,y2+dy,'N6',ax);
        [p3x,p3y] = calcTwist(ax, 'TwistThree');
        drawPoint(p3x,p3y,'P3',ax);
        
        tmpCoor = [x,y];
        
    end
    
end

end

