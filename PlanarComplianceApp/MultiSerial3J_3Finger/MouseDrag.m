function [] = MouseDrag(~, ~, ax)

global phase dragN dragL K Ps

fig = get(ax, 'Parent');

if phase > 12
    ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
end

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

%% 
if any(dragN)
    if phase == 12
        s1 = str2double(get(findobj(fig, 'Tag', 'ent1'), 'String'));
        s2 = str2double(get(findobj(fig, 'Tag', 'ent2'), 'String'));


        if ~isnan(s1) && ~isnan(s2)

        if s1 == 1 || s2 == 1
            delete(findobj(ax, 'Tag', 'QuadCurve'))
            drawQuadCurve(ax, K, 4);

        elseif s1 == 2 || s2 == 2
            delete(findobj(ax, 'Tag', 'QuadCurve'))
            drawQuadCurve(ax, K, 5);

        elseif s1 == 3 || s2 == 3
            delete(findobj(ax, 'Tag', 'QuadCurve'))
            drawQuadCurve(ax, K, 6);

        elseif s1 == 4 || s2 == 4
            delete(findobj(ax, 'Tag', 'QuadCurve'))
            drawQuadCurve(ax, K, 7);

        elseif s1 == 5 || s2 == 5
            delete(findobj(ax, 'Tag', 'QuadCurve'))
            drawQuadCurve(ax, K, 8);

        elseif s1 == 6 || s2 == 6
            delete(findobj(ax, 'Tag', 'QuadCurve'))
            drawQuadCurve(ax, K, 9);

        end
        else
        end


    end

    if dragN(1) == 1
        if phase < 5
            try
                [X, Y] = pointToLine(x,y);
            catch
                return
            end
            drawPoint(X, Y, 'P1', ax)
        elseif phase == 5
            [n1x, n1y] = grabData('N1', ax);
            try
                [X, Y] = pointToLine(x,y);
            catch
                return
            end
            drawPoint(X, Y, 'P1', ax)
            drawLine([n1x, X], [n1y, Y], 'L1', ax)

        elseif phase > 5
            [n1x, n1y] = grabData('N1', ax);
            [n2x, n2y] = grabData('N2', ax);
            try
                [X, Y] = pointToLine(x,y);
            catch
                return
            end
            drawPoint(X, Y, 'P1', ax)
            drawLine([n1x, X], [n1y, Y], 'L1', ax)
            drawLine([n2x, X], [n2y, Y], 'L2', ax)

        end

        if phase >= 8
%             drawQuadCurve(ax, K, 1);
        end

        if phase == 11
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(2) == 1
        if phase < 7
            try
                [X, Y] = pointToLine(x,y);
            catch
                return
            end
            drawPoint(X, Y, 'P2', ax)

        elseif phase == 7
            [n3x, n3y] = grabData('N3', ax);
            try
                [X, Y] = pointToLine(x,y);
            catch
                return
            end
            drawPoint(X, Y, 'P2', ax)
            drawLine([n3x, X], [n3y, Y], 'L3', ax)

        elseif phase > 7
            [n3x, n3y] = grabData('N3', ax);
            [n4x, n4y] = grabData('N4', ax);
            try
                [X, Y] = pointToLine(x,y);
            catch
                return
            end
            drawPoint(X, Y, 'P2', ax)
            drawLine([n3x, X], [n3y, Y], 'L3', ax)
            drawLine([n4x, X], [n4y, Y], 'L4', ax)
            
        end


        if phase >= 8
%             drawQuadCurve(ax, K, 1);
        end


        if phase == 11
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(3) == 1
        if phase == 9 
            try
                [X, Y] = pointToLine(x,y);
            catch
                return
            end
            drawPoint(X, Y, 'P3', ax)

        elseif phase == 10
            [n5x, n5y] = grabData('N5', ax);
            try
                [X, Y] = pointToLine(x,y);
            catch
                return
            end
            drawPoint(X, Y, 'P3', ax)
            drawLine([n5x, X], [n5y, Y], 'L5', ax)

        elseif phase == 11
            [n5x, n5y] = grabData('N5', ax);
            [n6x, n6y] = grabData('N6', ax);
            try
                [X, Y] = pointToLine(x,y);
            catch
                return
            end
            drawPoint(X, Y, 'P3', ax)
            drawLine([n5x, X], [n5y, Y], 'L5', ax)
            drawLine([n6x, X], [n6y, Y], 'L6', ax)

        end



        if phase == 11
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(4) == 1
        [p1x, p1y] = grabData('P1', ax);
        drawPoint(x, y, 'N1', ax);
        drawLine([x, p1x], [y, p1y], 'L1', ax)

        if phase >= 8
%             drawQuadCurve(ax, K, 1);
        end


        if phase == 11
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(5) == 1
        [p1x, p1y] = grabData('P1', ax);
        drawPoint(x, y, 'N2', ax);
        drawLine([x, p1x], [y, p1y], 'L2', ax)

        if phase >= 8
%             drawQuadCurve(ax, K, 1);
        end


        if phase == 11
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

        if phase == 11
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(7) == 1
        [p2x, p2y] = grabData('P2', ax);
        drawPoint(x, y, 'N4', ax);
        drawLine([x, p2x], [y, p2y], 'L4', ax)

        if phase >= 8
