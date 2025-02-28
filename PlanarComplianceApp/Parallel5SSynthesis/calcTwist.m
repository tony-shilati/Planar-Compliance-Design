function [x, y] = calcTwist(ax, str, K)


if strcmp(str, 'P3')
    [x1,y1] = grabData('N3',ax);
    [x2, y2] = grabData('N4', ax);

    x = [x1, x2];
    y = [y1, y2];
end


[~, ~, K] = stiffnessCenter(K, ax);

m = (y(1) - y(2)) / (x(1) - x(2));

[px, py] = perpIntersect(x(1), y(1), m, 0, 0);

r1 = [px; py; 0];

vec = [(x(1) - x(2)); (y(1) - y(2)); 0];

mag = norm(vec);

n = vec/mag;

k = [0; 0; 1];

d = dot(cross(r1, n), k);

w = [n(1); n(2); d];

t = K\w;

t = t/t(3);

v = [t(1); t(2)];

r = [0 -1; 1 0] * v;

x = r(1);

y = r(2);

end
