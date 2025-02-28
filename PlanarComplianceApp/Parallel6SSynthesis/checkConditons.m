function [errCode1, errCode2, errCode3] = checkConditons(K, ax)

[x, y, K] = stiffnessCenter(K, ax);
fig = get(ax, 'Parent');
gde = findobj(fig, 'Tag', 'gde');


%% Get general information to be used for all conditions
[p1x, p1y] = grabData('P1', ax);
[p2x, p2y] = grabData('P2', ax);
[p3x, p3y] = grabData('P3', ax);

[n1x, n1y] = grabData('N1', ax);
[n2x, n2y] = grabData('N2', ax);
[n3x, n3y] = grabData('N3', ax);
[n4x, n4y] = grabData('N4', ax);
[n5x, n5y] = grabData('N5', ax);
[n6x, n6y] = grabData('N6', ax);

[rx, ry] = grabData('ccplot', ax);



%% Distribution of elastic component locations - circle intersections
%Get the neccesary information to calculate the conditions
%Translated stiffness matrix
rk = sqrt((rx(1) - x)^2 + (ry(1) - y)^2);
m1 = (n1y - p1y) / (n1x - p1x);
m2 = (n2y - p1y) / (n2x - p1x);
m3 = (n3y - p2y) / (n3x - p2x);
m4 = (n4y - p2y) / (n4x - p2x);
m5 = (n5y - p3y) / (n5x - p3x);
m6 = (n6y - p3y) / (n6x - p3x);

b1 = n1y - m1*n1x;
b2 = n2y - m2*n2x;
b3 = n3y - m3*n3x;
b4 = n4y - m4*n4x;
b5 = n5y - m5*n5x;
b6 = n6y - m6*n6x;

syms cx cy

ceqn = (cx - x)^2 + (cy - y)^2 - rk^2 == 0;

eqns1 = [ceqn; cy - m1*cx - b1 == 0];
eqns2 = [ceqn; cy - m2*cx - b2 == 0];
eqns3 = [ceqn; cy - m3*cx - b3 == 0];
eqns4 = [ceqn; cy - m4*cx - b4 == 0];
eqns5 = [ceqn; cy - m5*cx - b5 == 0];
eqns6 = [ceqn; cy - m6*cx - b6 == 0];

s1 = solve(eqns1, [cx, cy]);
s2 = solve(eqns2, [cx, cy]);
s3 = solve(eqns3, [cx, cy]);
s4 = solve(eqns4, [cx, cy]);
s5 = solve(eqns5, [cx, cy]);
s6 = solve(eqns6, [cx, cy]);


%Check the conditions
int_count = 0;

if isreal(s1.cx) && isreal(s1.cy)
    int_count = int_count + 1;
end

if isreal(s2.cx) && isreal(s2.cy)
    int_count = int_count + 1;
end

if isreal(s3.cx) && isreal(s3.cy)
    int_count = int_count + 1;
end

if isreal(s4.cx) && isreal(s4.cy)
    int_count = int_count + 1;
end

if isreal(s5.cx) && isreal(s5.cy)
    int_count = int_count + 1;
end

if isreal(s6.cx) && isreal(s6.cy)
    int_count = int_count + 1;
end

if int_count == 0 || int_count == 6
    errCode1 = 1;
else
    errCode1 = 0;
end


%% Distribution of elastic component locations - perpendicular vectors
%Get the neccesary information to calculate the conditions
tc = [y; -x; 1];

[c1x, c1y] = grabData('cone1', ax);
[c2x, c2y] = grabData('cone2', ax);

m_cone1 = (c1y(1) - c1y(2)) / (c1x(1) - c1y(2));
m_cone2 = (c2y(1) - c2y(2)) / (c2x(1) - c2x(2));
b_cone1 = y - m_cone1*x;
b_cone2 = y - m_cone2*x;

fcone1 = @(x) m_cone1*x + b_cone1;
fcone2 = @(x) m_cone2*x + b_cone2;

xc1 = x + 1; yc1 = fcone1(xc1);
xc2 = x + 1; yc2 = fcone2(xc2);

tc1 = [yc1; -xc1; 1];
tc2 = [yc2; -xc2; 1];

[x1, y1] = perpIntersect(n1x, n1y, m1, x, y);
[x2, y2] = perpIntersect(n2x, n2y, m2, x, y);
[x3, y3] = perpIntersect(n3x, n3y, m3, x, y);
[x4, y4] = perpIntersect(n4x, n4y, m4, x, y);
[x5, y5] = perpIntersect(n5x, n5y, m5, x, y);
[x6, y6] = perpIntersect(n6x, n6y, m6, x, y);

