function [c1,c2,c3, Cmat] = calcCompliance(ax)
format short
global C
%Gets the neccesaery information to calculates the individual compliances
K = inv(C);

pt1 = findobj(ax, 'Tag', 'point1');
pt1x = pt1.XData;
pt1y = pt1.YData;

pt2 = findobj(ax, 'Tag', 'point2');
pt2x = pt2.XData;
pt2y = pt2.YData;

pt3 = findobj(ax, 'Tag', 'point3');
pt3x = pt3.XData;
pt3y = pt3.YData;

omegainv = [0 1; -1 0];

r1 = [pt1x; pt1y];

r2 = [pt2x; pt2y];

r3 = [pt3x; pt3y];

%Calculates the two vector (v) for each twist
v1 = omegainv*r1;

v2 = omegainv*r2;

v3 = omegainv*r3;

%Deals with the case of empty 2 vectors
if isempty(v2)
    v2 = [0; 0];
end

if isempty(v3)
    v3 = [0; 0];
end

%Calculates the twist associated with each joint

t1 = [v1(1);v1(2);1];

t2 = [v2(1);v2(2);1];

t3 = [v3(1);v3(2);1];

%Calculates the compliance associated with each joint
c1 = 1/(transpose(t1)/C*t1);

c2 = 1/(transpose(t2)/C*t2);

c3 = 1/(transpose(t3)/C*t3);

%Calculates the compliance matrix
Cmat = (c1*t1*transpose(t1)) + (c2*t2*transpose(t2)) + (c3*t3*transpose(t3));



end