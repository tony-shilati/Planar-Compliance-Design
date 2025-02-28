function [w, m, b] = calcInfo(x1, y1, x2, y2)

k = [0; 0; 1];

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

d = dot(cross(r1,n), k);

w = [n(1); n(2); d];
w = w/norm([w(1), w(2)]);

end