t1 = [y1; -x1; 1];
t2 = [y2; -x2; 1];
t3 = [y3; -x3; 1];
t4 = [y4; -x4; 1];
t5 = [y5; -x5; 1];
t6 = [y6; -x6; 1];

T = [t1, t2, t3, t4, t5, t6];
T1 = [tc, tc1, tc2]; T1(3, 3) = -1;
T2 = -T1; T2(:,1) = tc;

lambda_x = 0;
lambda_nu = 0;

for mat = T
    if all(T1\mat > 0) || all(T2\mat > 0)
        lambda_x = lambda_x + 1;
    else
        lambda_nu = lambda_nu + 1;
    end
end

if lambda_x == 0 || lambda_nu == 0
    errCode2 = 1;
else
    errCode2 = 0;
end

%Return error messages if the conditions aren't satisfied



%% Quadratic curve intersection for w5 and w6
%Get the neccesary information to calculate the conditions
%Check the conditions

K5 = get(findobj(fig, 'Tag', 'stiff5'), 'String');
K6 = get(findobj(fig, 'Tag', 'stiff6'), 'String');

k5 = str2double(K5);
k6 = str2double(K6);

%Return error messages if the conditions aren't satisfied
if sign(k6) == sign(k5)
    errCode3 = 0;
else
    errCode3 = 1;
end

%Sign of spring constants
%Get the neccesary information to calculate the conditions
% k1 = get(findobj(fig, 'Tag', 'stiff1'), 'String'); K1 = str2double(k1);
% k2 = get(findobj(fig, 'Tag', 'stiff2'), 'String'); K2 = str2double(k2);
% k3 = get(findobj(fig, 'Tag', 'stiff3'), 'String'); K3 = str2double(k3);
% k4 = get(findobj(fig, 'Tag', 'stiff4'), 'String'); K4 = str2double(k4);
% k5 = get(findobj(fig, 'Tag', 'stiff5'), 'String'); K5 = str2double(k5);
% k6 = get(findobj(fig, 'Tag', 'stiff6'), 'String'); K6 = str2double(k6);

