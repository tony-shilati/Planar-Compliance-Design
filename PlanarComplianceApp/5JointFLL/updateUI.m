function [phase] = updateUI(x, y, ax, C, phase)

global ll

fig = get(ax, 'Parent');


if phase == 1
    % Gets link lengths
    l1 = str2double(get(findobj(fig, 'Tag', 'link1'), 'String'));
    l2 = str2double(get(findobj(fig, 'Tag', 'link2'), 'String'));
    l3 = str2double(get(findobj(fig, 'Tag', 'link3'), 'String'));
    l4 = str2double(get(findobj(fig, 'Tag', 'link4'), 'String'));

    ll = links; %Initialize link length object
    ll.lengths = [l1, l2, l3, l4]; %Sets the link values
    phase = 2;



elseif phase == 2
    %Draws Joint 1
    drawPoint(x, y, 'J1', ax)

    %draws the circle and changes the axes
    r1 = norm(ll.lengths, 1);
    drawCircle(ax, r1, x, y, 'crc1')

    %Draws the locus of possible positions for joint 2
    r2 = ll.lengths(1); drawCircle(ax, r2, x, y, 'crc2')
    
    %Gets the wrench equation
    w1 = C\[y;-x;1]; w1 = w1/norm([w1(1), w1(2)]);
    m1 = w1(2)/w1(1); ed1 = cross([w1(1);w1(2);0], [0;0;1]);
    d1 = w1(3)*ed1; b1 = d1(2) - m1*d1(1);

    %draws the wrench line
    func1 = @(x) m1*x + b1; x2 = d1(1) + 1;
    y2 = func1(x2); drawLine(ax, 'L1', [d1(1), x2], [d1(2), y2])

    
elseif phase == 3
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


elseif  phase == 4

    %Joint 2 is placed
    [t7x, t7y] = grabData('T7', ax);
    [t8x, t8y] = grabData('T8', ax);

    D1 = sqrt((x-t7x)^2 + (y-t7y)^2); D2 = sqrt((x-t8x)^2 + (y-t8y)^2);

    if D1 > D2 
        drawPoint(t8x, t8y, 'J2', ax)
        delete(findobj(ax, 'Tag', 'T7'))
        delete(findobj(ax, 'Tag', 'T8'))

    elseif D2 >= D1
        drawPoint(t7x, t7y, 'J2', ax)
        delete(findobj(ax, 'Tag', 'T7'))
        delete(findobj(ax, 'Tag', 'T8'))
    end
    
    [j2x, j2y] = grabData('J2', ax);
    %The locus of positions for joint 3 is placed
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


    f = @(x,y) G2(1,1)*y.^2 + G2(2,2)*x.^2 - 2*G2(1,2)*x.*y + 2*G2(1,3)*y - 2*G2(2,3)*x + G2(3,3);
    fimp = fimplicit(f, 'Color', 'b', 'LineWidth', 0.1, 'Tag', 'T2quad');
    uistack(fimp, 'bottom')



elseif phase == 5

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

    %T3 and T3' are plotted
    t3 = C*w3; t3 = t3/t3(3);
    t3p = C*w3p; t3p = t3p/t3p(3);

    drawPoint(-t3(2), t3(1), 'T3', ax);
    drawPoint(-t3p(2), t3p(1), 'T4', ax);
    

elseif phase == 6
    %Chooses either t4 or t3 to be the location of joint 3
    [t3x, t3y] = grabData('T3', ax);
    [t4x, t4y] = grabData('T4', ax);

    D1 = sqrt((x-t3x)^2 + (y-t3y)^2); D2 = sqrt((x-t4x)^2 + (y-t4y)^2);
    r4 = ll.lengths(3);

    if D1 > D2 
        drawPoint(t4x, t4y, 'J3', ax)
        delete(findobj(ax, 'Tag', 'T3'))
        delete(findobj(ax, 'Tag', 'T4'))


    elseif D2 >= D1
        drawPoint(t3x, t3y, 'J3', ax)
        delete(findobj(ax, 'Tag', 'T3'))
        delete(findobj(ax, 'Tag', 'T4'))

    end

    %Plots the line of wrench 34
    [t34x, t34y] = grabData('P2', ax);
    t34 = [t34y; -t34x; 1];
    w34 = C\t34; w34 = w34 / norm([w34(1), w34(2)]);
    m34 = w34(2)/w34(1); ed3 = cross([w34(1); w34(2); 0], [0;0;1]);
    d3 = w34(3)*ed3; b3 = d3(2) - m34*d3(1);

    func3 = @(x) m34*x + b3; x4 = d3(1) + 1;
    y4 = func3(x4);
    drawLine(ax, 'L3', [d3(1), x4], [d3(2), y4]) %L3 == wrench 34

    %Finds the intersections of wrench 34 and the locus of j4 postions
    [j3x, j3y] = grabData('J3', ax);

    syms xp yp
    eqns2 = [(yp - m34*xp == b3); ((xp-j3x)^2 + (yp-j3y)^2 == r4^2)];
    solns3 = solve(eqns2, [xp, yp]);

    %Plots Joint 4 at the intersection that is closer to t12
    xp1 = solns3.xp(1); xp2 = solns3.xp(2);
    yp1 = solns3.yp(1); yp2 = solns3.yp(2);
    [t12x, t12y] = grabData('P1', ax);

    D1 = sqrt((t12x - xp1)^2 + (t12y - yp1)^2);
    D2 = sqrt((t12x - xp2)^2 + (t12y - yp2)^2);

    if D1 > D2
        drawPoint(xp2, yp2, 'J4', ax)
        r5 = ll.lengths(4);
        drawCircle(ax, r5, xp2, yp2, 'crc5')
    elseif D2 >= D1
        drawPoint(xp1, yp1, 'J4', ax)
        r5 = ll.lengths(4);
        drawCircle(ax, r5, xp1, yp1, 'crc5')
    end

    %The quadratic curve passing trough the first four joints is plotted
    drawQuadCurve(ax, C, ll)

elseif phase == 7
    %Chooses either T5 or T6 to be the location of joint 5
    [t5x, t5y] = grabData('T5', ax);
    [t6x, t6y] = grabData('T6', ax);

    D1 = sqrt((x-t5x)^2 + (y-t5y)^2); D2 = sqrt((x-t6x)^2 + (y-t6y)^2);

    if D1 > D2 
        drawPoint(t6x, t6y, 'J5', ax)
        delete(findobj(ax, 'Tag', 'T5'))
        delete(findobj(ax, 'Tag', 'T6'))

    elseif D2 >= D1
        drawPoint(t5x, t5y, 'J5', ax)
        delete(findobj(ax, 'Tag', 'T5'))
        delete(findobj(ax, 'Tag', 'T6'))

    end
    connectJoints(ax)
    Outputs(ax, C)
    triangles(ax)
    [ec1, ec2, ec3, ec4, ec5, ec6] = checkConditions(ax, C, phase, ll);
    


end


end