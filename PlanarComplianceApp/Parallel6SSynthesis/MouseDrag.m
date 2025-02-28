function [] = MouseDrag(~, ~, ax)

global phase dragN dragL K


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


%% Point Dragging
if any(dragN)

    if dragN(1) == 1
        if phase == 2
            drawPoint(x, y, 'P1', ax)
        elseif phase == 4
            [n1x, n1y] = grabData('N1', ax);
            drawPoint(x, y, 'P1', ax)
            drawLine([n1x, x], [n1y, y], 'L1', ax)

        elseif phase > 4
            [n1x, n1y] = grabData('N1', ax);
            [n2x, n2y] = grabData('N2', ax);
            drawPoint(x, y, 'P1', ax)
            drawLine([n1x, x], [n1y, y], 'L1', ax)
            drawLine([n2x, x], [n2y, y], 'L2', ax)

        end

        if phase >= 7
%             drawQuadCurve(ax, K, 1);
        end

        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(2) == 1
        if phase == 3
            drawPoint(x, y, 'P2', ax)

        elseif phase == 6
            [n3x, n3y] = grabData('N3', ax);
            drawPoint(x, y, 'P2', ax)
            drawLine([n3x, x], [n3y, y], 'L3', ax)

        elseif phase > 6
            [n3x, n3y] = grabData('N3', ax);
            [n4x, n4y] = grabData('N4', ax);
            drawPoint(x, y, 'P2', ax)
            drawLine([n3x, x], [n3y, y], 'L3', ax)
            drawLine([n4x, x], [n4y, y], 'L4', ax)
            
        end


        if phase >= 7
%             drawQuadCurve(ax, K, 1);
        end


        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(3) == 1
        if phase == 8 
            drawPoint(x, y, 'P3', ax)

        elseif phase == 9
            [n5x, n5y] = grabData('N5', ax);
            drawPoint(x, y, 'P3', ax)
            drawLine([n5x, x], [n5y, y], 'L5', ax)

        elseif phase == 10
            [n5x, n5y] = grabData('N5', ax);
            [n6x, n6y] = grabData('N6', ax);
            drawPoint(x, y, 'P3', ax)
            drawLine([n5x, x], [n5y, y], 'L5', ax)
            drawLine([n6x, x], [n6y, y], 'L6', ax)

        end



        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(4) == 1
        [p1x, p1y] = grabData('P1', ax);
        drawPoint(x, y, 'N1', ax);
        drawLine([x, p1x], [y, p1y], 'L1', ax)

        if phase >= 7
%             drawQuadCurve(ax, K, 1);
        end


        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(5) == 1
        [p1x, p1y] = grabData('P1', ax);
        drawPoint(x, y, 'N2', ax);
        drawLine([x, p1x], [y, p1y], 'L2', ax)

        if phase >= 7
%             drawQuadCurve(ax, K, 1);
        end


        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(6) == 1
        [p2x, p2y] = grabData('P2', ax);
        drawPoint(x, y, 'N3', ax);
        drawLine([x, p2x], [y, p2y], 'L3', ax)

        if phase >= 7
%             drawQuadCurve(ax, K, 1);
        end

        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(7) == 1
        [p2x, p2y] = grabData('P2', ax);
        drawPoint(x, y, 'N4', ax);
        drawLine([x, p2x], [y, p2y], 'L4', ax)

        if phase >= 7
%             drawQuadCurve(ax, K, 1);
        end


        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(8) == 1
        [p3x, p3y] = grabData('P3', ax);
        drawPoint(x, y, 'N5', ax);
        drawLine([x, p3x], [y, p3y], 'L5', ax)

        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(9) == 1
        [p3x, p3y] = grabData('P3', ax);
        drawPoint(x, y, 'N6', ax);
        drawLine([x, p3x], [y, p3y], 'L6', ax)

        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    end

    if phase == 8 || phase == 9
        drawQuadCurve(ax, K, 1)
    end
    

end




%% Line Dragging 
if any(dragL)
    if dragL(1) == 1
        if phase == 4
            [p1x, p1y] = grabData('P1', ax);
            [n1x, n1y] = grabData('N1', ax);
            ml1 = (p1y - n1y) / (p1x - n1x);

            [h1x, h1y] = perpIntersect(x, y, ml1, p1x, p1y);
            [h2x, h2y] = perpIntersect(x, y, ml1, n1x, n1y);

            drawPoint(h1x, h1y, 'P1', ax)
            drawPoint(h2x, h2y, 'N1', ax)

            dragPlot(ax, 'L1', ml1, h1x, h1y)

            if phase >= 7
%                 drawQuadCurve(ax, K, 1);
            end

        elseif phase > 4
            [p1x, p1y] = grabData('P1', ax);
            [n1x, n1y] = grabData('N1', ax);
            [n2x, n2y] = grabData('N2', ax);
             ml1 = (p1y - n1y) / (p1x - n1x);
             
             ml2 = (p1y - n2y) / (p1x - n2x);
             b2 = p1y - ml2*p1x;


            [h1x, h1y] = perpIntersect(x, y, ml1, p1x, p1y);
            [h2x, h2y] = perpIntersect(x, y, ml1, n1x, n1y);

            drawPoint(h1x, h1y, 'P1', ax)
            drawPoint(h2x, h2y, 'N1', ax)

            dragPlot(ax, 'L1', ml1, h1x, h1y)
            b1 = h1y - ml1*h1x;

            [h3x, h3y] = calcInt(-ml1, 1, -ml2, 1, b1, b2);

            drawPoint(h3x, h3y, 'P1', ax)

            if phase >= 7