%             drawQuadCurve(ax, K, 1);
        end


        if phase == 11
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(8) == 1
        [p3x, p3y] = grabData('P3', ax);
        drawPoint(x, y, 'N5', ax);
        drawLine([x, p3x], [y, p3y], 'L5', ax)

        if phase == 11
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragN(9) == 1
        [p3x, p3y] = grabData('P3', ax);
        drawPoint(x, y, 'N6', ax);
        drawLine([x, p3x], [y, p3y], 'L6', ax)

        if phase == 11
            Outputs(ax, K)
            checkConditons(K, ax);
        end






        %% Finger 1
    elseif dragN(10) == 1
        drawPoint(x, y, 'F1J1', ax)
        [c1x, c1y] = grabData('P1', ax);
        fingerSynth(ax, x, y, c1x, c1y, Ps.K1, 'J1', 1, 0, 0, 0)
        r11 = ll_data(1, 1);
        drawCircle(ax, r11, x, y, 'crc11', 1)

    elseif dragN(11) == 1
        [c1x, c1y] = grabData('P1', ax);
        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        r_crc1 = ll_data(1,1);
        r_crc2 = ll_data(1,2);
        r_crc3= ll_data(1,3);
        omega = [0, -1; 1, 0];

        if phase == 16
            %% Draws J2 and the seperation condition for J2

            %Gets the colsest point on the circle to the selected point
            [x1, y1] = grabData('F1J1', ax);
            m = (y-y1) / (x-x1);
        
            syms xi yi
        
            eqns = [((xi - x1)^2 + (yi - y1)^2 == r_crc1^2);
                    (yi - y1 == m*(xi - x1))];
        
            s = solve(eqns, [xi yi]);
            xI = s.xi;
            yI = s.yi;
        
            d1 = sqrt((x - xI(1))^2 + (y - yI(1))^2);
            d2 = sqrt((x - xI(2))^2 + (y - yI(2))^2);
        
            if d1 <= d2
                %plots the second joint location
                drawPoint(xI(1), yI(1), 'F1J2', ax)
        
            elseif d2 < d1
                %plots the second joint location
                drawPoint(xI(2), yI(2), 'F1J2', ax)

            end


            %Draws the seperation condition for joint 2
            %2x2 point compliance
            [x2, y2] = grabData('F1J2', ax);
            r = [(x2-c1x); (y2-c1y)];
            Kp33 = Ps.K1;
            Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
           
            % calculates line l slope
            v = omega'*r;
            f = Kp22*v;
            m_l = f(2)/f(1);
        
            %function of line l
            bl1 = c1y - m_l*c1x;
            ly1 = @(x) m_l*x + bl1;
        
            %Values used to plot the line of action of the force
            lx = c1x+1;
            ly = ly1(lx);
            %plots the lines passing through the contact point
            drawLine([c1x, x2], [c1y, y2], 'rho', ax)
            drawLine([lx, c1x], [ly, c1y], 'l', ax)

            %% Draws the circle around J2 and the possible locations for joint 3

            %Gets the circle intersection points
            drawCircle(ax, r_crc2, x2, y2, 'crc12', 1)
        
            syms xi2 yi2
        
            eqns2 = [((xi2 - x2)^2 + (yi2 - y2)^2 == r_crc2^2);
                    ((xi2 - c1x)^2 + (yi2 - c1y)^2 == r_crc3^2)];
        
            s2 = solve(eqns2, [xi2 yi2]);
            xI2 = double(s2.xi2);
            yI2 = double(s2.yi2);


            if any(~isreal([xI2, yI2]))
                delete(findobj(ax, 'Tag', 'F1J31'))
                delete(findobj(ax, 'Tag', 'F1J32'))
                return
            else
                drawPoint(xI2(1), yI2(1), 'F1J31', ax)
                drawPoint(xI2(2), yI2(2), 'F1J32', ax)
            end


    
        elseif phase == 17 
            %% draws joint 2 
            [x1, y1] = grabData('F1J1', ax);
            m = (y-y1) / (x-x1);
        
            syms xi yi
        
            eqns = [((xi - x1)^2 + (yi - y1)^2 == r_crc1^2);
                    (yi - y1 == m*(xi - x1))];
        
            s = solve(eqns, [xi yi]);
            xI = s.xi;
            yI = s.yi;
        
            d1 = sqrt((x - xI(1))^2 + (y - yI(1))^2);
            d2 = sqrt((x - xI(2))^2 + (y - yI(2))^2);

            %Distance Between each location and the contact
            d1c = sqrt((c1x - xI(1))^2 + (c1y - yI(1))^2);
            d2c = sqrt((c1x - xI(2))^2 + (c1y - yI(2))^2);
            
            d23 = ll_data(1,2) + ll_data(1,3); %Max allowable dist. between contact and J2
            if d1 <= d2
                if d1c >= d23
                    MouseRelease(0, 0, ax)
                    return
                    
                elseif d1c < r_crc3
                    return
                else
                    %plots the second joint location
                    drawPoint(xI(1), yI(1), 'F1J2', ax)
                end
        
            elseif d2 < d1
                if d2c >= d23
                    MouseRelease(0, 0, ax)
                    return
                elseif d2c < r_crc3
                    return
                else
                    %plots the second joint location
                    drawPoint(xI(2), yI(2), 'F1J2', ax)
                end
        
            end

            %% Draws the seperation condition for joint 2
            %2x2 point compliance
            [x2, y2] = grabData('F1J2', ax);
            r = [(x2-c1x); (y2-c1y)];
            Kp33 = Ps.K1;
            Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
           
            % calculates line l slope
            v = omega'*r;
            f = Kp22*v;
            m_l = f(2)/f(1);
        
            %function of line l
            bl1 = c1y - m_l*c1x;
            ly1 = @(x) m_l*x + bl1;
        
            %Values used to plot the line of action of the force
            lx = c1x+1;
            ly = ly1(lx);
            %plots the lines passing through the contact point
            drawLine([c1x, x2], [c1y, y2], 'rho', ax)
            drawLine([lx, c1x], [ly, c1y], 'l', ax)

            %% Draws Joint 3
            %Gets the circle intersection points
            [x3, y3] = grabData('F1J3', ax);
        
            syms xi2 yi2
        
            eqns2 = [((xi2 - x2)^2 + (yi2 - y2)^2 == r_crc2^2);
                    ((xi2 - c1x)^2 + (yi2 - c1y)^2 == r_crc3^2)];
        
            s2 = solve(eqns2, [xi2 yi2]);
            xI2 = double(s2.xi2);
            yI2 = double(s2.yi2);

            d1 = sqrt((x3 - xI2(1))^2 + (y3 - yI2(1))^2);
            d2 = sqrt((x3 - xI2(2))^2 + (y3 - yI2(2))^2);


            if any(~isreal([xI2, yI2]))
                return
            else
                if d1 <= d2
                    drawPoint(xI2(1), yI2(1), 'F1J3', ax)
                
                elseif d2 < d1
                    drawPoint(xI2(2), yI2(2), 'F1J3', ax)
                end
            end

            

            %% Connect Joints and compliance outputs
            connectJoints(ax, 1)
            compOutputs(ax, Ps.K1, 1)
            
    
            
        end

    elseif dragN(12) == 1
        [c1x, c1y] = grabData('P1', ax);
        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        r_crc1 = ll_data(1,1);
        r_crc2 = ll_data(1,2);
        r_crc3= ll_data(1,3);
        omega = [0, -1; 1, 0];
        
        %% draws joint 3
            [x1, y1] = grabData('F1J1', ax);
            [x2, y2] = grabData('F1J2', ax);
            [x3, y3] = grabData('F1J3', ax);

            m = (y-c1y) / (x-c1x);
        
            syms xi yi
        
            eqns = [((xi - c1x)^2 + (yi - c1y)^2 == r_crc3^2);
                    (yi - c1y == m*(xi - c1x))];
        
            s = solve(eqns, [xi yi]);
            xI = s.xi;
            yI = s.yi;
        
            d1 = sqrt((x - xI(1))^2 + (y - yI(1))^2);
            d2 = sqrt((x - xI(2))^2 + (y - yI(2))^2);

            %Distance Between each location and joint 1
            d1c = sqrt((x1 - xI(1))^2 + (y1 - yI(1))^2);
            d2c = sqrt((x1 - xI(2))^2 + (y1 - yI(2))^2);
            
            d13 = ll_data(1,1) + ll_data(1,2); %Max allowable dist. between J1 and J3
            if d1 <= d2
                if d1c >= d13
                    MouseRelease(0, 0, ax)
                    return
                else
                    %plots the second joint location
                    drawPoint(xI(1), yI(1), 'F1J3', ax)
                end
        
            elseif d2 < d1
                if d2c >= d13
                    MouseRelease(0, 0, ax)
                    return
                else
                    %plots the second joint location
                    drawPoint(xI(2), yI(2), 'F1J3', ax)
                end
        
            end

            %% Draws the seperation condition for joint 3
            [x3, y3] = grabData('F1J3', ax);
            %2x2 point compliance
            r = [(x3-c1x); (y3-c1y)];
            Kp33 = Ps.K1;
            Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
           
            % calculates line l slope
            v = omega'*r;
            f = Kp22*v;
            m_l = f(2)/f(1);
        
            %function of line l
            bl1 = c1y - m_l*c1x;
            ly1 = @(x) m_l*x + bl1;
        
            %Values used to plot the line of action of the force
            lx = c1x+1;
            ly = ly1(lx);
            %plots the lines passing through the contact point
            drawLine([c1x, x3], [c1y, y3], 'rho', ax)
            drawLine([lx, c1x], [ly, c1y], 'l', ax)

            %% Draws Joint 2
            %Gets the circle intersection points
        
            syms xi2 yi2
        
            eqns2 = [((xi2 - x1)^2 + (yi2 - y1)^2 == r_crc1^2);
                    ((xi2 - x3)^2 + (yi2 - y3)^2 == r_crc2^2)];
        
            s2 = solve(eqns2, [xi2 yi2]);
            xI2 = double(s2.xi2);
            yI2 = double(s2.yi2);

            d1 = sqrt((x2 - xI2(1))^2 + (y2 - yI2(1))^2);
            d2 = sqrt((x2 - xI2(2))^2 + (y2 - yI2(2))^2);


            if any(~isreal([xI2, yI2]))
                return
            else
                if d1 <= d2
                    drawPoint(xI2(1), yI2(1), 'F1J2', ax)
                
                elseif d2 < d1
                    drawPoint(xI2(2), yI2(2), 'F1J2', ax)
                end
            end

            

            %% Connect Joints and compliance outputs
            connectJoints(ax, 1)
            compOutputs(ax, Ps.K1, 1)







        %% Finger 2
    elseif dragN(13) == 1
        drawPoint(x, y, 'F2J1', ax)
        [c2x, c2y] = grabData('P2', ax);
        fingerSynth(ax, x, y, c2x, c2y, Ps.K2, 'J1', 1, 0, 0, 0)
        r21 = ll_data(2, 1);
        drawCircle(ax, r21, x, y, 'crc21', 1)

    elseif dragN(14) == 1
        [c2x, c2y] = grabData('P2', ax);
        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        r_crc1 = ll_data(2,1);
        r_crc2 = ll_data(2,2);
        r_crc3 = ll_data(2,3);
        omega = [0, -1; 1, 0];

        if phase == 19
            %% Draws J2 and the seperation condition for J2

            %Gets the colsest point on the circle to the selected point
            [x1, y1] = grabData('F2J1', ax);
            m = (y-y1) / (x-x1);
        
            syms xi yi
        
            eqns = [((xi - x1)^2 + (yi - y1)^2 == r_crc1^2);
                    (yi - y1 == m*(xi - x1))];
        
            s = solve(eqns, [xi yi]);
            xI = s.xi;
            yI = s.yi;
        
            d1 = sqrt((x - xI(1))^2 + (y - yI(1))^2);
            d2 = sqrt((x - xI(2))^2 + (y - yI(2))^2);
        
            if d1 <= d2
                %plots the second joint location
                drawPoint(xI(1), yI(1), 'F2J2', ax)
        
            elseif d2 < d1
                %plots the second joint location
                drawPoint(xI(2), yI(2), 'F2J2', ax)

            end


            %Draws the seperation condition for joint 2
            %2x2 point compliance
            [x2, y2] = grabData('F2J2', ax);
            r = [(x2-c2x); (y2-c2y)];
            Kp33 = Ps.K2;
            Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
           
            % calculates line l slope
            v = omega'*r;
            f = Kp22*v;
            m_l = f(2)/f(1);
        
            %function of line l
            bl1 = c2y - m_l*c2x;
            ly1 = @(x) m_l*x + bl1;
        
            %Values used to plot the line of action of the force
            lx = c2x+1;
            ly = ly1(lx);
            %plots the lines passing through the contact point
            drawLine([c2x, x2], [c2y, y2], 'rho', ax)
            drawLine([lx, c2x], [ly, c2y], 'l', ax)

            %% Draws the circle around J2 and the possible locations for joint 3

            %Gets the circle intersection points
            drawCircle(ax, r_crc2, x2, y2, 'crc22', 1)
        
            syms xi2 yi2
        
            eqns2 = [((xi2 - x2)^2 + (yi2 - y2)^2 == r_crc2^2);
                    ((xi2 - c2x)^2 + (yi2 - c2y)^2 == r_crc3^2)];
        
            s2 = solve(eqns2, [xi2 yi2]);
            xI2 = double(s2.xi2);
            yI2 = double(s2.yi2);


            if any(~isreal([xI2, yI2]))
                delete(findobj(ax, 'Tag', 'F2J31'))
                delete(findobj(ax, 'Tag', 'F2J32'))
                return
            else
                drawPoint(xI2(1), yI2(1), 'F2J31', ax)
                drawPoint(xI2(2), yI2(2), 'F2J32', ax)
            end


    
        elseif phase == 20
            %% draws joint 2 
            [x1, y1] = grabData('F2J1', ax);
            m = (y-y1) / (x-x1);
        
            syms xi yi
        
            eqns = [((xi - x1)^2 + (yi - y1)^2 == r_crc1^2);
                    (yi - y1 == m*(xi - x1))];
        
            s = solve(eqns, [xi yi]);
            xI = s.xi;
            yI = s.yi;
        
            d1 = sqrt((x - xI(1))^2 + (y - yI(1))^2);
            d2 = sqrt((x - xI(2))^2 + (y - yI(2))^2);

            %Distance Between each location and the contact
            d1c = sqrt((c2x - xI(1))^2 + (c2y - yI(1))^2);
            d2c = sqrt((c2x - xI(2))^2 + (c2y - yI(2))^2);
            
            d23 = ll_data(2,2) + ll_data(2,3); %Max allowable dist. between contact and J2
            if d1 <= d2
                if d1c >= d23
                    return
                elseif d1c < r_crc3
                    return
                else
                    %plots the second joint location
                    drawPoint(xI(1), yI(1), 'F2J2', ax)
                end
        
            elseif d2 < d1
                if d2c >= d23
                    return
                elseif d2c < r_crc3
                    return
                else
                    %plots the second joint location
                    drawPoint(xI(2), yI(2), 'F2J2', ax)
                end
        
            end

            %% Draws the seperation condition for joint 2
            %2x2 point compliance
            [x2, y2] = grabData('F2J2', ax);
            r = [(x2-c2x); (y2-c2y)];
            Kp33 = Ps.K2;
            Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
           
            % calculates line l slope
            v = omega'*r;
            f = Kp22*v;
            m_l = f(2)/f(1);
        
            %function of line l
            bl1 = c2y - m_l*c2x;
            ly1 = @(x) m_l*x + bl1;
        
            %Values used to plot the line of action of the force
            lx = c2x+1;
            ly = ly1(lx);
            %plots the lines passing through the contact point
            drawLine([c2x, x2], [c2y, y2], 'rho', ax)
            drawLine([lx, c2x], [ly, c2y], 'l', ax)

            %% Draws Joint 3
            %Gets the circle intersection points
            [x3, y3] = grabData('F2J3', ax);
        
            syms xi2 yi2
        
            eqns2 = [((xi2 - x2)^2 + (yi2 - y2)^2 == r_crc2^2);
                    ((xi2 - c2x)^2 + (yi2 - c2y)^2 == r_crc3^2)];
        
            s2 = solve(eqns2, [xi2 yi2]);
            xI2 = double(s2.xi2);
            yI2 = double(s2.yi2);

            d1 = sqrt((x3 - xI2(1))^2 + (y3 - yI2(1))^2);
            d2 = sqrt((x3 - xI2(2))^2 + (y3 - yI2(2))^2);


            if any(~isreal([xI2, yI2]))
                return
            else
                if d1 <= d2
                    drawPoint(xI2(1), yI2(1), 'F2J3', ax)
                
                elseif d2 < d1
                    drawPoint(xI2(2), yI2(2), 'F2J3', ax)
                end
            end

            

            %% Connect Joints and compliance outputs
            connectJoints(ax, 2)
            compOutputs(ax, Ps.K2, 2)
            
    
            
        end


    elseif dragN(15) == 1
        [c2x, c2y] = grabData('P2', ax);
        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        r_crc1 = ll_data(2,1);
        r_crc2 = ll_data(2,2);
        r_crc3= ll_data(2,3);
        omega = [0, -1; 1, 0];
        
        %% draws joint 3
            [x1, y1] = grabData('F2J1', ax);
            [x2, y2] = grabData('F2J2', ax);
            [x3, y3] = grabData('F2J3', ax);

            m = (y-c2y) / (x-c2x);
        
            syms xi yi
        
            eqns = [((xi - c2x)^2 + (yi - c2y)^2 == r_crc3^2);
                    (yi - c2y == m*(xi - c2x))];
        
            s = solve(eqns, [xi yi]);
            xI = s.xi;
            yI = s.yi;
        
            d1 = sqrt((x - xI(1))^2 + (y - yI(1))^2);
            d2 = sqrt((x - xI(2))^2 + (y - yI(2))^2);

            %Distance Between each location and joint 1
            d1c = sqrt((x1 - xI(1))^2 + (y1 - yI(1))^2);
            d2c = sqrt((x1 - xI(2))^2 + (y1 - yI(2))^2);
            
            d13 = ll_data(2,1) + ll_data(2,2); %Max allowable dist. between J1 and J3
            if d1 <= d2
                if d1c >= d13
                    MouseRelease(0, 0, ax)
                    return
                else
                    %plots the second joint location
                    drawPoint(xI(1), yI(1), 'F2J3', ax)
                end
        
            elseif d2 < d1
                if d2c >= d13
                    MouseRelease(0, 0, ax)
                    return
                else
                    %plots the second joint location
                    drawPoint(xI(2), yI(2), 'F2J3', ax)
                end
        
            end

            %% Draws the seperation condition for joint 3
            [x3, y3] = grabData('F2J3', ax);
            %2x2 point compliance
            r = [(x3-c2x); (y3-c2y)];
            Kp33 = Ps.K2;
            Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
           
            % calculates line l slope
            v = omega'*r;
            f = Kp22*v;
            m_l = f(2)/f(1);
        
            %function of line l
            bl1 = c2y - m_l*c2x;
            ly1 = @(x) m_l*x + bl1;
        
            %Values used to plot the line of action of the force
            lx = c2x+1;
            ly = ly1(lx);
            %plots the lines passing through the contact point
            drawLine([c2x, x3], [c2y, y3], 'rho', ax)
            drawLine([lx, c2x], [ly, c2y], 'l', ax)

            %% Draws Joint 2
            %Gets the circle intersection points
        
            syms xi2 yi2
        
            eqns2 = [((xi2 - x1)^2 + (yi2 - y1)^2 == r_crc1^2);
                    ((xi2 - x3)^2 + (yi2 - y3)^2 == r_crc2^2)];
        
            s2 = solve(eqns2, [xi2 yi2]);
            xI2 = double(s2.xi2);
            yI2 = double(s2.yi2);

            d1 = sqrt((x2 - xI2(1))^2 + (y2 - yI2(1))^2);
            d2 = sqrt((x2 - xI2(2))^2 + (y2 - yI2(2))^2);


            if any(~isreal([xI2, yI2]))
                return
            else
                if d1 <= d2
                    drawPoint(xI2(1), yI2(1), 'F2J2', ax)
                
                elseif d2 < d1
                    drawPoint(xI2(2), yI2(2), 'F2J2', ax)
                end
            end

            

            %% Connect Joints and compliance outputs
            connectJoints(ax, 2)
            compOutputs(ax, Ps.K2, 2)






        %% Finger 3
    elseif dragN(16) == 1
        drawPoint(x, y, 'F3J1', ax)
        [c3x, c3y] = grabData('P3', ax);
        fingerSynth(ax, x, y, c3x, c3y, Ps.K3, 'J1', 1, 0, 0, 0)
        r31 = ll_data(3, 1);
        drawCircle(ax, r31, x, y, 'crc31', 1)

    elseif dragN(17) == 1
        [c3x, c3y] = grabData('P3', ax);
        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        r_crc1 = ll_data(3,1);
        r_crc2 = ll_data(3,2);
        r_crc3 = ll_data(3,3);
        omega = [0, -1; 1, 0];

        if phase == 22
            %% Draws J2 and the seperation condition for J2

            %Gets the colsest point on the circle to the selected point
            [x1, y1] = grabData('F3J1', ax);
            m = (y-y1) / (x-x1);
        
            syms xi yi
        
            eqns = [((xi - x1)^2 + (yi - y1)^2 == r_crc1^2);
                    (yi - y1 == m*(xi - x1))];
        
            s = solve(eqns, [xi yi]);
            xI = s.xi;
            yI = s.yi;
        
            d1 = sqrt((x - xI(1))^2 + (y - yI(1))^2);
            d2 = sqrt((x - xI(2))^2 + (y - yI(2))^2);
        
            if d1 <= d2
                %plots the second joint location
                drawPoint(xI(1), yI(1), 'F3J2', ax)
        
            elseif d2 < d1
                %plots the second joint location
                drawPoint(xI(2), yI(2), 'F3J2', ax)

            end


            %Draws the seperation condition for joint 2
            %2x2 point compliance
            [x2, y2] = grabData('F3J2', ax);
            r = [(x2-c3x); (y2-c3y)];
            Kp33 = Ps.K3;
            Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
           
            % calculates line l slope
            v = omega'*r;
            f = Kp22*v;
            m_l = f(2)/f(1);
        
            %function of line l
            bl1 = c3y - m_l*c3x;
            ly1 = @(x) m_l*x + bl1;
        
            %Values used to plot the line of action of the force
            lx = c3x+1;
            ly = ly1(lx);
            %plots the lines passing through the contact point
            drawLine([c3x, x2], [c3y, y2], 'rho', ax)
            drawLine([lx, c3x], [ly, c3y], 'l', ax)

            %% Draws the circle around J2 and the possible locations for joint 3

            %Gets the circle intersection points
            drawCircle(ax, r_crc2, x2, y2, 'crc32', 1)
        
            syms xi2 yi2
        
            eqns2 = [((xi2 - x2)^2 + (yi2 - y2)^2 == r_crc2^2);
                    ((xi2 - c3x)^2 + (yi2 - c3y)^2 == r_crc3^2)];
        
            s2 = solve(eqns2, [xi2 yi2]);
            xI2 = double(s2.xi2);
            yI2 = double(s2.yi2);


            if any(~isreal([xI2, yI2]))
                delete(findobj(ax, 'Tag', 'F3J31'))
                delete(findobj(ax, 'Tag', 'F3J32'))
                return
            else
                drawPoint(xI2(1), yI2(1), 'F3J31', ax)
                drawPoint(xI2(2), yI2(2), 'F3J32', ax)
            end


    
        elseif phase == 23
            %% draws joint 2 
            [x1, y1] = grabData('F3J1', ax);
            m = (y-y1) / (x-x1);
        
            syms xi yi
        
            eqns = [((xi - x1)^2 + (yi - y1)^2 == r_crc1^2);
                    (yi - y1 == m*(xi - x1))];
        
            s = solve(eqns, [xi yi]);
            xI = s.xi;
            yI = s.yi;
        
            d1 = sqrt((x - xI(1))^2 + (y - yI(1))^2);
            d2 = sqrt((x - xI(2))^2 + (y - yI(2))^2);

            %Distance Between each location and the contact
            d1c = sqrt((c3x - xI(1))^2 + (c3y - yI(1))^2);
            d2c = sqrt((c3x - xI(2))^2 + (c3y - yI(2))^2);
            
            d23 = ll_data(3,2) + ll_data(3,3); %Max allowable dist. between contact and J2
            if d1 <= d2
                if d1c >= d23
                    MouseRelease(0, 0, ax)
                    return
                elseif d1c < r_crc3
                    return
                else
                    %plots the second joint location
                    drawPoint(xI(1), yI(1), 'F3J2', ax)
                end
        
            elseif d2 < d1
                if d2c >= d23
                    MouseRelease(0, 0, ax)
                    return
                elseif d2c < r_crc3
                    return
                else
                    %plots the second joint location
                    drawPoint(xI(2), yI(2), 'F3J2', ax)
                end
        
            end

            %% Draws the seperation condition for joint 2
            %2x2 point compliance
            [x2, y2] = grabData('F3J2', ax);
            r = [(x2-c3x); (y2-c3y)];
            Kp33 = Ps.K3;
            Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
           
            % calculates line l slope
            v = omega'*r;
            f = Kp22*v;
            m_l = f(2)/f(1);
        
            %function of line l
            bl1 = c3y - m_l*c3x;
            ly1 = @(x) m_l*x + bl1;
        
            %Values used to plot the line of action of the force
            lx = c3x+1;
            ly = ly1(lx);
            %plots the lines passing through the contact point
            drawLine([c3x, x2], [c3y, y2], 'rho', ax)
            drawLine([lx, c3x], [ly, c3y], 'l', ax)

            %% Draws Joint 3
            %Gets the circle intersection points
            [x3, y3] = grabData('F3J3', ax);
        
            syms xi2 yi2
        
            eqns2 = [((xi2 - x2)^2 + (yi2 - y2)^2 == r_crc2^2);
                    ((xi2 - c3x)^2 + (yi2 - c3y)^2 == r_crc3^2)];
        
            s2 = solve(eqns2, [xi2 yi2]);
            xI2 = double(s2.xi2);
            yI2 = double(s2.yi2);

            d1 = sqrt((x3 - xI2(1))^2 + (y3 - yI2(1))^2);
            d2 = sqrt((x3 - xI2(2))^2 + (y3 - yI2(2))^2);


            if any(~isreal([xI2, yI2]))
                return
            else
                if d1 <= d2
                    drawPoint(xI2(1), yI2(1), 'F3J3', ax)
                
                elseif d2 < d1
                    drawPoint(xI2(2), yI2(2), 'F3J3', ax)
                end
            end

            

            %% Connect Joints and compliance outputs
            connectJoints(ax, 3)
            compOutputs(ax, Ps.K3, 3)
            
    
            
        end

    elseif dragN(18) == 1
        [c3x, c3y] = grabData('P3', ax);
        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        r_crc1 = ll_data(3,1);
        r_crc2 = ll_data(3,2);
        r_crc3= ll_data(3,3);
        omega = [0, -1; 1, 0];
        
        %% draws joint 3
            [x1, y1] = grabData('F3J1', ax);
            [x2, y2] = grabData('F3J2', ax);
            [x3, y3] = grabData('F3J3', ax);

            m = (y-c3y) / (x-c3x);
        
            syms xi yi
        
            eqns = [((xi - c3x)^2 + (yi - c3y)^2 == r_crc3^2);
                    (yi - c3y == m*(xi - c3x))];
        
            s = solve(eqns, [xi yi]);
            xI = s.xi;
            yI = s.yi;
        
            d1 = sqrt((x - xI(1))^2 + (y - yI(1))^2);
            d2 = sqrt((x - xI(2))^2 + (y - yI(2))^2);

            %Distance Between each location and joint 1
            d1c = sqrt((x1 - xI(1))^2 + (y1 - yI(1))^2);
            d2c = sqrt((x1 - xI(2))^2 + (y1 - yI(2))^2);
            
            d13 = ll_data(3,1) + ll_data(3,2); %Max allowable dist. between J1 and J3
            if d1 <= d2
                if d1c >= d13
                    MouseRelease(0, 0, ax)
                    return
                else
                    %plots the second joint location
                    drawPoint(xI(1), yI(1), 'F3J3', ax)
                end
        
            elseif d2 < d1
                if d2c >= d13
                    MouseRelease(0, 0, ax)
                    return
                else
                    %plots the second joint location
                    drawPoint(xI(2), yI(2), 'F3J3', ax)
                end
        
            end

            %% Draws the seperation condition for joint 3
            [x3, y3] = grabData('F3J3', ax);
            %2x2 point compliance
            r = [(x3-c3x); (y3-c3y)];
            Kp33 = Ps.K3;
            Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
           
            % calculates line l slope
            v = omega'*r;
            f = Kp22*v;
            m_l = f(2)/f(1);
        
            %function of line l
            bl1 = c3y - m_l*c3x;
            ly1 = @(x) m_l*x + bl1;
        
            %Values used to plot the line of action of the force
            lx = c3x+1;
            ly = ly1(lx);
            %plots the lines passing through the contact point
            drawLine([c3x, x3], [c3y, y3], 'rho', ax)
            drawLine([lx, c3x], [ly, c3y], 'l', ax)

            %% Draws Joint 2
            %Gets the circle intersection points
        
            syms xi2 yi2
        
            eqns2 = [((xi2 - x1)^2 + (yi2 - y1)^2 == r_crc1^2);
                    ((xi2 - x3)^2 + (yi2 - y3)^2 == r_crc2^2)];
        
            s2 = solve(eqns2, [xi2 yi2]);
            xI2 = double(s2.xi2);
            yI2 = double(s2.yi2);

            d1 = sqrt((x2 - xI2(1))^2 + (y2 - yI2(1))^2);
            d2 = sqrt((x2 - xI2(2))^2 + (y2 - yI2(2))^2);


            if any(~isreal([xI2, yI2]))
                return
            else
                if d1 <= d2
                    drawPoint(xI2(1), yI2(1), 'F3J2', ax)
                
                elseif d2 < d1
                    drawPoint(xI2(2), yI2(2), 'F3J2', ax)
                end
            end

            

            %% Connect Joints and compliance outputs
            connectJoints(ax, 3)
            compOutputs(ax, Ps.K3, 3)

    end

    %% Updates the quadratic curve of w5 and w6 when the first 4 wrenches are dragged

    if phase == 8 || phase == 9
        drawQuadCurve(ax, K, 1)
    end
    

