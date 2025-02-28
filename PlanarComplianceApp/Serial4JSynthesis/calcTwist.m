function [x, y] = calcTwist(ax, str)

global C

fig = get(ax, 'Parent');

[xc, yc, C] = compliantCenter(C, ax);



if strcmp(str, 'TwistOne')
    %Get the neccesary information to put Wrench one in Plucker ray coordinates

    % get the x and y coordinates from the drag point with tag 'handle1'
    pt1 = findobj(fig, 'Tag', 'N1');
    x1 = pt1.XData;
    y1 = pt1.YData;

    % get the x and y coordinates from the drag point with tag 'handle2'
    pt2 = findobj(fig, 'Tag', 'N2');
    x2 = pt2.XData;
    y2 = pt2.YData;


    %calculate the slope(m1) and y-intercept(b1) of the line that passes
    %through handle 1 and handle 2
    m1 = (y2 - y1)/(x2 - x1);
    b1 = y1 - m1*x1;


    %absolute distance between handle 1 and 2 in the x direction
    vec1X = abs(x1 - x2);
    %absolute distance between handle 1 and 2 in the y direction
    vec1Y = abs(y1 - y2);


    %This block of code ensures that the direction of the wrench associated
    %with spring 1 is oriented such that r cross n is a positive number. 
    %From d = (r x n) * k

    if b1 > 0 && m1 > 0 
        vec1X = vec1X * -1;
        vec1Y = vec1Y * -1;
    
    elseif b1 > 0 && m1 <= 0
        vec1X = vec1X * -1;
    
    elseif b1 < 0 && m1 > 0
        %do nothing
    
    elseif b1 < 0 && m1 < 0 
        vec1Y = vec1Y * -1;
    elseif b1 == 0 && m1 < 0
        vec1Y = -vec1Y;
    end
        

   
 
    %Gets the perpendicular distance between the origin and the line
    %defined by handle 1 and 2
    d1 = perpDistance(x1, y1, vec1X, vec1Y, 0, 0);

    %Gets the distance between handle 1 and 2
    r1 = sqrt(vec1X^2 + vec1Y^2);

    %calaculate the unit direction vector components (Fx and Fy)
    ux1 = vec1X/r1;     %Fx
    uy1 = vec1Y/r1;     %Fy

    %wrench in Plucker ray coordinates
    
    w1 = [ux1;
          uy1;
          d1];


    %Calculate twist one
    t1 = C*w1;
    
    %normalize twist one
    T1 = t1 .* (1/t1(3,1));
    

    %Calculate the instantaneous center of rotation for t1
    %(Using eqn 7 in 2017 geometric construction paper)
  
    omega1 = [0 -1;
             1 0];
    
    %Gets direction vector component of twist one
    v1 = [T1(1,1)
         T1(2,1)];
    
    %calculates instantaneous center of rotation for twist one
    center = omega1*v1;
    
    %Defines the output arguments as the x and y value of the 
    x = center(1,1);
    y = center(2,1);
    

elseif strcmp(str, 'TwistTwo')
    %Get the neccesary information to put Wrench two in Plucker ray coordinates

    pt2 = findobj(fig, 'Tag', 'P1');
    x2 = pt2.XData;
    y2 = pt2.YData;

    pt3  = findobj(ax, 'Tag', 'N3');
    x3 = pt3.XData;
    y3 = pt3.YData;

    vec2X = abs(x3 - x2);
    vec2Y = abs(y3 - y2);

    m2 = (y3 - y2)/(x3 - x2);
    b2 = y2 - m2*x2;


    if b2 > 0 && m2 > 0 
        vec2X = vec2X * -1;
        vec2Y = vec2Y * -1;

    elseif b2 > 0 && m2 <= 0
        vec2X = vec2X * -1;

    elseif b2 < 0 && m2 > 0
        %do nothing
        

    elseif b2 < 0 && m2 < 0 
        vec2Y = vec2Y * -1;

    elseif b2 == 0 && m2 < 0
        vec2Y = -vec2Y;
 
    end

    

    d2 = perpDistance(x2, y2, vec2X, vec2Y, 0, 0);
    r2 = sqrt(vec2X^2 + vec2Y^2);

    %calaculate the unit direction vector components 
    ux2 = vec2X/r2;
    uy2 = vec2Y/r2;

    %wrench in Plucker ray coordinates
    
    w2 = [ux2;
          uy2;
          d2];
    
    %Calculate twist two
    t2 = C*w2;
    
    %normalize twist two
    T2 = t2 * 1/t2(3,1);
    
    %Calculate the instantaneous center of rotation for t2
    %(Using eqn 7 in 2017 geometric construction paper)
    
    omega2 = [0 -1;
             1 0];
    
    %Gets direction vector component of twist 2
    v2 = [T2(1,1)
         T2(2,1)];
    
    center = omega2*v2;

    x = center(1,1);
    y = center(2,1);

