function [] = MouseDrag(~, ~, ax)

global C phase dragN dragL

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

   if dragN(2) == 1
        drawPoint(ax, 'N2', x, y)
        [n1x, n1y] = grabData('N1', ax);
        drawLine([x, n1x], [y, n1y], 'L1', ax)
        [~, ~, ~, r1] = twistFromLine(ax, 'T1', C);
        drawPoint(ax, 'P1', r1(1), r1(2))

        if phase >= 4
            phase = goToPhase(4, ax);
        else
            phase = goToPhase(2, ax);
        end
        

    elseif dragN(3) == 1
        if phase == 3
            phase = goToPhase(4, ax);
            drawPoint(ax, 'N3', x, y)
        elseif phase >= 4
            drawPoint(ax, 'N3', x, y)
            [n4x, n4y] = grabData('N4', ax);
            drawLine([x, n4x], [y, n4y], 'L2', ax)
            [~, ~, ~, r2] = twistFromLine(ax, 'T2', C);
            drawPoint(ax, 'P2', r2(1), r2(2))
            phase = goToPhase(4, ax);
        end

    elseif dragN(4) == 1
        drawPoint(ax, 'N4', x, y)
        [n3x, n3y] = grabData('N3', ax);
        drawLine([x, n3x], [y, n3y], 'L2', ax)
        [~, ~, ~, r2] = twistFromLine(ax, 'T2', C);
        drawPoint(ax, 'P2', r2(1), r2(2))
        phase = goToPhase(4, ax);

    elseif dragN(5) == 1
        if phase < 7
            phase = goToPhase(5, ax);
            [l1x, l1y] = grabData('L1', ax);
            m1 = (l1y(1) - l1y(2)) / (l1x(1) - l1x(2));
            [ix1, iy1] = perpIntersect(l1x(1), l1y(1), m1, x, y);
            drawPoint(ax, 'J2', ix1, iy1)

        elseif phase >= 7 && phase < 9
            phase = goToPhase(7, ax);
            [l1x, l1y] = grabData('L1', ax);
            m1 = (l1y(1) - l1y(2)) / (l1x(1) - l1x(2));
            [ix1, iy1] = perpIntersect(l1x(1), l1y(1), m1, x, y);
            drawPoint(ax, 'J2', ix1, iy1)
            drawQuadCurve(ax, C, 1);

            
        else
            [l1x, l1y] = grabData('L1', ax);
            [j1x, j1y] = grabData('J1', ax);
            [j3x, j3y] = grabData('J3', ax);

            m1 = (l1y(1) - l1y(2)) / (l1x(1) - l1x(2));
            [ix1, iy1] = perpIntersect(l1x(1), l1y(1), m1, x, y);

            drawLine([ix1, j1x], [iy1, j1y], 'C1', ax)
            drawLine([ix1, j3x], [iy1, j3y], 'C2', ax)

            delete(findobj(ax, 'Tag', 'text2'))
            text(ix1, iy1, '  J2', 'FontSize', 10, 'Tag', 'text2')
            drawPoint(ax, 'J2', ix1, iy1)

            drawQuadCurve(ax, C, 1);
            Outputs(ax, C);

        end

    elseif dragN(6) == 1
        if phase < 7 
            phase = goToPhase(6, ax);
            [l2x, l2y] = grabData('L2', ax);
            m2 = (l2y(1) - l2y(2)) / (l2x(1) - l2x(2));
            [ix2, iy2] = perpIntersect(l2x(1), l2y(1), m2, x, y);
            drawPoint(ax, 'J3', ix2, iy2)

        elseif phase >= 7 && phase < 9
            phase = goToPhase(7, ax);
            [l2x, l2y] = grabData('L2', ax);
            m2 = (l2y(1) - l2y(2)) / (l2x(1) - l2x(2));
            [ix2, iy2] = perpIntersect(l2x(1), l2y(1), m2, x, y);
            drawPoint(ax, 'J3', ix2, iy2)
            drawQuadCurve(ax, C, 1);
            
        else
            [l2x, l2y] = grabData('L2', ax);
            [j2x, j2y] = grabData('J2', ax);
            [j4x, j4y] = grabData('J4', ax);

            m2 = (l2y(1) - l2y(2)) / (l2x(1) - l2x(2));
            [ix2, iy2] = perpIntersect(l2x(1), l2y(1), m2, x, y);

            drawLine([ix2, j2x], [iy2, j2y], 'C2', ax)
            drawLine([ix2, j4x], [iy2, j4y], 'C3', ax)

            delete(findobj(ax, 'Tag', 'text3'))
            text(ix2, iy2, '  J3', 'FontSize', 10, 'Tag', 'text3')
            drawPoint(ax, 'J3', ix2, iy2)

            drawQuadCurve(ax, C, 1);
            Outputs(ax, C);

        end

    elseif dragN(7) == 1
        if phase < 9 
            phase = goToPhase(7, ax);
            [l2x, l2y] = grabData('L2', ax);
            m2 = (l2y(1) - l2y(2)) / (l2x(1) - l2x(2));
            [ix3, iy3] = perpIntersect(l2x(1), l2y(1), m2, x, y);
            drawPoint(ax, 'J4', ix3, iy3)
            drawQuadCurve(ax, C, 1);
            
        else
            [l2x, l2y] = grabData('L2', ax);
            [j3x, j3y] = grabData('J3', ax);
            [j5x, j5y] = grabData('J5', ax);

            m2 = (l2y(1) - l2y(2)) / (l2x(1) - l2x(2));
            [ix3, iy3] = perpIntersect(l2x(1), l2y(1), m2, x, y);

            drawLine([ix3, j3x], [iy3, j3y], 'C3', ax)
            drawLine([ix3, j5x], [iy3, j5y], 'C4', ax)

            delete(findobj(ax, 'Tag', 'text4'))
            text(ix3, iy3, '  J4', 'FontSize', 10, 'Tag', 'text4')
            drawPoint(ax, 'J4', ix3, iy3)

            drawQuadCurve(ax, C, 1);
            Outputs(ax, C);

        end

    elseif dragN(8) == 1
        [j4x, j4y] = grabData('J4', ax);
        [j6x, j6y] = grabData('J6', ax);
        drawLine([x, j4x], [y, j4y], 'C4', ax)
        drawLine([x, j6x], [y, j6y], 'C5', ax)

        drawPoint(ax, 'J5', x, y)
        drawPoint(ax, 'J4', j4x, j4y)
        drawPoint(ax, 'J6', j6x, j6y)
        Outputs(ax, C)

        delete(findobj(ax, 'Tag', 'text5'))
        text(x, y, '  J5', 'FontSize', 10, 'Tag', 'text5')


    elseif dragN(9) == 1
        [j5x, j5y] = grabData('J5', ax);
        drawLine([x, j5x], [y, j5y], 'C5', ax)
        drawPoint(ax, 'J5', j5x, j5y)
        drawPoint(ax, 'J6', x, y)

        Outputs(ax, C)

        delete(findobj(ax, 'Tag',  'text6'))
        text(x, y, '  J6', 'FontSize', 10, 'Tag', 'text6')
    end

end


if any(dragL)

    if dragL(2) == 1
        [n3x, n3y] = grabData('N3', ax);
        [n4x, n4y] = grabData('N4', ax);
        ml2 = (n3y - n4y) / (n3x - n4x);

        [h3x, h3y] = perpIntersect(x, y, ml2, n3x, n3y);
        [h4x, h4y] = perpIntersect(x, y, ml2, n4x, n4y);

        drawPoint(ax, 'N3', h3x, h3y)
        drawPoint(ax, 'N4', h4x, h4y)
        dragPlot(ax, 'L2', ml2, h3x, h3y)
        [~, ~, ~, r] = twistFromLine(ax, 'T2', C);
        drawPoint(ax, 'P2', r(1), r(2))

        phase = goToPhase(4, ax);

    end

end

end