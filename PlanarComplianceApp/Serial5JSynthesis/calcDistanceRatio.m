function [] = calcDistanceRatio(ax, C)
[x, y, C] = compliantCenter(C, ax);
[l1x, l1y] = grabData('L1', ax);
[l2x, l2y] = grabData('L2', ax);
[l3x, l3y] = grabData('L3', ax);
[j5x, j5y] = grabData('P3', ax);
[t23x, t23y] = grabData('P4',ax);


[w12, ~, ~] = wrenchFromLine(l1x(1), l1y(1), l1x(2), l1y(2));
[w34, ~, ~] = wrenchFromLine(l2x(1), l2y(1), l2x(2), l2y(2));
[w23, ~, ~] = wrenchFromLine(l3x(1), l3y(1), l3x(2), l3y(2));

vc = [0 1; -1 0]*[x; y];
tc = [vc(1); vc(2); 1];

v5 = [0 1; -1 0]*[j5x; j5y];
t5 = [v5(1); v5(2); 1];

[~, ~, ~, r12] = twistFromLine(ax, 'T1', C);
v12 = [0 1; -1 0]*r12;
t12 = [v12(1); v12(2); 1];



ratio = ((transpose(w12)*tc) * (transpose(w34)*t12) * (transpose(w23)*t5)) / ...
        ((transpose(w12)*t5) * (transpose(w34)*t5) * (transpose(w23)*tc));

str = '';
if sign(ratio) > 0 
    str = 'out';
elseif sign(ratio) < 0
    str = 'in';
end

% Get twist 23
r23 = [t23x; t23y];
v23 = [0 1; -1 0]*r23;
t23 = [v23(1); v23(2); 1];

% Get twist 5
r5 = [j5x; j5y];
v5 = [0 1; -1 0]*r5;
t5 = [v5(1); v5(2); 1];


syms xp yp


t = [yp; -xp; 1];

eqns1 = [((t-t23)'*(t-t23)) -  (ratio)*((t-t5)'*(t-t5)) == 0;
         t'*cross(t23, t5) == 0];

%eqns1 = [abs(ratio) + sqrt(((t-t23)'*(t-t23)) / ((t-t5)'*(t-t5))) == 0;
%        t'*cross(t23, t5) == 0];

%eqns2 = [((t-t23)'*(t-t23)) -  (ratio^2)*((t-t5)'*(t-t5)) == 0;
%        t'*cross(t23, t5) == 0];

eqns2 = [abs(ratio) - sqrt(((t-t23)'*(t-t23)) / ((t-t5)'*(t-t5))) == 0;
         t'*cross(t23, t5) == 0];

S1 = vpasolve(eqns1, [xp yp]);
S2 = vpasolve(eqns2, [xp yp]);


xp1 = S1.xp;
yp1 = S1.yp;

xp2 = S2.xp;
yp2 = S2.yp;


if strcmp(str, 'in')
    drawPoint(xp1, yp1, 'P6P', ax)
elseif strcmp(str, 'out')
    drawPoint(xp2, yp2, 'P6P', ax)
end






end