function [eC1, eC2, eC3, eC4, eC5] = checkConditions(ax, C, phase, ll, x, y)
eC1 = 0; eC2 = 0; eC3 = 0; eC4 = 0; eC5 = 0;
%if eCe == 0 then no error, if errCode == 1 then error (eC stands for error
%Code)
%% Conditions

%condition 1 - t34 must be outside of the quadratic defined by T2

%condition 2 - the distance between J4 and J6 must be less than r4 + r5

%Distribution conditions - At least one joint must be inside the red circle
%and at least one joint must be outside the red circle. At least one joint
%must be between the verticle red lines and at least one point must be
%outside the vertical red lines. At least one point must be between the
%horizontal red lines and at least one point must be outside of the
%horizontal red lines

global dragN

%% Get the neccesary information to check the conditions
[j1x, j1y] = grabData('J1', ax);
[j2x, j2y] = grabData('J2', ax);
[j3x, j3y] = grabData('J3', ax);
[j4x, j4y] = grabData('J4', ax);
[j5x, j5y] = grabData('J5', ax);
[j6x, j6y] = grabData('J6', ax);


[cx, cy, C] = compliantCenter(C, ax);
%Translated reference frame compliance matrix
    T = [1, 0, -cy; 0, 1, cx; 0, 0, 1];
    Cc = T*C*T';
    
    D = [Cc(1,1), Cc(1,2); Cc(2,1), Cc(2,2)];
    lambda = eig(D);

rc = sqrt((Cc(1,1) + Cc(2,2)) / Cc(3,3));

%% Check Conditions

if phase == 5 || phase == 6       
    %% condition 1
    r3 = ll.lengths(2);
    T2 = [1, 0, -j2y; 0, 1, j2x; 0, 0, 1];
    E2 = [1, 0, 0; 0, 1, 0; 0, 0, -r3^2];
    G2 = C*(T2'*E2*T2)*C;
   
    %Creates a twist where T34 will be to check if it satisfies the
    %condition
    chck_t34 = [y, -x, 1]';

    syms w31 w32 w33
    eqns = [chck_t34'*[w31;w32;w33] == 0; [w31,w32,w33]*G2*[w31;w32;w33] == 0; w31 + w32 == 1];
    solns2 = solve(eqns, [w31, w32, w33]);
    

    w3 = [double(solns2.w31(1)); double(solns2.w32(1)); double(solns2.w33(1))];
    w3p = [double(solns2.w31(2)); double(solns2.w32(2)); double(solns2.w33(2))];

%     f = @(x,y) G2(1,1)*y.^2 + G2(2,2)*x.^2 - 2*G2(1,2)*x.*y + 2*G2(1,3)*y - 2*G2(2,3)*x + G2(3,3);
%     fimp = fimplicit(f, 'Color', 'b', 'LineWidth', 0.1, 'Tag', 'T2quad');
%     uistack(fimp, 'bottom')
    
    
    %If the solutions to the system of equations are real, then the center
    %of twist 23 is outside of the quadratic T2
    if ~isreal(w3p) || ~isreal(w3)
        eC1 = 1;
    else 
        eC1 = 0;
    end


elseif phase == 7
    %% Condition 2

    %finds out which point is to be selected as joint 4 and assigns its
    %value to px and py
    [t5x, t5y] = grabData('T5', ax);
    [t6x, t6y] = grabData('T6', ax);
    D1 = sqrt((x-t5x)^2 + (y-t5y)^2); D2 = sqrt((x-t6x)^2 + (y-t6y)^2);
    if D1 > D2 
        px = t6x;
        py = t6y;

    elseif D2 >= D1
        px = t5x;
        py = t5y;

    end
    
    %Gets the distance between Joint 4 and Joint 6
    dist_J4_J6 = sqrt((px - j6x)^2 + (py - j6y)^2);
    %Gets the maximum distance allowed between joint 4 and joint 6
    max_dist = ll.lengths(4) + ll.lengths(5);

    if dist_J4_J6 <= max_dist
        eC2 = 0;
    else 
        eC2 = 1;
    end


elseif phase == 8
    %% Distributuion conditions
    
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
        eC3 = 0;
    else
        eC3 = 1;
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
        eC4 = 0;
    else
        eC4 = 1;
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
        eC5 = 0;
    else
        eC5 = 1;
    end
end 


%% Output an error message if something is wrong


if eC1 == 1
    warndlg('Twist 34 must be placed outside of the quadratic curve.', '', 'non-modal')
    uiwait
    MouseRelease(0, 0, ax)

elseif  eC2 == 1
    warndlg('The distance between J4 and J6 must be less than r4 + r5.', '', 'modal')
    uiwait
    MouseRelease(0, 0, ax)

elseif eC3 == 1
    warndlg([' At least one joint must be inside the red circle ' ...
        'and at least one joint must be outside the red circle.'], '', 'modal')
    uiwait
    MouseRelease(0, 0, ax)

elseif eC4 == 1
    warndlg(['At least one joint must be between the horizontal red lines, and at least' ...
        ' one joint must be outside of the horizontal red lines'], '', 'modal')
    uiwait
    MouseRelease(0, 0, ax)

elseif  eC5 == 1
    warndlg(['At least one joint must be between the vertical red lines, and at least' ...
        ' one joint must be outside of the vertical red lines'], '', 'modal')
    uiwait
    MouseRelease(0, 0, ax)

end


end

