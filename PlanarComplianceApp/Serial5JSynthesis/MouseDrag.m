function [] = MouseDrag(~, ~, ax)

global phase dragN dragL C

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

    if phase == 2
        if dragN(1) == 1
            updateUI(x, y, ax, C, 1)
        end

    elseif phase == 3
        if dragN(2) == 1
            updateUI(x, y, ax, C, 2)

        elseif dragN(1) == 1
            [n2x, n2y] = grabData('N2', ax);
            drawPoint(x, y, 'N1', ax)
            x1 = [x, n2x]; y1 = [y, n2y];
            drawLine(x1, y1, 'L1', ax)
            [~, ~, ~, r] = twistFromLine(ax, 'T1', C);
            drawPoint(r(1), r(2), 'P1', ax)
        end

    elseif phase == 4
        if dragN(3) == 1
            updateUI(x, y, ax, C, 3)
        end

    elseif phase == 5
        if dragN(4) == 1
            updateUI(x, y, ax, C, 4)

        elseif dragN(3) == 1
            drawPoint(x, y, 'N3', ax)
            [n4x, n4y] = grabData('N4', ax);
            x1 = [x, n4x]; y1 = [y, n4y];
            drawLine(x1, y1, 'L2', ax)
            [~, ~, ~, r] = twistFromLine(ax, 'T2', C);
            drawPoint(r(1), r(2), 'P2', ax)
        end

    elseif phase == 7
        if dragN(5) == 1
            updateUI(x, y, ax, C, 6)
        end

    elseif phase == 8
        if dragN(6) == 1
            delete(findall(ax, 'Tag', 'text'))
            updateUI(x, y, ax, C, 7)

        elseif dragN(5) == 1
            delete(findall(ax, 'Tag', 'text'))
            drawPoint(x,y,'N5',ax)
            [n6x,n6y] = grabData('N6', ax);
            x1 = [x, n6x]; y1 = [y, n6y];
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

        end

    elseif phase == 9 
        if dragN(7) == 1
            delete(findall(ax, 'Tag', 'text'))
            updateUI(x, y, ax, C, 8)
            checkCondintions(ax, C);
            
            
        end

    end

end


if any(dragL)
    if phase == 3
        if dragL(1) == 1
            [n1x, n1y] = grabData('N1', ax);
            [n2x, n2y] = grabData('N2', ax);
            ml1 = (n1y - n2y) / (n1x - n2x);

            [h1x, h1y] = perpIntersect(x, y, ml1, n1x, n1y);
            [h2x, h2y] = perpIntersect(x, y, ml1, n2x, n2y);

            drawPoint(h1x, h1y, 'N1', ax)
            drawPoint(h2x, h2y, 'N2', ax)
            dragPlot(ax, 'L1', ml1, h1x, h1y)
            [~, ~, ~, r] = twistFromLine(ax, 'T1', C);
            drawPoint(r(1), r(2), 'P1', ax)

        end

    elseif phase == 5
        if dragL(2) == 1
            [n3x, n3y] = grabData('N3', ax);
            [n4x, n4y] = grabData('N4', ax);
            ml2 = (n3y - n4y) / (n3x - n4x);

            [h3x, h3y] = perpIntersect(x, y, ml2, n3x, n3y);
            [h4x, h4y] = perpIntersect(x, y, ml2, n4x, n4y);

            drawPoint(h3x, h3y, 'N3', ax)
            drawPoint(h4x, h4y, 'N4', ax)
            dragPlot(ax, 'L2', ml2, h3x, h3y)
            [~, ~, ~, r] = twistFromLine(ax, 'T2', C);
            drawPoint(r(1), r(2), 'P2', ax)

        end

    elseif phase == 8
        if dragL(3) == 8
            delete(findall(ax, 'Tag', 'text'))
            [n5x, n5y] = grabData('N5', ax);
            [n6x, n6y] = grabData('N6', ax);
            ml3 = (n5y - n6y) / (n5x - n6x);
            
            [h5x, h5y] = perpIntersect(x, y, ml3, n5x, n5y);
            [h6x, h6y] = perpintersect(x, y, ml3, n6x, n6y);

            drawPoint(h5x, h5y, 'N5', ax)
            drawPoint(h6x, h6y, 'N6', ax)
            dragPlot(ax, 'L3', ml3, h5x, h5y)
            [~, ~, ~, r] = twistFromLine(ax, 'T3', C);
            drawPoint(r(1), r(2), 'P2', ax)

            x2 = [j5x, r(1)]; y2 = [j5y, r(2)];
            %Plot line lp through J5 and P4
            drawLine(x2, y2, 'PL', ax)
        
            %Calculate the distance ratio from the paper, plot point P on line lp
            calcDistanceRatio(ax, C)


        end 

    end 

end

end