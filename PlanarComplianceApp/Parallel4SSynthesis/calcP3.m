function [ x,y ] = calcP3(ax)

global K

[x1,y1] = grabData('N3',ax);
[x2,y2] = grabData('N4',ax);

m = (y2-y1)/(x2-x1);

[px, py] = perpIntersect(x1, y1, m, 0, 0);

r = [px; py; 0];

vec = [(x1 - x2); (y1 - y2); 0];

mag = norm(vec);

n = vec/mag;

k = [0; 0; 1];

d = dot(cross(r, n), k);

w = [n(1); n(2); d];

t1 = K\w;

t1 = t1/t1(3);

v = [t1(1); t1(2)];

center = [0 -1; 1 0]*v;

x = center(1);
y = center(2);


end

