function [errCode1, errCode2, errCode3, errCode4, errCode5, errCode6] = checkConditions(ax, C, phase, ll)

%if errCode == 0 then no error, if errCode == 1 then error
%% Conditions
%condition 1 - t12 must be in the triangle formed by J3, J4, and J5

%condition 2 - t34 must be in the triangle formed by J1, J2, and J5

%Distribution conditions - At least one joint must be inside the red circle
%and at least one joint must be outside the red circle. At least one joint
%must be between the verticle red lines and at least one point must be
%outside the vertical red lines. At least one point must be between the
%horizontal red lines and at least one point must be outside of the
%horizontal red lines

%condition 3 - t34 must be outside of the quadratic defined by T2


%% Get the neccesary information to check the conditions
[j1x, j1y] = grabData('J1', ax);
[j2x, j2y] = grabData('J2', ax);
[j3x, j3y] = grabData('J3', ax);
[j4x, j4y] = grabData('J4', ax);
[j5x, j5y] = grabData('J5', ax);

[t12x, t12y] = grabData('P1', ax);
[t34x, t34y] = grabData('P2', ax);

t1 = [j1y; -j1x; 1];
t2 = [j2y; -j2x; 1];
t3 = [j3y; -j3x; 1];
t4 = [j4y; -j4x; 1];
t5 = [j5y; -j5x; 1];

t12 = [t12y; -t12x; 1];
t34 = [t34y; -t34x; 1];

[cx, cy, C] = compliantCenter(C, ax);
%Translated reference frame compliance matrix
    T = [1, 0, -cy; 0, 1, cx; 0, 0, 1];
    Cc = T*C*T';
    
    D = [Cc(1,1), Cc(1,2); Cc(2,1), Cc(2,2)];
    lambda = eig(D);

rc = sqrt((Cc(1,1) + Cc(2,2)) / Cc(3,3));

%% Check Conditions

if phase == 5 || phase == 6
    %%condition 3
    r3 = ll.lengths(2);
    T2 = [1, 0, -j2y; 0, 1, j2x; 0, 0, 1];
    E2 = [1, 0, 0; 0, 1, 0; 0, 0, -r3^2];
    G2 = C*(T2'*E2*T2)*C;
    
    syms w31 w32 w33
    eqns = [t34'*[w31;w32;w33] == 0; [w31,w32,w33]*G2*[w31;w32;w33] == 0; w31 + w32 == 1];
    solns2 = solve(eqns, [w31, w32, w33]);
    

    w3 = [double(solns2.w31(1)); double(solns2.w32(1)); double(solns2.w33(1))];
    w3p = [double(solns2.w31(2)); double(solns2.w32(2)); double(solns2.w33(2))];

    f = @(x,y) G2(1,1)*y.^2 + G2(2,2)*x.^2 - 2*G2(1,2)*x.*y + 2*G2(1,3)*y - 2*G2(2,3)*x + G2(3,3);
    fimp = fimplicit(f, 'Color', 'b', 'LineWidth', 0.1, 'Tag', 'T2quad');
    uistack(fimp, 'bottom')
    
    
    
    if ~isreal(w3p) || ~isreal(w3)
        errCode6 = 1;
    else 
        errCode6 = 0;
    end
    
    errCode1 = 0;
    errCode2 = 0;
    errCode3 = 0;
    errCode4 = 0;
    errCode5 = 0;

elseif phase == 7
    %%condition 1
    
    T1 = [t3, t4, t5];
    x1 = T1\t12;
    
    if any(x1 < 0)
        errCode1 = 1;
    else
        errCode1 = 0;
    end
    
    %%condtion 2
    
    T2 = [t1, t2, t5];
    x2 = T2\t34;
    
    if any(x2 < 0)  
        errCode2 = 1;
    else
        errCode2 = 0;
    end
    
    %%Distributuion conditions
    
    %Circle conditoin
    circ = @(x,y) (x-cx)^2 + (y - cy)^2 - rc^2;
    c1 = circ(j1x, j1y); c2 = circ(j2x, j2y); c3 = circ(j3x, j3y);
    c4 = circ(j4x, j4y); c5 = circ(j5x, j5y); cc = sign(circ(cx, cy));
    
    Cs = [c1, c2, c3, c4, c5];
    
    count1 = 0;
    for c = Cs
        if sign(c) == cc
            count1 = count1 + 1;
        end
    end
    
    if count1 > 0 && count1 < 5
        errCode3 = 0;
    else
        errCode3 = 1;
    end
    
    %Horizontal line condition
    xp = cx + sqrt(lambda(2)/C(3,3)); xn = cx - sqrt(lambda(2)/C(3,3));
    
    Jx = [j1x, j2x, j3x, j4x, j5x];
    
    count2 = 0;
    for x = Jx
        if x < xp && x > xn
            count2 = count2 + 1;
        end
    end
    
    if count2 > 0 && count2 < 5
        errCode4 = 0;
    else
        errCode4 = 1;
    end
    
    %Vertical line condition
    yp = cy + sqrt(lambda(1)/C(3,3)); yn = cy - sqrt(lambda(1)/C(3,3));
    
    Jy = [j1y, j2y, j3y, j4y, j5y];
    
    count3 = 0;
    for y = Jy
        if y < yp && y > yn
            count3 = count3 + 1;
        end
    end
    
    if count3 > 0 && count3 < 5
        errCode5 = 0;
    else
        errCode5 = 1;
    end

    errCode6 = 0;
end 


%% Output an error message if something is wrong

if errCode1 == 1
    warndlg(['Twist 12 (blue point) must be in the triangle defined by joint 3, ' ...
        'joint 4, and joint 5. This triangle is defined by the blue dashed lines' ...
        ' on the graph.'], '', 'modal')
    uiwait
    MouseRelease(0, 0)
elseif errCode2 == 1
    warndlg(['Twist 34 (yellow point) must be in the triangle defined by joint 1, ' ...
        'joint 2, and joint 5. This triangle is defined by the yellow dashed lines' ...
        ' on the graph.'], '', 'modal')
    uiwait
    MouseRelease(0, 0)

elseif errCode3 == 1
    warndlg(['At least one joint mus be inside the red circle surronding the compliance' ...
        ' center and at leat one joint must be outside the circle.'], '', 'modal')
    uiwait
    MouseRelease(0, 0)

elseif errCode4 == 1
    warndlg(['At least one joint must be between the verticle red lines, and at least' ...
        ' one joint must be outside of the vertical red lines'], '', 'modal')
    uiwait
    MouseRelease(0, 0)

elseif errCode5 == 1
    warndlg(['At least one joint must be between the horizontal red lines, and at least' ...
        ' one joint must be outside of the horizontal red lines'], '', 'modal')
    uiwait
    MouseRelease(0, 0)

elseif  errCode6 == 1
    warndlg('Twist 34 must be placed outside of the quadratic curve.', '', 'modal')
    MouseRelease(0, 0)

end

end