%                 drawQuadCurve(ax, K, 1);
            end
        end

        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragL(2) == 1
        [p1x, p1y] = grabData('P1', ax);
        [n1x, n1y] = grabData('N1', ax);
        [n2x, n2y] = grabData('N2', ax);
         ml1 = (p1y - n1y) / (p1x - n1x);
         b1 = p1y - ml1*p1x;
         ml2 = (p1y - n2y) / (p1x - n2x);
             


        [h1x, h1y] = perpIntersect(x, y, ml2, p1x, p1y);
        [h2x, h2y] = perpIntersect(x, y, ml2, n2x, n2y);

        drawPoint(h1x, h1y, 'P1', ax)
        drawPoint(h2x, h2y, 'N2', ax)

        dragPlot(ax, 'L2', ml2, h1x, h1y)
        b2 = h1y - ml2*h1x;

        [h3x, h3y] = calcInt(-ml1, 1, -ml2, 1, b1, b2);

        drawPoint(h3x, h3y, 'P1', ax)

        if phase >= 7
%             drawQuadCurve(ax, K, 1);
        end

        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end
        
    

    elseif dragL(3) == 1
        if phase == 6
            [p2x, p2y] = grabData('P2', ax);
            [n3x, n3y] = grabData('N3', ax);
            ml3 = (p2y - n3y) / (p2x - n3x);

            [h1x, h1y] = perpIntersect(x, y, ml3, p2x, p2y);
            [h2x, h2y] = perpIntersect(x, y, ml3, n3x, n3y);

            drawPoint(h1x, h1y, 'P2', ax)
            drawPoint(h2x, h2y, 'N3', ax)

            dragPlot(ax, 'L3', ml3, h1x, h1y)

            if phase >= 7
%                 drawQuadCurve(ax, K, 1);
                checkConditons(K, ax);
            end

        elseif phase > 6
            [p2x, p2y] = grabData('P2', ax);
            [n3x, n3y] = grabData('N3', ax);
            [n4x, n4y] = grabData('N4', ax);
            ml3 = (p2y - n3y) / (p2x - n3x);

            [h1x, h1y] = perpIntersect(x, y, ml3, p2x, p2y);
            [h2x, h2y] = perpIntersect(x, y, ml3, n3x, n3y);

            drawPoint(h1x, h1y, 'P2', ax)
            drawPoint(h2x, h2y, 'N3', ax)

            dragPlot(ax, 'L3', ml3, h1x, h1y)

            ml4 = (p2y - n4y) / (p2x - n4x);
            b4 = n4y - ml4*n4x;
            b3 = h2y - ml3*h2x;

            [ix, iy] = calcInt(-ml3, 1, -ml4, 1, b3, b4);

            drawPoint(ix, iy, 'P2', ax)

            if phase >= 7
%                 drawQuadCurve(ax, K, 1);
            end
        end

        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragL(4) == 1
        [p2x, p2y] = grabData('P2', ax);
        [n3x, n3y] = grabData('N3', ax);
        [n4x, n4y] = grabData('N4', ax);
        ml4 = (n4y - p2y) / (n4x - p2x);

        [h1x, h1y] = perpIntersect(x, y, ml4, p2x, p2y);
        [h2x, h2y] = perpIntersect(x, y, ml4, n4x, n4y);

        drawPoint(h1x, h1y, 'P2', ax)
        drawPoint(h2x, h2y, 'N4', ax)

        dragPlot(ax, 'L4', ml4, h2x, h2y)

        ml3 = (n3y - p2y) / (n3x - p2x);
        b3 = n3y - ml3*n3x;
        b4 = h2y - ml4*h2x;

        [ix, iy] = calcInt(-ml3, 1, -ml4, 1, b3, b4);
        drawPoint(ix, iy, 'P2', ax)

        if phase >=7
%             drawQuadCurve(ax, K, 1);
        end

        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragL(5) == 1
        [p3x, p3y] = grabData('P3', ax);
        [n5x, n5y] = grabData('N5', ax);
         ml5 = (n5y - p3y) / (n5x - p3x);

        [h1x, h1y] = perpIntersect(x, y, ml5, p3x, p3y);
        [h2x, h2y] = perpIntersect(x, y, ml5, n5x, n5y);

        drawPoint(h1x, h1y, 'P3', ax)
        drawPoint(h2x, h2y, 'N5', ax)
    
        dragPlot(ax, 'L5', ml5, h1x, h1y)
            
        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragL(6) == 1
        [p3x, p3y] = grabData('P3', ax);
        [n5x, n5y] = grabData('N5', ax);
        [n6x, n6y] = grabData('N6', ax);
        ml6 = (n6y - p3y) / (n6x - p3x);
    
        [h1x, h1y] = perpIntersect(x, y, ml6, p3x, p3y);
        [h2x, h2y] = perpIntersect(x, y, ml6, n5x, n5y);
    
        drawPoint(h1x, h1y, 'P3', ax)
        drawPoint(h2x, h2y, 'N6', ax)
    
        dragPlot(ax, 'L6', ml6, h1x, h1y)
    
        ml5 = (n5y - p3y) / (n5x - p3x);
        b5 = n5y - ml5*n5x;
        b6 = h1y - ml6*h1x;
    
        [ix, iy] = calcInt(-ml5, 1, -ml6, 1, b5, b6);
        drawPoint(ix, iy, 'P3', ax)

        if phase == 10
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    end


    if phase == 8 || phase == 9
        drawQuadCurve(ax, K, 1)
    end
    
end


end