end

%%
if any(dragL)
    if dragL(1) == 1
        if phase == 5
            [p1x, p1y] = grabData('P1', ax);
            [n1x, n1y] = grabData('N1', ax);
            ml1 = (p1y - n1y) / (p1x - n1x);

            try
            [X, Y] = pointToLine(x,y);
            catch
                return
            end
            [h1x, h1y] = perpIntersect(X, Y, ml1, p1x, p1y);
            [h2x, h2y] = perpIntersect(X, Y, ml1, n1x, n1y);

            drawPoint(X, Y, 'P1', ax)
            drawPoint(h2x, h2y, 'N1', ax)

            dragPlot(ax, 'L1', ml1, h1x, h1y)


            if phase >= 8
%                 drawQuadCurve(ax, K, 1);
            end

        elseif phase > 5
            try
            [X, Y] = pointToLine(x,y);
            catch
                return
            end
            [p1x, p1y] = grabData('P1', ax);
            [n1x, n1y] = grabData('N1', ax);
            [n2x, n2y] = grabData('N2', ax);
             ml1 = (p1y - n1y) / (p1x - n1x);
            

            [h1x, h1y] = perpIntersect(X, Y, ml1, p1x, p1y);
            [h2x, h2y] = perpIntersect(X, Y, ml1, n1x, n1y);

            
            drawPoint(h2x, h2y, 'N1', ax)

            dragPlot(ax, 'L1', ml1, h1x, h1y)
            drawLine([X, n2x], [Y, n2y], 'L2', ax)

            drawPoint(X, Y, 'P1', ax)

            if phase >= 8
