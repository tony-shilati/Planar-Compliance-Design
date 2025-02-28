function [w, m, b] = wrenchFromLine(x1, y1, x2, y2)
format long

m = (y1 - y2) / (x1 - x2);
if isinf(m)
    m = 1e20;
end

b = y1 - m*x1;

vec = [(x1 - x2); (y1 - y2); 0];

[px, py] = perpIntersect(x1, y1, m ,0, 0);

r1 = [px; py; 0];

mag = norm(vec);

n = vec/mag;

rso3 = [0,    -r1(3), r1(2);
        r1(3), 0,    -r1(1);
       -r1(2), r1(1), 0]; %so(3) representation of r

rxn = rso3*n; %cross product of r and n

d = rxn(3); %dot product of rxn and k

w = [n(1); n(2); d];
w = w/norm([w(1), w(2)]);

end