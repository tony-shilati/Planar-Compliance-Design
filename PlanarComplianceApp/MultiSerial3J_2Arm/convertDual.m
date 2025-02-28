function [] = convertDual(ax, K)

%% Find neccesary objects
fig = get(ax, 'Parent');
format long

%Group wrench boxes
g11 = findobj(fig, 'Tag', 'g11');
g12 = findobj(fig, 'Tag', 'g12');
g13 = findobj(fig, 'Tag', 'g13');
g21 = findobj(fig, 'Tag', 'g21');
g22 = findobj(fig, 'Tag', 'g22');
g23 = findobj(fig, 'Tag', 'g23');

%Wrench lines of action
[l1x, l1y] = grabData('L1', ax);
[l2x, l2y] = grabData('L2', ax);
[l3x, l3y] = grabData('L3', ax);
[l4x, l4y] = grabData('L4', ax);
[l5x, l5y] = grabData('L5', ax);
[l6x, l6y] = grabData('L6', ax);

%Stiffness boxes in the output panel
k1 = findobj(fig, 'Tag', 'stiff1');
k2 = findobj(fig, 'Tag', 'stiff2');
k3 = findobj(fig, 'Tag', 'stiff3');
k4 = findobj(fig, 'Tag', 'stiff4');
k5 = findobj(fig, 'Tag', 'stiff5');
k6 = findobj(fig, 'Tag', 'stiff6');

%% Get neccesary information

%Gets wrenches in each group
G11 = str2double(get(g11, 'String'));
G12 = str2double(get(g12, 'String'));
G13 = str2double(get(g13, 'String'));
G21 = str2double(get(g21, 'String'));
G22 = str2double(get(g22, 'String'));
G23 = str2double(get(g23, 'String'));

%Creates an array for each group
grp1 = [G11, G12, G13];
grp2 = [G21, G22, G23];

%Gets each unit wrench from the wrench lines of action
w1 = wrenchFromLine(l1x(1), l1y(1), l1x(2), l1y(2));    w1 = w1 / norm([w1(1) w1(2)]);
w2 = wrenchFromLine(l2x(1), l2y(1), l2x(2), l2y(2));    w2 = w2 / norm([w2(1) w2(2)]);
w3 = wrenchFromLine(l3x(1), l3y(1), l3x(2), l3y(2));    w3 = w3 / norm([w3(1) w3(2)]);
w4 = wrenchFromLine(l4x(1), l4y(1), l4x(2), l4y(2));    w4 = w4 / norm([w4(1) w4(2)]);
w5 = wrenchFromLine(l5x(1), l5y(1), l5x(2), l5y(2));    w5 = w5 / norm([w5(1) w5(2)]);
w6 = wrenchFromLine(l6x(1), l6y(1), l6x(2), l6y(2));    w6 = w6 / norm([w6(1) w6(2)]);

%Gets stiffness of each wrench
K1 = str2double(get(k1, 'String'));
K2 = str2double(get(k2, 'String'));
K3 = str2double(get(k3, 'String'));
K4 = str2double(get(k4, 'String'));
K5 = str2double(get(k5, 'String'));
K6 = str2double(get(k6, 'String'));

%Gets the twists created by all possible combinations of wrenches
t12 = cross(w1, w2); t12 = t12/t12(3);
t13 = cross(w1, w3); t13 = t13/t13(3);
t14 = cross(w1, w4); t14 = t14/t14(3);
t15 = cross(w1, w5); t15 = t15/t15(3);
t16 = cross(w1, w6); t16 = t16/t16(3);
t23 = cross(w2, w3); t23 = t23/t23(3);
t24 = cross(w2, w4); t24 = t24/t24(3);
t25 = cross(w2, w5); t25 = t25/t25(3);
t26 = cross(w2, w6); t26 = t26/t26(3);
t34 = cross(w3, w4); t34 = t34/t34(3);
t35 = cross(w3, w5); t35 = t35/t35(3);
t36 = cross(w3, w6); t36 = t36/t36(3);
t45 = cross(w4, w5); t45 = t45/t45(3);
t46 = cross(w4, w6); t46 = t46/t46(3);
t56 = cross(w5, w6); t56 = t56/t56(3);

