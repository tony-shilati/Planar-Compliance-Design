function [Kmat] = calcStiffness(ax)

global K
fig = get(ax, 'Parent');
%% Gets the neccesary info to calculate wrench and stiffness
% Get the x and y coordinates from the drag point with tag 'handle1'
h1 = findobj(fig, 'Tag', 'handle1');
hx1 = h1.XData;
hy1 = h1.YData;

% Get the x and y coordinates from the drag point with tag 'handle2'
h2 = findobj(fig, 'Tag', 'handle2');
hx2 = h2.XData;
hy2 = h2.YData;

% Get the x and y coordinates from the drag point with tag 'handle3'
h3 = findobj(fig, 'Tag', 'handle3');
hx3 = h3.XData;
hy3 = h3.YData;

% Get the x and y coordinates of the first twist instantaneous center
t1 = findobj(ax, 'Tag', 'point2');
tx1 = t1.XData;
ty1 = t1. YData;

% Get the x and y coordinates of the second twist insantaneous center
t2 = findobj(ax, 'Tag', 'point3');
tx2 = t2.XData;
ty2 = t2.YData;

%% Calculates info neede to calculate each wrench
%calculate the slope(m1) and y-intercept(b1) of the line that passes
%through handle 1 and handle 2
m1 = (hy2 - hy1)/(hx2 - hx1);
b1 = hy1 - m1*hx1;

%calculate the slope(m2) and y-intercept(b2) of the line that passes
%through twist 1 and handle 3
m2 = (hy3 - ty1)/(hx3 - tx1);
b2 = hy3 - m2*hx3;

%calculate the slope(m3) and y-intercept(b3) of the line that passes
%through twist 1 and twist 2
m3 = (ty2 - ty1)/(tx2 - tx1);
b3 = ty2 - m3*tx2;


%absolute distance between handle 1 and 2 in the x direction
vec1X = abs(hx1 - hx2);
%absolute distance between handle 1 and 2 in the y direction
vec1Y = abs(hy1 - hy2);

%absolute distance between twist 1 and handle 3 in the x direction
vec2X = abs(tx1 - hx3);
%absolute distance between twist 1 and handle 3 in the y direction
vec2Y = abs(ty1 - hy3);

%absolute distance between twist 1 and 2 in the x direction
vec3X = abs(tx1 - tx2);
%absolute distance between twist 1 and 2 in the y direction
vec3Y = abs(ty1 - ty2);

%% Calculates the wrenches
%This block of code ensures that the direction of the wrench associated
%with spring 1 is oriented such that r cross n is a positive number. 
%From d = (r x n) * k

% Vector 1, direction correction
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


% Vector 2, direction correction
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
    
% Vector 3, direction correction
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


%Gets the perpendicular distance between the origin and the line
%defined by handle 1 and 2
d1 = perpDistance(hx1, hy1, vec1X, vec1Y, 0, 0);

%Gets the distance between handle 1 and 2
r1 = sqrt(vec1X^2 + vec1Y^2);

%calaculate the unit direction vector components (Fx and Fy)
ux1 = vec1X/r1;     %Fx
uy1 = vec1Y/r1;     %Fy

%wrench in Plucker ray coordinates
    
w1 = [ux1;
      uy1;
      d1];
 

%Gets the perpendicular distance between the origin and the line
%defined by twist 1 and handle 2
d2 = perpDistance(tx1, ty1, vec2X, vec2Y, 0, 0);

%Gets the distance between twist 1 and handle 3
r2 = sqrt(vec2X^2 + vec2Y^2);

%calaculate the unit direction vector components (Fx and Fy)
ux2 = vec2X/r2;     %Fx
uy2 = vec2Y/r2;     %Fy

%wrench in Plucker ray coordinates
    
w2 = [ux2;
      uy2;
      d2];


%Gets the perpendicular distance between the origin and the line
%defined by twist 1 and 2
d3 = perpDistance(tx1, ty1, vec3X, vec3Y, 0, 0);

%Gets the distance between twist 1 and 2
r3 = sqrt(vec3X^2 + vec3Y^2);

%calaculate the unit direction vector components (Fx and Fy)
ux3 = vec3X/r3;     %Fx
uy3 = vec3Y/r3;     %Fy

%wrench in Plucker ray coordinates
    
w3 = [ux3;
      uy3;
      d3];
%% Calculates the individual spring stiffnesses

%Spring stiffness 1
k1 = 1/(transpose(w1)/K*w1);

%Spring stiffness 2
k2 = 1/(transpose(w2)/K*w2);

%Spring stiffness 3
k3 = 1/(transpose(w3)/K*w3);

%% Calculates the stiffness matrix

Kmat = k1*w1*transpose(w1) + k2*w2*transpose(w2) + k3*w3*transpose(w3);

end