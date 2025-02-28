function MouseDrag(~, ~, ax)

global dragN ll C phase

[x, y] = getCurrentXY(ax);
fig = get(ax, 'Parent');

xlim = get(ax, 'xlim'); ylim = get(ax, 'ylim');

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



if any(dragN)

    if dragN(1) == 1
        r1 = norm(ll.lengths, 1);
        r2 = ll.lengths(1);
        drawPoint(x, y, 'J1', ax)
        drawCircle(ax, r1, x, y, 'crc1')
        drawCircle(ax, r2, x, y, 'crc2')

        %Gets the wrench equation
        w1 = C\[y;-x;1]; w1 = w1/norm([w1(1), w1(2)]);
        m1 = w1(2)/w1(1); ed1 = cross([w1(1);w1(2);0], [0;0;1]);
        d1 = w1(3)*ed1; b1 = d1(2) - m1*d1(1);
    
        %draws the wrench line
        func1 = @(x) m1*x + b1; x2 = d1(1) + 1;
        y2 = func1(x2); drawLine(ax, 'L1', [d1(1), x2], [d1(2), y2])

        goToPhase(3, ax);

    elseif dragN(2) == 1
        goToPhase(3, ax);

        
         %Finds the point on the line that is closest to the entered point
        [l1x, l1y] = grabData('L1', ax);
        m1 = (l1y(1) - l1y(2)) / (l1x(1) - l1x(2));
        [X, Y] = perpIntersect(l1x(1), l1y(1), m1, x, y);
    
        %Draws t12 on w1
        drawPoint(X, Y, 'P1', ax)    %P1 = t12
    
        %Gets wrench 12 and the equation for the line
        w12 =  C\[Y;-X;1]; w12 = w12 / norm([w12(1), w12(2)]);
        m12 = w12(2)/w12(1); ed2 = cross([w12(1);w12(2);0], [0;0;1]);
        d2 = w12(3)*ed2; b2 = d2(2) - m12*d2(1);
    
        %Draws the second wrench line
        func2 = @(x) m12*x + b2; x3 = d2(1) + 1;
        y3 = func2(x3); drawLine(ax, 'L2', [d2(1), x3], [d2(2), y3])
    
        %finds the intersection of w12 and the locus of possible j2 positions
        r2 = ll.lengths(1);
        [j1x, j1y] = grabData('J1', ax);
        
        syms xp yp
        eqns = [((xp - j1x)^2 + (yp - j1y)^2  == r2^2); (yp == m12*xp + b2)];
        solns = solve(eqns, [xp, yp]);
    
        drawPoint(solns.xp(1), solns.yp(1), 'T7', ax)
        drawPoint(solns.xp(2), solns.yp(2), 'T8', ax)

        drawCircle(ax, r2, j1x, j1y, 'crc2')

    
        %%The locus of positions for joint 3 is placed
        %r3 = ll.lengths(2);
        %drawCircle(ax, r3, solns.xp(1), solns.yp(1), 'crc3')
    
    
        %sy1 = double(solns.yp(1)); sx1 = double(solns.xp(1));
        %%Places the quadratic curve of T2
        %T2 = [1, 0, -sy1; 0, 1, sx1; 0, 0, 1];
        %E2 = [1, 0, 0; 0, 1, 0; 0, 0, -r3^2];
        %G2 = C*(T2'*E2*T2)*C; G2 = inv(G2);
    
    
        %f = @(x,y) G2(1,1)*y.^2 + G2(2,2)*x.^2 - 2*G2(1,2)*x.*y + 2*G2(1,3)*y - 2*G2(2,3)*x + G2(3,3);
        %fimp = fimplicit(f, 'Color', 'b', 'LineWidth', 0.1, 'Tag', 'T2quad');
        %uistack(fimp, 'bottom')

    elseif dragN(3) == 1

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

        [~, ~, ~, ~, ~, ec6] = checkConditions(ax, C, phase, ll);
        if ec6 == 1
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

    end
end



end