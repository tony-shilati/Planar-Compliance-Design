function [phase] = updateUI(x, y, ax, C, phase)

fig = get(ax, 'Parent');
global ll

if phase == 1
    %% Gets link lengths
    l1 = str2double(get(findobj(fig, 'Tag', 'link1'), 'String'));
    l2 = str2double(get(findobj(fig, 'Tag', 'link2'), 'String'));
    l3 = str2double(get(findobj(fig, 'Tag', 'link3'), 'String'));
    l4 = str2double(get(findobj(fig, 'Tag', 'link4'), 'String'));
    l5 = str2double(get(findobj(fig, 'Tag', 'link5'), 'String'));

    ll = links; %Initialize link length object
    ll.lengths = [l1, l2, l3, l4, l5]; %Sets the link values
    phase = 2;

elseif phase == 2
    %% Draws Joint 1
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

elseif phase == 3
    %% Draws Joint 6
    drawPoint(x, y, 'J6', ax)

    %%Calculates T16
    %[j1x, j1y] = grabData('J1', ax);

    %m16 = (j1y - y) / (j1x - x);
    %d16 = perpIntersect(x, y, m16, 0, 0);
    %w16 = [(j1x - x); (j1y - y); d16];
    %t16 = C*w16; t16 = t16/t16(3);

    %%Plots t16
    %drawPoint(-t16(2), t16(1), 'P3', ax) %P3 is t16

elseif phase == 4
    %% Joint 2 is placed

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

    elseif D2 >= D1
        drawPoint(x1, y1, 'J2', ax)

    end
    [j2x, j2y] = grabData('J2', ax);

    %% The locus of positions for joint 3 is placed
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

    %% System of equations is solved for w3 and w3'
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
     %% Chooses either t4 or t3 to be the location of joint 3
    [t3x, t3y] = grabData('T3', ax);
    [t4x, t4y] = grabData('T4', ax);

    D1 = sqrt((x-t3x)^2 + (y-t3y)^2); D2 = sqrt((x-t4x)^2 + (y-t4y)^2);

    if D1 > D2 
        drawPoint(t4x, t4y, 'J3', ax)
        delete(findobj(ax, 'Tag', 'T3'))
        delete(findobj(ax, 'Tag', 'T4'))


    elseif D2 >= D1
        drawPoint(t3x, t3y, 'J3', ax)
        delete(findobj(ax, 'Tag', 'T3'))
        delete(findobj(ax, 'Tag', 'T4'))

    end

%     %% Draws the the twist center T23
    [j2x, j2y] = grabData('J2', ax);
    [j3x, j3y] = grabData('J3', ax);
% 
%     t2 = [j2y, -j2x, 1]';
%     t3 = [j3y, -j3x, 1]';
% 
%     w23 = cross(t2, t3);
%     t23 = C*w23;
%     t23 = t23/t23(3);
% 
%     %draws twist 23
%     drawPoint(-t23(2), t23(1), 'P4', ax) 

    
    %% Calculates and plots the quadratic curve f1236
    [j1x, j1y] = grabData('J1', ax);
    [j6x, j6y] = grabData('J6', ax);

    t1 = [j1y; -j1x; 1];
    t2 = [j2y; -j2x; 1];
    t3 = [j3y; -j3x; 1];
    t6 = [j6y; -j6x; 1];

    w12 = cross(t1, t2);
    w36 = cross(t3, t6);
    w13 = cross(t1, t3);
    w26 = cross(t2, t6);

    H = (w12'*C*w36)*(w13*w26') - (w13'*C*w26)*(w12*w36');
    A = H + H';

    f1236 = @(x,y) A(1,1)*y.^2 + A(2,2)*x.^2 - 2*A(1,2)*x.*y + 2*A(1,3)*y - 2*A(2,3)*x + A(3,3);

    fimp1236 = fimplicit(f1236, 'Color', 'b', 'LineWidth', 0.1, 'Tag', 'F1236');
    uistack(fimp1236, 'bottom')

    %Draws the locus of possible positions for joint 4 around joint 3
    r4 = ll.lengths(3);
    drawCircle(ax, r4, j3x, j3y, 'crc4')

    %% finds the intersections of the quadratic and the circle and plots them
    QuadCircleInts(ax, ll, A)

elseif phase == 7
    %% Chooses either t5 or t6 to be the location of joint 4
    [t5x, t5y] = grabData('T5', ax);
    [t6x, t6y] = grabData('T6', ax);

    D1 = sqrt((x-t5x)^2 + (y-t5y)^2); D2 = sqrt((x-t6x)^2 + (y-t6y)^2);

    if D1 > D2 
        drawPoint(t6x, t6y, 'J4', ax)
        delete(findobj(ax, 'Tag', 'T5'))
        delete(findobj(ax, 'Tag', 'T6'))


    elseif D2 >= D1
        drawPoint(t5x, t5y, 'J4', ax)
        delete(findobj(ax, 'Tag', 'T5'))
        delete(findobj(ax, 'Tag', 'T6'))

    end
    
    %% Draws the circles around point 4 and point 6
    [j4x, j4y] = grabData('J4', ax);
    [j6x, j6y] = grabData('J6', ax);

    r5 = ll.lengths(4);
    r6 = ll.lengths(5);

    drawCircle(ax, r5, j4x, j4y, 'crc5')
    drawCircle(ax, r6, j6x, j6y, 'crc6')

    %% find the intersections of circle 4 and circle 6 and plot them.
    
    %Vector Equations of the circle
    T4 = [1, 0, -j4y; 
          0, 1, j4x;
          0, 0, 1];
    
    E4 = [1, 0, 0; 
          0, 1, 0; 
          0, 0, -(r5^2)];

    T6 = [1, 0, -j6y; 
          0, 1, j6x;
          0, 0, 1];
    
    E6 = [1, 0, 0; 
          0, 1, 0; 
          0, 0, -(r6^2)];

    [x1, y1, x2, y2] = Intersections('cc', 0, 0, E4, T4, E6, T6);

    %draws the two possible locations of J5
    drawPoint(x1, y1, 'T7', ax)
    drawPoint(x2, y2, 'T8', ax)

elseif phase == 8
    %% Chooses either t7 or t8 to be the location of joint 5
    [t7x, t7y] = grabData('T7', ax);
    [t8x, t8y] = grabData('T8', ax);

    D1 = sqrt((x-t7x)^2 + (y-t7y)^2); D2 = sqrt((x-t8x)^2 + (y-t8y)^2);

    if D1 > D2 
        drawPoint(t8x, t8y, 'J5', ax)
        delete(findobj(ax, 'Tag', 'T7'))
        delete(findobj(ax, 'Tag', 'T8'))


    elseif D2 >= D1
        drawPoint(t7x, t7y, 'J5', ax)
        delete(findobj(ax, 'Tag', 'T7'))
        delete(findobj(ax, 'Tag', 'T8'))

    end
    connectJoints(ax);
    Outputs(ax, C);


end


end