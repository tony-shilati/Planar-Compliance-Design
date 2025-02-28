function [m, b, w, r] = twistFromLine(ax, str, C)


if strcmp(str, 'T1')
    [x1, y1] = grabData('N1', ax);
    [x2, y2] = grabData('N2', ax);

elseif strcmp(str, 'T2')
    [x1, y1] = grabData('N3', ax);
    [x2, y2] = grabData('N4', ax);

end


[~, ~, C] = compliantCenter(C, ax);

%neccesary info
k = [0; 0 ; 1];

omega = [0 -1;
         1 0];
   
%calculate the slope(m1) and y-intercept(b1) of the line that passes
%through handle 1 and handle 2
m = (y2 - y1)/(x2 - x1);
b = y1 - m*x1;

[px, py] = perpIntersect(x1, y1, m, 0, 0);
r1 = [px; py; 0];
    
vec = [(x2 - x1); (y2 - y1); 0];

mag = norm(vec);

n = vec/mag;
        

%Gets the perpendicular distance between the origin and the line
%defined by handle 1 and 2
d = dot(cross(r1,n), k);
    
w = [n(1);
      n(2);
      d];


%Calculate twist
t = C*w;
    
%normalize twist
t = t/t(3);
    
%Calculate the instantaneous center of rotation for t1
%(Using eqn 7 in 2017 geometric construction paper)
  

    
%Gets direction vector component of twist one
v = [t(1,1)
     t(2,1)];
    
%calculates instantaneous center of rotation for twist one
r = omega*v;

%x = r(1)
%y = r(2)
    


end