%% Making sure all signs are positive
% Z = double([K1, K2, K3, K4, K5, K6] > 0);
% 
% if any(Z == 0)
%         if norm(Z,1) < 5
%             w1 = wrenchFromLine(l1x(1), l1y(1), l1x(2), l1y(2));
%             w2 = wrenchFromLine(l2x(1), l2y(1), l2x(2), l2y(2));
%             w3 = wrenchFromLine(l3x(1), l3y(1), l3x(2), l3y(2));
%             w4 = wrenchFromLine(l4x(1), l4y(1), l4x(2), l4y(2));
%             w5 = wrenchFromLine(l5x(1), l5y(1), l5x(2), l5y(2));
%             w6 = wrenchFromLine(l6x(1), l6y(1), l6x(2), l6y(2));
% 
% 
%             t35 = cross(w3, w5);
%             t45 = cross(w4, w5);
%             t12 = cross(w1, w2);
%             t13 = cross(w1, w3);
%             t15 = cross(w1, w5);
%             t46 = cross(w4, w6);
%             t56 = cross(w5, w6); 
%             t26 = cross(w2, w6);
%             t23 = cross(w2, w3);
%             t25 = cross(w2, w5);
%             t36 = cross(w3, w6);
%             t14 = cross(w1, w4);
%             t24 = cross(w2, w4);
%             t34 = cross(w3, w4);
%             
% 
%             if K1 <= 0 && K2 <= 0
%                 drawQuadCurve2(ax, t34, t56, t35, t46)
%                 set(gde, 'String', ['Rotate wrench 1 or wrench 2 about T12 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K1 <= 0 && K3 <= 0
%                 drawQuadCurve2(ax, t24, t56, t25, t46)
%                 set(gde, 'String', ['Rotate wrench 1 about T12 or wrench 3 about T34 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K1 <= 0 && K4 <= 0
%                 drawQuadCurve2(ax, t23, t56, t25, t36)
%                 set(gde, 'String', ['Rotate wrench 1 about T12 or wrench 4 about T34 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K1 <= 0 && K5 <= 0
%                 drawQuadCurve2(ax, t23, t46, t24, t36)
%                 set(gde, 'String', ['Rotate wrench 1 about T12 or wrench 5 about T56 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K1 <= 0 && K6 <= 0
%                 drawQuadCurve2(ax, t23, t45, t24, t35)
%                 set(gde, 'String', ['Rotate wrench 1 about T12 or wrench 6 about T56 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K2 <= 0 && K3 <= 0
%                 drawQuadCurve2(ax, t14, t56, t15, t46)
%                 set(gde, 'String', ['Rotate wrench 2 about T12 or wrench 3 about T34 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K2 <= 0 && K4 <= 0
%                 drawQuadCurve2(ax, t13, t56, t15, t36)
%                 set(gde, 'String', ['Rotate wrench 2 about T12 or wrench 4 about T34 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K2 <= 0 && K5 <= 0
%                 drawQuadCurve2(ax, t13, t46, t14, t36)
%                 set(gde, 'String', ['Rotate wrench 2 about T12 or wrench 5 about T56 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K2 <= 0 && K6 <= 0
%                 drawQuadCurve2(ax, t13, t45, t14, t35)
%                 set(gde, 'String', ['Rotate wrench 2 about T12 or wrench 6 about T56 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K3 <= 0 && K4 <= 0
%                 drawQuadCurve2(ax, t12, t56, t15, t26)
%                 set(gde, 'String', ['Rotate wrench 3 or wrench 4 about T34 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K3 <= 0 && K5 <= 0
%                 drawQuadCurve2(ax, t12, t46, t14, t26)
%                 set(gde, 'String', ['Rotate wrench 3 about T34 or wrench 5 about T56 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K3 <= 0 && K6 <= 0
%                 drawQuadCurve2(ax, t12, t46, t14, t24)
%                 set(gde, 'String', ['Rotate wrench 3 about T34 or wrench 6 about T56 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K4 <= 0 && K5 <= 0
%                 drawQuadCurve2(ax, t12, t36, t13, t26)
%                 set(gde, 'String', ['Rotate wrench 4 about T34 or wrench 5 about T56 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K4 <= 0 && K6 <= 0
%                 drawQuadCurve2(ax, t12, t35, t13, t25)
%                 set(gde, 'String', ['Rotate wrench 4 about T34 or wrench 6 about T56 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             elseif K5 <= 0 && K6 <= 0
%                 drawQuadCurve2(ax, t12, t34, t13, t24)
%                 set(gde, 'String', ['Rotate wrench 5 or wrench 6 about T56 until it changes ' ...
%              'intersection relation with the quadratic curve.'])
% 
%             end
% 
% 
%         elseif norm(Z,1) == 5
%             if K1 < 0
%                 delete(findobj(ax, 'Tag', 'QuadCurve'))
%                 drawQuadCurve(ax, K, 4);
%                 set(gde, 'String', ['Rotate wrench 1 about T12 until it changes ' ...
%                     'intersection relation with the quadratic curve having the same color.'])
%             
%             elseif K2 < 0 
%                 delete(findobj(ax, 'Tag', 'QuadCurve'))
%                 drawQuadCurve(ax, K, 5);
%                 set(gde, 'String', ['Rotate wrench 2 about T12 until it changes ' ...
%                     'intersection relation with the quadratic curve having the same color.'])
%             
%             elseif K3 < 0
%                 delete(findobj(ax, 'Tag', 'QuadCurve'))
%                 drawQuadCurve(ax, K, 6);
%                 set(gde, 'String', ['Rotate wrench 3 about T34 until it changes ' ...
%                     'intersection relation with the quadratic curve having the same color.'])
%             
%             elseif K4 < 0
%                 delete(findobj(ax, 'Tag', 'QuadCurve'))
%                 drawQuadCurve(ax, K, 7);
%                 set(gde, 'String', ['Rotate wrench 4 about T34 until it changes ' ...
%                     'intersection relation with the quadratic curve having the same color.'])
%         
%             elseif K5 < 0
%                 delete(findobj(ax, 'Tag', 'QuadCurve'))
%                 drawQuadCurve(ax, K, 8);
%                 set(gde, 'String', ['Rotate wrench 5 about T56 until it changes ' ...
%                     'intersection relation with the quadratic curve having the same color.'])
%                 
%             elseif K6 < 0
%                 delete(findobj(ax, 'Tag', 'QuadCurve'))
%                 drawQuadCurve(ax, K, 9);
%                 set(gde, 'String', ['Rotate wrench 6 about T56 until it changes ' ...
%                     'intersection relation with the quadratic curve having the same color.'])
%             end
%            
%         end
%     
% else
%     delete(findobj(ax, 'Tag', 'QuadCurve'))
% end



%% Return error messages if the conditions aren't satisfied



end