%                 drawQuadCurve(ax, K, 1);
            end
        end

        if phase == 11
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragL(2) == 1
        try
            [X, Y] = pointToLine(x,y);
        catch
            return
        end

        [p1x, p1y] = grabData('P1', ax);
        [n1x, n1y] = grabData('N1', ax);
        [n2x, n2y] = grabData('N2', ax);
         ml2 = (p1y - n2y) / (p1x - n2x);
             

        [h1x, h1y] = perpIntersect(X, Y, ml2, p1x, p1y);
        [h2x, h2y] = perpIntersect(X, Y, ml2, n2x, n2y);

        drawPoint(h2x, h2y, 'N2', ax)

        dragPlot(ax, 'L2', ml2, h1x, h1y)
        drawLine([X, n1x], [Y, n1y], 'L1', ax)


        drawPoint(X, Y, 'P1', ax)

        if phase >= 8
%             drawQuadCurve(ax, K, 1);
        end

        if phase == 11
            Outputs(ax, K)
            checkConditons(K, ax);
        end
        
    

    elseif dragL(3) == 1
        if phase == 7
            [p2x, p2y] = grabData('P2', ax);
            [n3x, n3y] = grabData('N3', ax);
            ml3 = (p2y - n3y) / (p2x - n3x);

            try
                [X, Y] = pointToLine(x,y);
            catch
                return
            end
            [h1x, h1y] = perpIntersect(X, Y, ml3, p2x, p2y);
            [h2x, h2y] = perpIntersect(X, Y, ml3, n3x, n3y);

            drawPoint(X, Y, 'P2', ax)
            drawPoint(h2x, h2y, 'N3', ax)

            dragPlot(ax, 'L3', ml3, h1x, h1y)

            if phase >= 8
