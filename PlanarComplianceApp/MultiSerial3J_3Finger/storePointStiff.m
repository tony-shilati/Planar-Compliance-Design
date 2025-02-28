function []  = storePointStiff(ax)
% This function stores the point stiffness matrix at each finger tip to 
% an object

global Ps Ss
fig = get(ax, 'Parent');
%% Accesses neccesary information from GUI
[l1x, l1y] = grabData('L1', ax); w1 = wrenchFromLine(l1x(1), l1y(1), l1x(2), l1y(2));
[l2x, l2y] = grabData('L2', ax); w2 = wrenchFromLine(l2x(1), l2y(1), l2x(2), l2y(2));
[l3x, l3y] = grabData('L3', ax); w3 = wrenchFromLine(l3x(1), l3y(1), l3x(2), l3y(2));
[l4x, l4y] = grabData('L4', ax); w4 = wrenchFromLine(l4x(1), l4y(1), l4x(2), l4y(2));
[l5x, l5y] = grabData('L5', ax); w5 = wrenchFromLine(l5x(1), l5y(1), l5x(2), l5y(2));
[l6x, l6y] = grabData('L6', ax); w6 = wrenchFromLine(l6x(1), l6y(1), l6x(2), l6y(2));

[n1x, n1y] = grabData('N1', ax);
[n2x, n2y] = grabData('N2', ax);
[n3x, n3y] = grabData('N3', ax);
[n4x, n4y] = grabData('N4', ax);
[n5x, n5y] = grabData('N5', ax);
[n6x, n6y] = grabData('N6', ax);

[p1x, p1y] = grabData('P1', ax);
[p2x, p2y] = grabData('P2', ax);
[p3x, p3y] = grabData('P3', ax);

k1 = str2double(get(findobj(fig, 'Tag', 'stiff1'), 'String'));
k2 = str2double(get(findobj(fig, 'Tag', 'stiff2'), 'String'));
k3 = str2double(get(findobj(fig, 'Tag', 'stiff3'), 'String'));
k4 = str2double(get(findobj(fig, 'Tag', 'stiff4'), 'String'));
k5 = str2double(get(findobj(fig, 'Tag', 'stiff5'), 'String'));
k6 = str2double(get(findobj(fig, 'Tag', 'stiff6'), 'String'));

%% Stores the six spring mechanism info
Ss = six_spring;

Ss.Px = [p1x, p2x, p3x];
Ss.Py = [p1y, p2y, p3y];

Ss.Nx = [n1x, n2x, n3x, n4x, n5x, n6x];
Ss.Ny = [n1y, n2y, n3y, n4y, n5y, n6y];

%% Calculates the point stiffness matrix at each contact point

K1 = k1*(w1*w1') + k2*(w2*w2');
K2 = k3*(w3*w3') + k4*(w4*w4');
K3 = k5*(w5*w5') + k6*(w6*w6');


Ps = pointStiff;
Ps.K1 = K1;
Ps.K2 = K2;
Ps.K3 = K3;

end