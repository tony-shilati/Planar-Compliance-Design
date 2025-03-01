function [] = calcJoints(ax)
%This function calculates the intersection point of two lines

% [coef11 coef12] [x] _ [b1]
% [coef21 coef22] [y] – [b2]


[l1x, l1y] = grabData('L1', ax);
[l2x, l2y] = grabData('L2', ax);
[l3x, l3y] = grabData('L3', ax);
[l4x, l4y] = grabData('L4', ax);
[j5x, j5y] = grabData('P3', ax);

w12 = wrenchFromLine(l1x(1), l1y(1), l1x(2), l1y(2));
w14 = wrenchFromLine(l4x(1), l4y(1), l4x(2), l4y(2));
w23 = wrenchFromLine(l3x(1), l3y(1), l3x(2), l3y(2));
w34 = wrenchFromLine(l2x(1), l2y(1), l2x(2), l2y(2));

t1 = cross(w12, w14);
t1 = t1/t1(3);
t2 = cross(w12, w23);
t2 = t2/t2(3);
t3 = cross(w23, w34);
t3 = t3/t3(3);
t4 = cross(w14, w34);
t4 = t4/t4(3);

omega = [0 -1; 1 0];
r1 = omega*[t1(1); t1(2)];
r2 = omega*[t2(1); t2(2)];
r3 = omega*[t3(1); t3(2)];
r4 = omega*[t4(1); t4(2)];



drawPoint(r1(1), r1(2), 'J1', ax)
drawPoint(r2(1), r2(2), 'J2', ax)
drawPoint(r3(1), r3(2), 'J3', ax)
drawPoint(r4(1), r4(2), 'J4', ax)
drawPoint(j5x, j5y, 'J5', ax)


link1 = [r1(1), r1(2); r2(1), r2(2)];
link2 = [r2(1), r2(2); r3(1), r3(2)];
link3 = [r3(1), r3(2); r4(1), r4(2)];
link4 = [r4(1), r4(2); j5x, j5y];

drawLine(link1(:,1), link1(:,2), 'link1', ax)
drawLine(link2(:,1), link2(:,2), 'link2', ax)
drawLine(link3(:,1), link3(:,2), 'link3', ax)
drawLine(link4(:,1), link4(:,2), 'link4', ax)


end