%                 drawQuadCurve(ax, K, 1);
                checkConditons(K, ax);
            end

        elseif phase > 7
            [p2x, p2y] = grabData('P2', ax);
            [n3x, n3y] = grabData('N3', ax);
            [n4x, n4y] = grabData('N4', ax);
            ml3 = (p2y - n3y) / (p2x - n3x);

            try
                [X, Y] = pointToLine(x,y);
            catch
                return
            end
            [h1x, h1y] = perpIntersect(X, Y, ml3, p2x, p2y);
            [h2x, h2y] = perpIntersect(X, Y, ml3, n3x, n3y);

            drawPoint(h2x, h2y, 'N3', ax)

            dragPlot(ax, 'L3', ml3, h1x, h1y)
            drawLine([X, n4x], [Y, n4y], 'L4', ax)
            


            drawPoint(X, Y, 'P2', ax)

            if phase >= 8
%                 drawQuadCurve(ax, K, 1);
            end
        end

        if phase == 11
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragL(4) == 1
        [p2x, p2y] = grabData('P2', ax);
        [n3x, n3y] = grabData('N3', ax);
        [n4x, n4y] = grabData('N4', ax);
        ml4 = (n4y - p2y) / (n4x - p2x);

        try
            [X, Y] = pointToLine(x,y);
        catch
            return
        end

        [h2x, h2y] = perpIntersect(X, Y, ml4, n4x, n4y);

        drawPoint(h2x, h2y, 'N4', ax)

        dragPlot(ax, 'L4', ml4, h2x, h2y)
        drawLine([X, n3x], [Y, n3y], 'L3', ax)
        

        drawPoint(X, Y, 'P2', ax)

        if phase >=8
