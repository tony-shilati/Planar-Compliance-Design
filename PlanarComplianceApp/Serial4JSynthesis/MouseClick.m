function [] = MouseClick( obj, ~, ax)

global phase dragN dragL tmpCoor C

fig = get(ax, 'Parent');
pt1x = findobj(fig, 'Tag', 'pt1x');
pt1y = findobj(fig, 'Tag', 'pt1y');
pt2x = findobj(fig, 'Tag', 'pt2x');
pt2y = findobj(fig, 'Tag', 'pt2y');


[x,y] = getCurrentXY(ax);
ylim = get(ax,'ylim');
xlim = get(ax,'xlim');

if y > ylim(2) || y < ylim(1) || x > xlim(2) || x < xlim(1)
    return;
end
if strcmp(get(obj, 'type'), 'axes') || strcmp(get(obj, 'Tag'), 'cl') ...
        || strcmp(get(obj, 'Tag'), 'ccplot') || strcmp(get(obj, 'Tag'), 'cpoint')
    if phase == 1
        drawPoint(x,y,'N1',ax);
        dragN(1) = 1;
        phase = 2;

        %Update interface
        goToPhase(2, ax);


    elseif phase == 2
        [x1,y1] = grabData('N1',ax);
        if x1 ~= x && y1 ~= y
            drawPoint(x,y,'N2',ax);
            drawLine([x1,x],[y1,y],'L1',ax);
            [t1x,t1y] = calcTwist(ax, 'TwistOne');
            drawPoint(t1x,t1y,'P1',ax);
            dragN(2) = 1;
            phase = 3;

            %Update interface
            goToPhase(3, ax);

        end
    elseif phase == 3
        drawPoint(x,y,'N3',ax);
        [t1x,t1y] = grabData('P1',ax);
        drawLine([x,t1x],[y,t1y],'L2',ax);
        [t2x,t2y] = calcTwist(ax, 'TwistTwo');
        drawPoint(t2x,t2y,'P2',ax);
        connectPoints('P1','P2',ax);
        dragN(3) = 1;
        phase = 4;

        %Update interface
        goToPhase(4, ax);

    elseif phase == 4
        drawPoint(x,y,'N5',ax);
        dragN(5) = 1;
        phase = 5;
        
        %Update interface
        goToPhase(5, ax);

    elseif phase == 5
        [x1,y1] = grabData('N5',ax);
        if x1 ~= x && y1 ~= y
            drawPoint(x,y,'N6',ax);
            drawLine([x,x1],[y,y1],'L3',ax);
            [t3x,t3y] = calcTwist(ax, 'TwistThree');
            drawPoint(t3x,t3y,'P3',ax);

            [ec1, ec2, ~] = checkConditions(ax, C);

            if ec1 == 1 || ec2 == 1
                phase = goToPhase(4, ax);
                return
            end


            dragN(6) = 1;
            phase = 6;

            %Update interface
            goToPhase(6, ax);

        end
    elseif phase == 6
        drawPoint(x,y,'N7',ax);
        [t3x,t3y] = grabData('P3',ax);
        drawLine([x,t3x],[y,t3y],'L4',ax);
        [t4x, t4y] = calcTwist(ax, 'TwistFour');
        drawPoint(t4x, t4y, 'P4', ax)
        [xI, yI] = calcIntersections(ax);

        n5 = findobj(ax, 'Tag', 'N5');
        n6 = findobj(ax, 'Tag', 'N6');
        X = str2double(sprintf('%0.1f', x));
        Y = str2double(sprintf('%0.1f', y));
        N5x = str2double(sprintf('%0.1f', n5.XData));
        N5y = str2double(sprintf('%0.1f', n5.YData));
        N6x = str2double(sprintf('%0.1f', n6.XData));
        N6y = str2double(sprintf('%0.1f', n6.YData));


        if all(dragN == 0) && all(dragL == 0)
            if X ~= N5x && X ~= N6x && Y ~= N5y && Y ~= N6y
                [~, ~, ec3] = checkConditions(ax, C);
        
                if ec3 == 1
                    phase = goToPhase(6, ax);
                    return
                end
    
                dragN(7) = 1;
                phase = goToPhase(7, ax);
                
                %Update interface
                set(pt1x, 'String', '')
                set(pt1y, 'String', '')
                set(pt2x, 'String', '')
                set(pt2y, 'String', '')
                set(pt1x, 'Enable', 'off')
                set(pt1y, 'Enable', 'off')
                set(pt2x, 'Enable', 'off')
                set(pt2y, 'Enable', 'off')
        
                [c1, c2, c3, c4, Cmat] = calcCompliance(xI(1), yI(1), xI(2), yI(2), xI(3), yI(3), xI(4), yI(4));
        
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

    
elseif strcmp(get(obj,'tag'),'N1')
    if phase == 2
        phase = goToPhase(2,ax);
        dragN(1) = 1;
        
    elseif phase > 2
        phase = goToPhase(3,ax);
        if phase == 3
            dragN(1) = 1;
        end
    elseif phase == 6
        delete(findobj(ax, 'Tag', 'L4'))
        delete(findobj(ax, 'Tag', 'P4'))
        phase = goToPhase(6,ax);
        dragN(1) = 1;
    end
    