%Sets t1 - t6 to the neccesary twist based on the groups
if all(unique(grp1) == [1 2 3])
    %Group1
    t1 = t23; t2 = t13; t3 = t12;

    %Group 2
    t4 = t56; t5 = t46; t6 = t45;

    %Compliances
    c1 = 1/(K1*(w1'*t1)^2);
    c2 = 1/(K2*(w2'*t2)^2);
    c3 = 1/(K3*(w3'*t3)^2);
    c4 = 1/(K4*(w4'*t4)^2);
    c5 = 1/(K5*(w5'*t5)^2);
    c6 = 1/(K6*(w6'*t6)^2);

elseif all(unique(grp1) == [1 2 4])
    %Group1
    t1 = t24; t2 = t14; t3 = t12;

    %Group 2
    t4 = t56; t5 = t36; t6 = t35;

    %Compliances
    c1 = 1/(K1*(w1'*t1)^2);
    c2 = 1/(K2*(w2'*t2)^2);
    c3 = 1/(K4*(w4'*t3)^2);
    c4 = 1/(K3*(w3'*t4)^2);
    c5 = 1/(K5*(w5'*t5)^2);
    c6 = 1/(K6*(w6'*t6)^2);

elseif all(unique(grp1) == [1 2 5])
    %Group1
    t1 = t25; t2 = t15; t3 = t12;

    %Group 2
    t4 = t46; t5 = t36; t6 = t34;

    %Compliances
    c1 = 1/(K1*(w1'*t1)^2);
    c2 = 1/(K2*(w2'*t2)^2);
    c3 = 1/(K5*(w5'*t3)^2);
    c4 = 1/(K3*(w3'*t4)^2);
    c5 = 1/(K4*(w4'*t5)^2);
    c6 = 1/(K6*(w6'*t6)^2);

elseif all(unique(grp1) == [1 2 6])
    %Group1
    t1 = t26; t2 = t16; t3 = t12;

    %Group 2
    t4 = t45; t5 = t35; t6 = t34;

    %Compliances
    c1 = 1/(K1*(w1'*t1)^2);
    c2 = 1/(K2*(w2'*t2)^2);
    c3 = 1/(K6*(w6'*t3)^2);
    c4 = 1/(K3*(w3'*t4)^2);
    c5 = 1/(K4*(w4'*t5)^2);
    c6 = 1/(K5*(w5'*t6)^2);

elseif all(unique(grp1) == [1 3 4])
    %Group1
    t1 = t34; t2 = t14; t3 = t13;

    %Group 2
    t4 = t56; t5 = t26; t6 = t25;

    %Compliances
    c1 = 1/(K1*(w1'*t1)^2);
    c2 = 1/(K3*(w3'*t2)^2);
    c3 = 1/(K4*(w4'*t3)^2);
    c4 = 1/(K2*(w2'*t4)^2);
    c5 = 1/(K5*(w5'*t5)^2);
    c6 = 1/(K6*(w6'*t6)^2);

elseif all(unique(grp1) == [1 3 5])
    %Group1
    t1 = t35; t2 = t15; t3 = t13;

    %Group 2
    t4 = t46; t5 = t26; t6 = t24;

    %Compliances
    c1 = 1/(K1*(w1'*t1)^2);
    c2 = 1/(K3*(w3'*t2)^2);
    c3 = 1/(K5*(w5'*t3)^2);
    c4 = 1/(K2*(w2'*t4)^2);
    c5 = 1/(K4*(w4'*t5)^2);
    c6 = 1/(K6*(w6'*t6)^2);

elseif all(unique(grp1) == [1 3 6])
    %Group1
    t1 = t36; t2 = t16; t3 = t13;

    %Group 2
    t4 = t45; t5 = t25; t6 = t24;

    %Compliances
    c1 = 1/(K1*(w1'*t1)^2);
    c2 = 1/(K3*(w3'*t2)^2);
    c3 = 1/(K6*(w6'*t3)^2);
    c4 = 1/(K2*(w2'*t4)^2);
    c5 = 1/(K4*(w4'*t5)^2);
    c6 = 1/(K5*(w5'*t6)^2);

elseif all(unique(grp1) == [1 4 5])
    %Group1
    t1 = t45; t2 = t15; t3 = t14;

    %Group 2
    t4 = t36; t5 = t26; t6 = t23;

    %Compliances
    c1 = 1/(K1*(w1'*t1)^2);
    c2 = 1/(K4*(w4'*t2)^2);
    c3 = 1/(K5*(w5'*t3)^2);
    c4 = 1/(K2*(w2'*t4)^2);
    c5 = 1/(K3*(w3'*t5)^2);
    c6 = 1/(K6*(w6'*t6)^2);

elseif all(unique(grp1) == [1 4 6])
    %Group1
    t1 = t46; t2 = t16; t3 = t14;

    %Group 2
    t4 = t35; t5 = t25; t6 = t23;

    %Compliances
    c1 = 1/(K1*(w1'*t1)^2);
    c2 = 1/(K4*(w4'*t2)^2);
    c3 = 1/(K6*(w6'*t3)^2);
    c4 = 1/(K2*(w2'*t4)^2);
    c5 = 1/(K3*(w3'*t5)^2);
    c6 = 1/(K5*(w5'*t6)^2);

elseif all(unique(grp1) == [1 5 6])
    %Group1
    t1 = t56; t2 = t16; t3 = t15;

    %Group 2
    t4 = t34; t5 = t24; t6 = t23;

    %Compliances
    c1 = 1/(K1*(w1'*t1)^2);
    c2 = 1/(K5*(w5'*t2)^2);
    c3 = 1/(K6*(w6'*t3)^2);
    c4 = 1/(K2*(w2'*t4)^2);
    c5 = 1/(K3*(w3'*t5)^2);
    c6 = 1/(K4*(w4'*t6)^2);

%%
elseif all(unique(grp2) == [1 2 3])
    %Group1
    t4 = t23; t5 = t13; t6 = t12;

    %Group 2
    t1 = t56; t2 = t46; t3 = t45;

    %Compliances
    c4 = 1/(K1*(w1'*t4)^2);
    c5 = 1/(K2*(w2'*t5)^2);
    c6 = 1/(K3*(w3'*t6)^2);
    c1 = 1/(K4*(w4'*t1)^2);
    c2 = 1/(K5*(w5'*t2)^2);
    c3 = 1/(K6*(w6'*t3)^2);

elseif all(unique(grp2) == [1 2 4])
    %Group1
    t4 = t24; t5 = t14; t6 = t12;

    %Group 2
    t1 = t56; t2 = t36; t3 = t35;

    %Compliances
    c4 = 1/(K1*(w1'*t4)^2);
    c5 = 1/(K2*(w2'*t5)^2);
    c6 = 1/(K4*(w4'*t6)^2);
    c1 = 1/(K3*(w3'*t1)^2);
    c2 = 1/(K5*(w5'*t2)^2);
    c3 = 1/(K6*(w6'*t3)^2);

elseif all(unique(grp2) == [1 2 5])
    %Group1
    t4 = t25; t5 = t15; t6 = t12;

    %Group 2
    t1 = t46; t2 = t36; t3 = t34;

    %Compliances
    c4 = 1/(K1*(w1'*t4)^2);
    c5 = 1/(K2*(w2'*t5)^2);
    c6 = 1/(K5*(w5'*t6)^2);
    c1 = 1/(K3*(w3'*t1)^2);
    c2 = 1/(K4*(w4'*t2)^2);
    c3 = 1/(K6*(w6'*t3)^2);

elseif all(unique(grp2) == [1 2 6])
    %Group1
    t4 = t26; t5 = t16; t6 = t12;

    %Group 2
    t1 = t45; t2 = t35; t3 = t34;

    %Compliances
    c4 = 1/(K1*(w1'*t4)^2);
    c5 = 1/(K2*(w2'*t5)^2);
    c6 = 1/(K6*(w6'*t6)^2);
    c1 = 1/(K3*(w3'*t1)^2);
    c2 = 1/(K4*(w4'*t2)^2);
    c3 = 1/(K5*(w5'*t3)^2);

elseif all(unique(grp2) == [1 3 4])
    %Group1
    t4 = t34; t5 = t14; t6 = t13;

    %Group 2
    t1 = t56; t2 = t26; t3 = t25;

    %Compliances
    c4 = 1/(K1*(w1'*t4)^2);
    c5 = 1/(K3*(w3'*t5)^2);
    c6 = 1/(K4*(w4'*t6)^2);
    c1 = 1/(K2*(w2'*t1)^2);
    c2 = 1/(K5*(w5'*t2)^2);
    c3 = 1/(K6*(w6'*t3)^2);

elseif all(unique(grp2) == [1 3 5])
    %Group1
    t1 = t35; t2 = t15; t3 = t13;

    %Group 2
    t4 = t46; t5 = t26; t6 = t24;

    %Compliances
    c4 = 1/(K1*(w1'*t4)^2);
    c5 = 1/(K3*(w3'*t5)^2);
    c6 = 1/(K5*(w5'*t6)^2);
    c1 = 1/(K2*(w2'*t1)^2);
    c2 = 1/(K4*(w4'*t2)^2);
    c3 = 1/(K6*(w6'*t3)^2);

elseif all(unique(grp2) == [1 3 6])
    %Group1
    t4 = t36; t5 = t16; t6 = t13;

    %Group 2
    t1 = t45; t2 = t25; t3 = t24;

    %Compliances
    c4 = 1/(K1*(w1'*t4)^2);
    c5 = 1/(K3*(w3'*t5)^2);
    c6 = 1/(K6*(w6'*t6)^2);
    c1 = 1/(K2*(w2'*t1)^2);
    c2 = 1/(K4*(w4'*t2)^2);
    c3 = 1/(K5*(w5'*t3)^2);

elseif all(unique(grp2) == [1 4 5])
    %Group1
    t4 = t45; t5 = t15; t6 = t14;

    %Group 2
    t1 = t36; t2 = t26; t3 = t23;

    %Compliances
    c4 = 1/(K1*(w1'*t4)^2);
    c5 = 1/(K4*(w4'*t5)^2);
    c6 = 1/(K5*(w5'*t6)^2);
    c1 = 1/(K2*(w2'*t1)^2);
    c2 = 1/(K3*(w3'*t2)^2);
    c3 = 1/(K6*(w6'*t3)^2);

elseif all(unique(grp2) == [1 4 6])
    %Group1
    t4 = t46; t5 = t16; t6 = t14;

    %Group 2
    t1 = t35; t2 = t25; t3 = t23;

    %Compliances
    c4 = 1/(K1*(w1'*t4)^2);
    c5 = 1/(K4*(w4'*t5)^2);
    c6 = 1/(K6*(w6'*t6)^2);
    c1 = 1/(K2*(w2'*t1)^2);
    c2 = 1/(K3*(w3'*t2)^2);
    c3 = 1/(K5*(w5'*t3)^2);

elseif all(unique(grp2) == [1 5 6])
    %Group1
    t4 = t56; t5 = t16; t6 = t15;

    %Group 2
    t1 = t34; t2 = t24; t3 = t23;

    %Compliances
    c4 = 1/(K1*(w1'*t4)^2);
    c5 = 1/(K5*(w5'*t5)^2);
    c6 = 1/(K6*(w6'*t6)^2);
    c1 = 1/(K2*(w2'*t1)^2);
    c2 = 1/(K3*(w3'*t2)^2);
    c3 = 1/(K4*(w4'*t3)^2);
end


%% convert each twist to a unit twist and find the location of each joint
t1 = t1/t1(3);
t2 = t2/t2(3);
t3 = t3/t3(3);
t4 = t4/t4(3);
t5 = t5/t5(3);
t6 = t6/t6(3);

j1x = -t1(2); j1y = t1(1);
j2x = -t2(2); j2y = t2(1);
j3x = -t3(2); j3y = t3(1);
j4x = -t4(2); j4y = t4(1);
j5x = -t5(2); j5y = t5(1);
j6x = -t6(2); j6y = t6(1);

%% Calculate the stiffness matrix from each individual mechanism and output


%calculate
C1 = c1*(t1*t1') + c2*(t2*t2') + c3*(t3*t3');
C2 = c4*(t4*t4') + c5*(t5*t5') + c6*(t6*t6');

Kmat = inv(C1) + inv(C2);

%output
set(findobj(fig, 'Tag', 'Kout'), 'Data', Kmat)



%% Update the UI and output information to the user. 


p1 = plot([j1x, j2x], [j1y, j2y], 'Color', "#4a708b", 'LineWidth', 3);
p2 = plot([j2x, j3x], [j2y, j3y], 'Color', "#4a708b", 'LineWidth', 3);
p3 = plot([j4x, j5x], [j4y, j5y], 'Color', "#4a708b", 'LineWidth', 3);
p4 = plot([j5x, j6x], [j5y, j6y], 'Color', "#4a708b", 'LineWidth', 3);
uistack(p1, 'top'), uistack(p2, 'top'), uistack(p3, 'top'), uistack(p4, 'top')

drawPoint(j1x, j1y, 'J1', ax);
drawPoint(j2x, j2y, 'J2', ax);
drawPoint(j3x, j3y, 'J3', ax);
drawPoint(j4x, j4y, 'J4', ax);
drawPoint(j5x, j5y, 'J5', ax);
drawPoint(j6x, j6y, 'J6', ax);

%Label each joint on the axes
text(j1x, j1y, '  J1')
text(j2x, j2y, '  J2')
text(j3x, j3y, '  J3')
text(j4x, j4y, '  J4')
text(j5x, j5y, '  J5')
text(j6x, j6y, '  J6')

%format the compliances to be output
C1 = sprintf('%0.4f', c1);
C2 = sprintf('%0.4f', c2);
C3 = sprintf('%0.4f', c3);
C4 = sprintf('%0.4f', c4);
C5 = sprintf('%0.4f', c5);
C6 = sprintf('%0.4f', c6);

%output the compliances
set(findobj(fig, 'Tag', 'comp1'), 'String', C1)
set(findobj(fig, 'Tag', 'comp2'), 'String', C2)
set(findobj(fig, 'Tag', 'comp3'), 'String', C3)
set(findobj(fig, 'Tag', 'comp4'), 'String', C4)
set(findobj(fig, 'Tag', 'comp5'), 'String', C5)
set(findobj(fig, 'Tag', 'comp6'), 'String', C6)

%format the joint positions to be output
J1X = sprintf('%0.4f', j1x);
J1Y = sprintf('%0.4f', j1y);
J2X = sprintf('%0.4f', j2x);
J2Y = sprintf('%0.4f', j2y);
J3X = sprintf('%0.4f', j3x);
J3Y = sprintf('%0.4f', j3y);
J4X = sprintf('%0.4f', j4x);
J4Y = sprintf('%0.4f', j4y);
J5X = sprintf('%0.4f', j5x);
J5Y = sprintf('%0.4f', j5y);
J6X = sprintf('%0.4f', j6x);
J6Y = sprintf('%0.4f', j6y);

%create a list to output the joint positions in their respective tables
[Cx, Cy, ~] = stiffnessCenter(K, ax);
cx = sprintf('%0.3f', Cx);
cy = sprintf('%0.3f', Cy);
Jout1 = {cx, J1X,J2X;
       cy,J1Y,J2Y};

Jout2 = {J3X,J4X,J5X,J6X;
       J3Y,J4Y,J5Y,J6Y};

%output the joint positions

set(findobj(fig, 'Tag', 'jout'), 'Data', Jout1)
set(findobj(fig, 'Tag', 'jout2'), 'Data', Jout2)






end