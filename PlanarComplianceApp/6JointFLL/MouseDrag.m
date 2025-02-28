function [] = MouseDrag(~, ~, ax)
%dragN(1) = 1  - joint 1 is being dragged

%dragN(2) = 1  - T12 is being dragged

%dragN(3) = 1  - T34 is being dragged

%dragN(4) = 1  - joint 4 is being dragged

%dragN(5) = 1  - joint 5 is being dragged

global dragN ll C phase

[x, y] = getCurrentXY(ax);
fig = get(ax, 'Parent');


%% Displays the location of the mouse on the axes
xlim = get(ax, 'xlim'); ylim = get(ax, 'ylim');
pt1x = findobj(fig, 'Tag', 'pt1x');
pt1y = findobj(fig, 'Tag', 'pt1y');
pt2x = findobj(fig, 'Tag', 'pt2x');
pt2y = findobj(fig, 'Tag', 'pt2y');

xpos = findobj(fig, 'tag', 'xpos');
ypos = findobj(fig, 'tag', 'ypos');

if x < xlim(1) || x > xlim(2) || y < ylim(1) || y > ylim(2)
    set(xpos, 'String', '');
    set(ypos, 'String', '');
    return
end

%Change the number of decimals to 2
xpos1 = sprintf('%0.2f', x);
ypos1 = sprintf('%0.2f', y);

%Display the x and y values on the gui
set(xpos, 'String', xpos1);
set(ypos, 'String', ypos1);