elseif strcmp(get(obj,'tag'),'N2')
    delete(findobj(ax, 'Tag', 'L4'))
    delete(findobj(ax, 'Tag', 'P4'))
    phase = goToPhase(3,ax);
    if phase == 3
        dragN(2) = 1;
    end
    if phase == 6
        delete(findobj(ax, 'Tag', 'L4'))
        delete(findobj(ax, 'Tag', 'P4'))
        phase = goToPhase(6,ax);
        dragN(2) = 1;
    end
    
elseif strcmp(get(obj,'tag'),'N3')
    delete(findobj(ax, 'Tag', 'L4'))
    delete(findobj(ax, 'Tag', 'P4'))
    phase = goToPhase(4,ax);
    if phase == 4
        dragN(3) = 1;
    end

    if phase == 6
        delete(findobj(ax, 'Tag', 'L4'))
        delete(findobj(ax, 'Tag', 'P4'))
        phase = goToPhase(6,ax);
        dragN(3) = 1;
    end
    
elseif strcmp(get(obj,'tag'),'N5')
    delete(findobj(ax, 'Tag', 'L4'))
    delete(findobj(ax, 'Tag', 'P4'))
    if phase == 5
        dragN(5) = 1;
    else
        phase = goToPhase(6,ax);
        if phase == 6
            dragN(5) = 1;
        end
    end
    
elseif strcmp(get(obj,'tag'),'N6')
    delete(findobj(ax, 'Tag', 'L4'))
    delete(findobj(ax, 'Tag', 'P4'))
    phase = goToPhase(6,ax);
    if phase == 6
        dragN(6) = 1;
    end
    
elseif strcmp(get(obj,'tag'),'N7')
    phase = goToPhase(7,ax);
    if phase == 7
        dragN(7) = 1;
    end
    
elseif strcmp(get(obj,'tag'),'L1')
    delete(findobj(ax, 'Tag', 'L4'))
    delete(findobj(ax, 'Tag', 'P4'))
    phase = goToPhase(3,ax);
    if phase == 3
        dragL(1) = 1;
        tmpCoor = [x,y];
    end

    if phase == 6
        delete(findobj(ax, 'Tag', 'L4'))
        delete(findobj(ax, 'Tag', 'P4'))
        phase = goToPhase(6,ax);
        dragL(1) = 1;
    end
    
elseif strcmp(get(obj,'tag'),'L2')
    delete(findobj(ax, 'Tag', 'L4'))
    delete(findobj(ax, 'Tag', 'P4'))
    phase = goToPhase(4,ax);
    if phase == 4
        dragL(2) = 1;
        tmpCoor = [x,y];
    end

    if phase == 6
        delete(findobj(ax, 'Tag', 'L4'))
        delete(findobj(ax, 'Tag', 'P4'))
        phase = goToPhase(6,ax);
        dragL(2) = 1;
    end
    
elseif strcmp(get(obj,'tag'),'L3')
    delete(findobj(ax, 'Tag', 'L4'))
    delete(findobj(ax, 'Tag', 'P4'))
    phase = goToPhase(6,ax);
    if phase == 6
        delete(findobj(ax, 'Tag', 'L4'))
        delete(findobj(ax, 'Tag', 'P4'))
        phase = goToPhase(6,ax);
        dragL(3) = 1;
        tmpCoor = [x,y];
    end

    
    
% elseif strcmp(get(obj,'tag'),'L4')
%     phase = goToPhase(7,ax);
%     if phase == 7
%         dragL(4) = 1;
%         tmpCoor = [x,y];
%     end
    
end

end