elseif strcmp(str, 'TwistThree')
    %Get the neccesary information to put Wrench three in Plucker ray coordinates

    pt3 = findobj(fig, 'Tag', 'N5');
    x3 = pt3.XData;
    y3 = pt3.YData;

    pt2 = findobj(fig, 'Tag', 'N6');
    x2 = pt2.XData;
    y2 = pt2.YData;


    
    vec3X = abs(x3 - x2);
    vec3Y = abs(y3 - y2);

    m3 = (y3 - y2)/(x3 - x2);
    b3 = y2 - m3*x2;

    if b3 > 0 && m3 > 0 
        vec3X = vec3X * -1;
        vec3Y = vec3Y * -1;

    elseif b3 > 0 && m3 <= 0
        vec3X = vec3X * -1;

    elseif b3 < 0 && m3 > 0
        %do nothing
        

    elseif b3 < 0 && m3 < 0 
        vec3Y = vec3Y * -1;
        
    elseif b3 == 0 && m3 < 0
        vec3Y = -vec3Y;
 
    end

    

    d3 = perpDistance(x3, y3, vec3X, vec3Y, 0, 0);
    r3 = sqrt(vec3X^2 + vec3Y^2);

    %calaculate the unit direction vector components
    ux3 = vec3X/r3;
    uy3 = vec3Y/r3;

    %wrench in Plucker ray coordinates
    
    w3 = [ux3;
          uy3;
          d3];
    
    %Calculate twist three
    t3 = C*w3;
    
    %normalize twist three
    T3 = t3 * 1/t3(3,1);
    
    %Calculate the instantaneous center of rotation for t3
    %(Using eqn 7 in 2017 geometric construction paper)
    
    omega3 = [0 -1;
             1 0];
    
    %Gets direction vector component of twist 3
    v3 = [T3(1,1)
         T3(2,1)];
    
    center = omega3*v3;

    x = center(1,1);
    y = center(2,1);

elseif strcmp(str, 'TwistFour')
    %Get the neccesary information to put Wrench three in Plucker ray coordinates

    t3 = findobj(fig, 'Tag', 'P3');
    t3x = t3.XData;
    t3y = t3.YData;

    n7 = findobj(fig, 'Tag', 'N7');
    n7x = n7.XData;
    n7y = n7.YData;


    
    vec4X = abs(t3x - n7x);
    vec4Y = abs(t3y - n7y);

    m4 = (t3y - n7y)/(t3x - n7x);
    b4 = n7y - m4*n7x;

    if b4 > 0 && m4 > 0 
        vec4X = vec4X * -1;
        vec4Y = vec4Y * -1;

    elseif b4 > 0 && m4 <= 0
        vec4X = vec4X * -1;

    elseif b4 < 0 && m4 > 0
        %do nothing
        

    elseif b4 < 0 && m4 < 0 
        vec4Y = vec4Y * -1;
        
    elseif b4 == 0 && m4 < 0
        vec4Y = -vec4Y;
 
    end

    

    d4 = perpDistance(t3x, t3y, vec4X, vec4Y, 0, 0);
    r4 = sqrt(vec4X^2 + vec4Y^2);

    %calaculate the unit direction vector components
    ux4 = vec4X/r4;
    uy4 = vec4Y/r4;

    %wrench in Plucker ray coordinates
    
    w4 = [ux4;
          uy4;
          d4];
    
    %Calculate twist three
    t4 = C*w4;
    
    %normalize twist three
    T4 = t4 * 1/t4(3,1);
    
    %Calculate the instantaneous center of rotation for t3
    %(Using eqn 7 in 2017 geometric construction paper)
    
    omega4 = [0 -1;
             1 0];
    
    %Gets direction vector component of twist 3
    v4 = [T4(1,1)
         T4(2,1)];
    
    center = omega4*v4;

    x = center(1,1);
    y = center(2,1);
end 

end