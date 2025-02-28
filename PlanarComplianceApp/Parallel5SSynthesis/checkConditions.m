function [errCode1, errCode2] = checkConditions(ax)

%errCode == 0 then the condition is satisfied
%errCode == 1 then the conditon is not satisfied

%Conditon 1 - the first two points placed must be on the same side of the
%third line that is placed

%Condition 2 - If the third point placed is inside the triangle formed by
%the first three lines placed, then the wrench line of action associated
%with the fourth point cannot intersect the triangle. If the fourth point
%is placed outside of the triangle, then the wrench line of action
%associated with it must intersect the triangle


[l4x, l4y] = grabData('L4', ax);

%% conditon 1
if isempty(l4x) || isempty(l4y)
    %Get the neccesary information to check condition 1
    [x1, y1] = grabData('N1', ax);
    [x2, y2] = grabData('N2', ax);
    [x3, y3] = grabData('N3', ax);      
    [x4, y4] = grabData('N4', ax);
    
    slope_l3 = (y4 - y3) / (x4 - x3);       
    yint_l3 = y3 - slope_l3*x3;
    
    %Check condition 1
    [Ix1, Iy1] = perpIntersect(x3, y3, slope_l3, x1, y1);
    [Ix2, Iy2] = perpIntersect(x3, y3, slope_l3, x2, y2);
    
    check1x = Ix1 - x1; check1y = Iy1 - y1;
    check2x = Ix2 - x2; check2y = Iy2 - y2;
    
    if sign(check1x) == sign(check2x) && sign(check1y) == sign(check2y)
        errCode1 = 0;
    else
        errCode1 = 1;
    end 

else
    errCode1 = 0;
end


%% condition 2
if ~isempty(l4x) && ~isempty(l4y)
    %Get the neccesary infromation to check condition 2
    [l1x, l1y] = grabData('L1', ax);
    [l2x, l2y] = grabData('L2', ax);
    [x3, y3] = grabData('N3', ax);      
    [x4, y4] = grabData('N4', ax); 
    [t4x, t4y] = grabData('N5', ax);
    
    slope_l1 = (l1y(1) - l1y(2)) / (l1x(1) - l1x(2));
    yint_l1 = l1y(1) - slope_l1*l1x(1);
    
    slope_l2 = (l2y(1) - l2y(2)) / (l2x(1) - l2x(2));
    yint_l2 = l2y(1) - slope_l2*l2x(1);
    
    slope_l4 = (l4y(1) - l4y(2)) / (l4x(1) - l4x(2));
    yint_l4 = l4y(1) - slope_l4*l4x(1);
    
    slope_l3 = (y4 - y3) / (x4 - x3);       
    yint_l3 = y3 - slope_l3*x3;    

    [Int1x, Int1y] = calcInt(-slope_l4, 1, -slope_l1, 1, yint_l4, yint_l1);
    [Int2x, Int2y] = calcInt(-slope_l4, 1, -slope_l2, 1, yint_l4, yint_l2);
    [Int3x, Int3y] = calcInt(-slope_l4, 1, -slope_l3, 1, yint_l4, yint_l3);
    
    [vert1x, vert1y] = calcInt(-slope_l1, 1, -slope_l2, 1, yint_l1, yint_l2);
    [vert2x, vert2y] = calcInt(-slope_l1, 1, -slope_l3, 1, yint_l1, yint_l3);
    [vert3x, vert3y] = calcInt(-slope_l2, 1, -slope_l3, 1, yint_l2, yint_l3);
    
    
    %Check the signs of the differences to see if the point is in the circle or
    %not 
    IO1 = 0; %If IO1 is 0 the point is out of the triangle, else its in

    [w1, ~, ~] = calcInfo(vert1x, vert1y, vert2x, vert2y);
    [w2, ~, ~] = calcInfo(vert1x, vert1y, vert3x, vert3y);
    [w3, ~, ~] = calcInfo(vert2x, vert2y, vert3x, vert3y);

    t12 = cross(w1, w2);
    t12 = t12/t12(3);
    t13 = cross(w1, w3);
    t13 = t13/t13(3);
    t23 = cross(w2, w3);
    t23 = t23/t23(3);


    t4 = createTwistFromPoint(t4x, t4y);

    T = [t12(1), t13(1), t23(1);
        t12(2), t13(2), t23(2);
        t12(3), t13(3), t23(3)];

    x = T\t4;

    if any(x <= 0)
        IO1 = 0;
    else
        IO1 = 1;
    end
    


    IO2 = 0; %If IO2 is 1 then the line intersects the triangle, else it doesn't

    v12 = [vert1x, vert1y; vert2x, vert2y];
    v13 = [vert1x, vert1y; vert3x, vert3y];
    v23 = [vert2x, vert2y; vert3x, vert3y];

    if Int1x < max(v12(:,1)) && Int1x > min(v12(:,1)) && Int1y < max(v12(:,2)) && Int1y > min(v12(:,2))
        IO2 = 1;
    elseif Int2x < max(v13(:,1)) && Int2x > min(v13(:,1)) && Int2y < max(v13(:,2)) && Int2y > min(v13(:,2))
        IO2 = 1;
    elseif Int3x < max(v23(:,1)) && Int3x > min(v23(:,1)) && Int3y < max(v23(:,2)) && Int3y > min(v23(:,2))
        IO2 = 1;
    else
        IO2 = 0;

    end


    
    if IO1 == 0 && IO2 == 0
        errCode2 = 1;
    elseif IO1 == 1 && IO2 == 1
        errCode2 = 1;
    elseif IO1 == 0 && IO2 == 1
        errCode2 = 0;
    elseif IO1 == 1 && IO2 == 0
        errCode2 = 0;
    end
    
   
else
    errCode2 = 0;
end

%%
    
if errCode1 == 1
    try
        warndlg('Points 1 and 2 must be on the same side of line 3', '', 'modal')
        uiwait
    catch
    end
    

end

if errCode2 == 1

    try
        warndlg(['If point four is inside the triangle created by the first three' ...
            ' lines, then the fourth line cannot intersect the triangle. If the ' ...
            'fourth point is outside of the triangle, the fourth line must ' ...
            'intersect the triangle.'], '', 'modal')
        uiwait
    catch 
    end

   

end



end