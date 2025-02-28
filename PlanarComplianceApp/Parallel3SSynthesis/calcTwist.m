function [x, y] = calcTwist(ax, str)

global K

fig = get(ax, 'Parent');

[~, ~, K] = stiffnessCenter(K, ax);

C = inv(K);

if strcmp(str, 'TwistOne')
    %Get the neccesary information to put Wrench one in Plucker ray coordinates

    % get the x and y coordinates from the drag point with tag 'handle1'
    pt1 = findobj(fig, 'Tag', 'handle1');
    x1 = pt1.XData;
    y1 = pt1.YData;

    % get the x and y coordinates from the drag point with tag 'handle2'
    pt2 = findobj(fig, 'Tag', 'handle2');
    x2 = pt2.XData;
    y2 = pt2.YData;


    %calculate the slope(m1) and y-intercept(b1) of the line that passes
    %through handle 1 and handle 2
    m1 = (y2 - y1)/(x2 - x1);


    [px, py] = perpIntersect(x1, y1, m1, 0, 0);
    r1 = [px; py; 0];
    %absolute distance between handle 1 and 2 in the x direction
    vec1X = (x1 - x2);
    %absolute distance between handle 1 and 2 in the y direction
    vec1Y = (y1 - y2);
    
    vec1 = [vec1X; vec1Y; 0];

    mag = norm(vec1);

    n1 = vec1/mag;

    k = [0; 0 ; 1];
        

    %Gets the perpendicular distance between the origin and the line
    %defined by handle 1 and 2
    d1 = dot(cross(r1,n1), k);
    
    w1 = [n1(1);
          n1(2);
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

    %outputs the transpose spring wrench to the user
    w11 = sprintf('%0.2f', w1(1,1)); 
    w21 = sprintf('%0.2f', w1(2,1));
    w31 = sprintf('%0.2f', w1(3,1));

    wrench1 = findobj(fig, 'Tag', 'wrench1');
    set(wrench1, 'String', ['  [  ' w11 '  ' w21 '  ' w31 '  ]'])


    %outputs the stiffness to the user
    k1 = 1 / (transpose(w1)/K*w1);
    K1 = sprintf('%0.2f', k1);

    stiff1 = findobj(fig, 'Tag', 'stiff1');
    set(stiff1, 'String', ['  ' K1])
    

elseif strcmp(str, 'TwistTwo')
    %Get the neccesary information to put Wrench two in Plucker ray coordinates

    pt2 = findobj(fig, 'Tag', 'point2');
    x2 = pt2.XData;
    y2 = pt2.YData;

    pt3  = findobj(ax, 'Tag', 'handle3');
    x3 = pt3.XData;
    y3 = pt3.YData;

    m2 = (y3 - y2)/(x3 - x2);

    [px, py] = perpIntersect(x2, y2, m2, 0, 0);
    r2 = [px; py; 0];
    
    vec2X = (x2 - x3);
    
    vec2Y = (y2 - y3);

    vec2 = [vec2X; vec2Y; 0];

    mag = norm(vec2);

    n2 = vec2/mag;

    k = [0; 0 ; 1];
        

    %Gets the perpendicular distance between the origin and the line
    %defined by handle 1 and 2
    d2 = dot(cross(r2,n2), k);

    
    w2 = [n2(1);
          n2(2);
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

    %outputs the spring wrench to the user
    w11 = sprintf('%0.2f', w2(1,1)); 
    w21 = sprintf('%0.2f', w2(2,1));
    w31 = sprintf('%0.2f', w2(3,1));

    wrench2 = findobj(fig, 'Tag', 'wrench2');
    set(wrench2, 'String', ['  [  ' w11 '  ' w21 '  ' w31 '  ]'])

    %Outputs the stiffness to the user
    k2 = 1 / (transpose(w2)/K*w2);
    K2 = sprintf('%0.2f', k2);

    stiff2 = findobj(fig, 'Tag', 'stiff2');
    set(stiff2, 'String', ['  ' K2])

elseif strcmp(str, 'TwistThree')
    %Get the neccesary information to put Wrench three in Plucker ray coordinates

    pt3 = findobj(fig, 'Tag', 'point3');
    x3 = pt3.XData;
    y3 = pt3.YData;

    pt2 = findobj(fig, 'Tag', 'point2');
    x2 = pt2.XData;
    y2 = pt2.YData;


    m3 = (y3 - y2)/(x3 - x2);
    
    [px, py] = perpIntersect(x3, y3, m3, 0, 0);
    r3 = [px; py; 0];
    
    vec3X = (x3 - x2);
    
    vec3Y = (y3 - y2);
    
    vec3 = [vec3X; vec3Y; 0];

    mag = norm(vec3);

    n3 = vec3/mag;

    k = [0; 0 ; 1];
        

    %Gets the perpendicular distance between the origin and the line
    %defined by handle 1 and 2
    d3 = dot(cross(r3,n3), k);
    
    w3 = [n3(1);
          n3(2);
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


    %outputs the spring wrench to the user
    w11 = sprintf('%0.2f', w3(1,1)); 
    w21 = sprintf('%0.2f', w3(2,1));
    w31 = sprintf('%0.2f', w3(3,1));

    wrench3 = findobj(fig, 'Tag', 'wrench3');
    set(wrench3, 'String', ['  [  ' w11 '  ' w21 '  ' w31 '  ]'])

    %Outputs the stiffness to the user
    k3 = 1 / (transpose(w3)/K*w3);
    K3 = sprintf('%0.2f', k3);

    stiff3 = findobj(fig, 'Tag', 'stiff3');
    set(stiff3, 'String', ['  ' K3])
end 

end