%% Drag functionalities
if any(dragN)

    if dragN(1) == 1
        %%
        r1 = norm(ll.lengths, 1);
        r2 = ll.lengths(1);
        drawPoint(x, y, 'J1', ax)
        drawCircle(ax, r1, x, y, 'crc1')
        drawCircle(ax, r2, x, y, 'crc2')

        %Gets the wrench equation
        w1 = C\[y;-x;1]; w1 = w1/norm([w1(1), w1(2)]);
        m1 = w1(2)/w1(1); ed1 = cross([w1(1);w1(2);0], [0;0;1]);
        d1 = w1(3)*ed1; b1 = d1(2) - m1*d1(1);
        goToPhase(3, ax);

       
    elseif dragN(2) == 1
        %finds the point on the circle around joint 1 closest to the input and
        %plots it
        [j1x, j1y] = grabData('J1', ax);
        m = (y - j1y) / (x - j1x);
        b = j1y - m*j1x;
    
        %Vector representation of the Circle
        T1 = [1, 0, -j1y; 0, 1, j1x; 0, 0, 1];
        E1 = [1, 0, 0; 0, 1, 0; 0, 0, -(ll.lengths(1))^2];
        [x1, y1, x2, y2] = Intersections('cl', m, b, E1, T1, 0, 0);
    
        D1 = sqrt((x-x1)^2 + (y-y1)^2); D2 = sqrt((x-x2)^2 + (y-y2)^2);
    
        if D1 > D2 
            drawPoint(x2, y2, 'J2', ax)
            j2x = x2; j2y = y2;
    
        elseif D2 >= D1
            drawPoint(x1, y1, 'J2', ax)
            j2x = x1; j2y = y1;
    
        end

        %Updates the figure
        r3 = ll.lengths(2);
        drawCircle(ax, r3, j2x, j2y, 'crc3')
    
        %Places the quadratic curve of T2
        T2 = [1, 0, -j2y; 
              0, 1, j2x; 
              0, 0, 1];
    
        E2 = [1, 0, 0; 
              0, 1, 0; 
              0, 0, -r3^2];
    
        G2 = C*(T2'*E2*T2)*C; G2 = inv(G2);
    
    
        delete(findobj(ax, 'Tag', 'T2quad'))
        f = @(x,y) G2(1,1)*y.^2 + G2(2,2)*x.^2 - 2*G2(1,2)*x.*y + 2*G2(1,3)*y - 2*G2(2,3)*x + G2(3,3);
        fimp = fimplicit(f, 'Color', 'b', 'LineWidth', 0.1, 'Tag', 'T2quad');
        uistack(fimp, 'bottom')

    elseif dragN(3) == 1
        %%
        %Draws twist 34 
        drawPoint(x, y, 'P2', ax)    %P2 == t34
    
        %System of equations is solved for w3 and w3'
        t34 = [y;-x;1];
        r3 = ll.lengths(2);
        [j2x, j2y] = grabData('J2', ax);
    
        T2 = [1, 0, -j2y; 0, 1, j2x; 0, 0, 1];
        E2 = [1, 0, 0; 0, 1, 0; 0, 0, -r3^2];
        G2 = C*(T2'*E2*T2)*C;
        
        syms w31 w32 w33
        eqns = [t34'*[w31;w32;w33] == 0; [w31,w32,w33]*G2*[w31;w32;w33] == 0; w31 + w32 == 1];
        solns2 = solve(eqns, [w31, w32, w33]);
        
    
        w3 = [double(solns2.w31(1)); double(solns2.w32(1)); double(solns2.w33(1))];
        w3p = [double(solns2.w31(2)); double(solns2.w32(2)); double(solns2.w33(2))];

        [ec1] = checkConditions(ax, C, phase, ll, x, y);
        if ec1 == 1
            phase = goToPhase(5, ax);
            return
        end
    
        %T3 and T3' are plotted
        t3 = C*w3; t3 = t3/t3(3);
        t3p = C*w3p; t3p = t3p/t3p(3);
    
        drawPoint(-t3(2), t3(1), 'T3', ax);
        drawPoint(-t3p(2), t3p(1), 'T4', ax);

        %redraws the circle and the quadratic curve

        if isempty(findobj(ax, 'Tag', 'crc3')) || isempty(findobj(ax, 'Tag', 'T2quad'))
            r3 = ll.lengths(2);
            drawCircle(ax, r3, j2x, j2y, 'crc3')
  
            %Places the quadratic curve of T2
            T2 = [1, 0, -j2y; 0, 1, j2x; 0, 0, 1];
            E2 = [1, 0, 0; 0, 1, 0; 0, 0, -r3^2];
            G2 = C*(T2'*E2*T2)*C; G2 = inv(G2);
        
        
            f = @(x,y) G2(1,1)*y.^2 + G2(2,2)*x.^2 - 2*G2(1,2)*x.*y + 2*G2(1,3)*y - 2*G2(2,3)*x + G2(3,3);
            fimp = fimplicit(f, 'Color', 'b', 'LineWidth', 0.1, 'Tag', 'T2quad');
            uistack(fimp, 'bottom')
        end

    elseif dragN(4) == 1
        %%
        %Get the neccesary information to calculate the intersections of
        %the circle and the line
        [j3x, j3y] = grabData('J3', ax);
        [j4x, j4y] = grabData('J4', ax);
        [j5x, j5y] = grabData('J5', ax);
        [j6x, j6y] = grabData('J6', ax);

        m = (y - j3y) / (x - j3x);
        b = j3y - m*j3x;

        T3 = [1 0 -j3y;
              0 1 j3x;
              0 0 1];
        E3 = [1 0 0 ;
              0 1 0 
              0 0 -(ll.lengths(3)^2)];

        %Represent the circle equation in vector form
        [x1, y1, x2, y2] = Intersections('cl', m, b, E3, T3, 0, 0);

        %find which intersection value is closer to the previous joint 4
         D1 = sqrt((j4x-x1)^2 + (j4y-y1)^2); D2 = sqrt((j4x-x2)^2 + (j4y-y2)^2);

        %Draw Joint 4 at its new location
        if D1 > D2 
            %check to make sure that J4 is not too far away from J6
            D46 = sqrt((j6x-x2)^2 + (j6y-y2)^2);
            if D46 > (ll.lengths(4)+ll.lengths(5))
                return
            end
            drawPoint(x2, y2, 'J4', ax)
            j4x = x2; j4y = y2;
    
    
        elseif D2 >= D1
            %check to make sure that J4 is not too far away from J6
            D46 = sqrt((j6x-x1)^2 + (j6y-y1)^2);
            if D46 > (ll.lengths(4)+ll.lengths(5))
                return
            end

            drawPoint(x1, y1, 'J4', ax)
            j4x = x1; j4y = y1;
        end

        %Find the intersections of gamma4 and gamma5
        T4 = [1 0 -j4y;
              0 1 j4x;
              0 0 1];
        E4 = [1 0 0 ;
              0 1 0 
              0 0 -(ll.lengths(4)^2)];

        T5 = [1 0 -j6y;
              0 1 j6x;
              0 0 1];
        E5 = [1 0 0 ;
              0 1 0 
              0 0 -(ll.lengths(5)^2)];
        [x1, y1, x2, y2] = Intersections('cc', 0, 0, E4, T4, E5, T5);

        %find which intersection value is closer to the previous joint 5
        D1 = sqrt((j5x-x1)^2 + (j5y-y1)^2); D2 = sqrt((j5x-x2)^2 + (j5y-y2)^2);

        %Draw joint 5 at its new location
        if D1 > D2 
            drawPoint(x2, y2, 'J5', ax)
    
    
        elseif D2 >= D1
            drawPoint(x1, y1, 'J5', ax)
    
        end


        delete(findobj(ax, 'Tag', 'text4'))
        delete(findobj(ax, 'Tag', 'text5'))
        connectJoints(ax)
        Outputs(ax, C)

    elseif dragN(5) == 1
        %%
        %Get the neccesary information to calculate the intersections of
        %the circle and the line
        [j3x, j3y] = grabData('J3', ax);
        [j4x, j4y] = grabData('J4', ax);
        [j5x, j5y] = grabData('J5', ax);
        [j6x, j6y] = grabData('J6', ax);

        m = (y - j6y) / (x - j6x);
        b = j6y - m*j6x;

        T5 = [1 0 -j6y;
              0 1 j6x;
              0 0 1];
        E5 = [1 0 0 ;
              0 1 0 
              0 0 -(ll.lengths(5)^2)];

        %Represent the circle equation in vector form
        [x1, y1, x2, y2] = Intersections('cl', m, b, E5, T5, 0, 0);

        %find which intersection value is closer to the previous joint 4
         D1 = sqrt((j5x-x1)^2 + (j5y-y1)^2); D2 = sqrt((j5x-x2)^2 + (j5y-y2)^2);

        %Draw Joint 4 at its new location
        if D1 > D2 
            %check to make sure that J5 is not too far away from J3
            D35 = sqrt((j3x-x2)^2 + (j3y-y2)^2);
            if D35 > (ll.lengths(3)+ll.lengths(4))
                return
            end
            drawPoint(x2, y2, 'J5', ax)
            j5x = x2; j5y = y2;
    
    
        elseif D2 >= D1
            %check to make sure that J4 is not too far away from J6
            D35 = sqrt((j3x-x1)^2 + (j3y-y1)^2);
            if D35 > (ll.lengths(3)+ll.lengths(4))
                return
            end

            drawPoint(x1, y1, 'J5', ax)
            j5x = x1; j5y = y1;
        end

        %Find the intersections of gamma3 and gamma5
        T3 = [1 0 -j3y;
              0 1 j3x;
              0 0 1];
        E3 = [1 0 0 ;
              0 1 0 
              0 0 -(ll.lengths(3)^2)];

        T5 = [1 0 -j5y;
              0 1 j5x;
              0 0 1];
        E5 = [1 0 0 ;
              0 1 0 
              0 0 -(ll.lengths(5)^2)];
        [x1, y1, x2, y2] = Intersections('cc', 0, 0, E3, T3, E5, T5);

        %find which intersection value is closer to the previous joint 5
        D1 = sqrt((j4x-x1)^2 + (j4y-y1)^2); D2 = sqrt((j4x-x2)^2 + (j4y-y2)^2);

        %Draw joint 5 at its new location
        if D1 > D2 
            drawPoint(x2, y2, 'J4', ax)
    
    
        elseif D2 >= D1
            drawPoint(x1, y1, 'J4', ax)
    
        end


        delete(findobj(ax, 'Tag', 'text4'))
        delete(findobj(ax, 'Tag', 'text5'))
        connectJoints(ax)
        Outputs(ax, C)


    end
end



end