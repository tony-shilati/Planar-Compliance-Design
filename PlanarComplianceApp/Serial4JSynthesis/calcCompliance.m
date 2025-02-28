function [c1, c2, c3, c4, Cmat] = calcCompliance(x1, y1, x2, y2, x3, y3, x4, y4)
format short
global C
%Gets the neccesaery information to calculates the individual compliances
try
    %pt1 = findobj(ax, 'Tag', 'P1');
    pt1x = x1;
    pt1y = y1;
    
    %pt2 = findobj(ax, 'Tag', 'P2');
    pt2x = x2;
    pt2y = y2;
    
    %pt3 = findobj(ax, 'Tag', 'P3');
    pt3x = x3;
    pt3y = y3;
    
    %pt4 = findobj(ax, 'Tag', 'P4');
    pt4x = x4;
    pt4y = y4;
catch
    return
end

omegainv = [0 1; -1 0];

r1 = [pt1x; pt1y];

r2 = [pt2x; pt2y];

r3 = [pt3x; pt3y];

r4 = [pt4x; pt4y];


%Calculates the two vector (v) for each twist
v1 = omegainv*r1;

v2 = omegainv*r2;

v3 = omegainv*r3;

v4 = omegainv*r4;

%Deals with the case of empty 2 vectors
if isempty(v2)
    v2 = [0; 0];
end

if isempty(v3)
    v3 = [0; 0];
end

if isempty(v4)
    v4 = [0; 0];
end

%Calculates the twist associated with each joint

t1 = [v1(1);v1(2);1];

t2 = [v2(1);v2(2);1];

t3 = [v3(1);v3(2);1];

t4 = [v4(1);v4(2);1];

%Calculates the wrenches needed to calculate the compliances
w12 = cross(t1, t2);

w14 = cross(t1, t4);

w23 = cross(t2, t3);

w24 = cross(t2, t4);

w34 = cross(t3, t4);

%Calculates the compliance associated with each joint
c1 = (transpose(w23)*C*w24) / ((transpose(w23)*t1) * (transpose(w24)*t1));

c2 = (transpose(w34)*C*w14) / ((transpose(w34)*t2) * (transpose(w14)*t2));

c3 = (transpose(w14)*C*w12) / ((transpose(w14)*t3) * (transpose(w12)*t3));

c4 = (transpose(w12)*C*w23) / ((transpose(w12)*t4) * (transpose(w23)*t4));


%Calculates the compliance matrix
Cmat = (c1*t1*transpose(t1)) + (c2*t2*transpose(t2)) + (c3*t3*transpose(t3) + c4*t4*transpose(t4));


end