%             drawQuadCurve(ax, K, 1);
        end

        if phase == 11
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragL(5) == 1
        [p3x, p3y] = grabData('P3', ax);
        [n5x, n5y] = grabData('N5', ax);
         ml5 = (n5y - p3y) / (n5x - p3x);

        try
            [X, Y] = pointToLine(x,y);
        catch
            return
        end
        
        [h2x, h2y] = perpIntersect(X, Y, ml5, n5x, n5y);

        drawPoint(X, Y, 'P3', ax)
        drawPoint(h2x, h2y, 'N5', ax)
    
        dragPlot(ax, 'L5', ml5, X, Y)
        
            
        if phase == 11
            [n6x, n6y] = grabData('N6', ax);
            drawLine([X, n6x], [Y, n6y], 'L6', ax)

            Outputs(ax, K)
            checkConditons(K, ax);
        end

    elseif dragL(6) == 1
        [p3x, p3y] = grabData('P3', ax);
        [n5x, n5y] = grabData('N5', ax);
        [n6x, n6y] = grabData('N6', ax);
        ml6 = (n6y - p3y) / (n6x - p3x);
    
        try
            [X, Y] = pointToLine(x,y);
        catch
            return
        end

        
        [h2x, h2y] = perpIntersect(X, Y, ml6, n5x, n5y);

        drawPoint(h2x, h2y, 'N6', ax)
        dragPlot(ax, 'L6', ml6, X, Y)

        drawPoint(X, Y, 'P3', ax)
        drawLine([X, n5x], [Y, n5y], 'L5', ax)

        if phase == 11
            Outputs(ax, K)
            checkConditons(K, ax);
        end

    end

    if phase == 8 || phase == 9
        drawQuadCurve(ax, K, 1)
    end

end


end


