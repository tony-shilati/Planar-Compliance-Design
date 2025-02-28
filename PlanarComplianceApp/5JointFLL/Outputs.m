function [] = Outputs(ax, C)
fig = get(ax, 'Parent');
%%Get the neccesary information to calculate the outputs
[j1x, j1y] = grabData('J1', ax);
[j2x, j2y] = grabData('J2', ax);
[j3x, j3y] = grabData('J3', ax);
[j4x, j4y] = grabData('J4', ax);
[j5x, j5y] = grabData('J5', ax);

%Get the unit twist at each joint
t1 = [j1y;-j1x;1];
t2 = [j2y;-j2x;1];
t3 = [j3y;-j3x;1];
t4 = [j4y;-j4x;1];
t5 = [j5y;-j5x;1];

%Calculate the necessary wrenches
w23 = cross(t2, t3);
w45 = cross(t4, t5);
w13 = cross(t1, t3);
w12 = cross(t1, t2);
w35 = cross(t3, t5);
w34 = cross(t3, t4);

%%Calculate the outputs
    %Joint Compliances
c1 = (w23'*C*w45) / ((w23'*t1) * (w45'*t1));
c2 = (w13'*C*w45) / ((w13'*t2) * (w45'*t2));
c3 = (w12'*C*w45) / ((w12'*t3) * (w45'*t3));
c4 = (w12'*C*w35) / ((w12'*t4) * (w35'*t4));
c5 = (w12'*C*w34) / ((w12'*t5) * (w34'*t5));

    %Compliance Matrix

C_mat = c1*(t1*t1') + c2*(t2*t2') + c3*(t3*t3') + c4*(t4*t4') + c5*(t5*t5');

%%Format the outputs
J1x = sprintf('%0.3f', j1x); J1y = sprintf('%0.3f', j1y);
J2x = sprintf('%0.3f', j2x); J2y = sprintf('%0.3f', j2y);
J3x = sprintf('%0.3f', j3x); J3y = sprintf('%0.3f', j3y);
J4x = sprintf('%0.3f', j4x); J4y = sprintf('%0.3f', j4y);
J5x = sprintf('%0.3f', j5x); J5y = sprintf('%0.3f', j5y);

C1 = sprintf('%0.4f', c1);
C2 = sprintf('%0.4f', c2);
C3 = sprintf('%0.4f', c3);
C4 = sprintf('%0.4f', c4);
C5 = sprintf('%0.4f', c5);


%%Display the outputs on the gui

[cx, cy] = compliantCenter(C, ax);
Cx = sprintf('%0.3f', cx); Cy = sprintf('%0.3f', cy);

jout1 = {Cx, J1x, J2x; Cy, J1y, J2y};

jout2 = {J3x, J4x, J5x; J3y, J4y, J5y};

set(findobj(fig, 'Tag', 'jout'), 'Data', jout1)
set(findobj(fig, 'Tag', 'jout2'), 'Data', jout2)

set(findobj(fig, 'Tag', 'comp1'), 'String', C1)
set(findobj(fig, 'Tag', 'comp2'), 'String', C2)
set(findobj(fig, 'Tag', 'comp3'), 'String', C3)
set(findobj(fig, 'Tag', 'comp4'), 'String', C4)
set(findobj(fig, 'Tag', 'comp5'), 'String', C5)

set(findobj(fig, 'Tag', 'Cout'), 'Data', C_mat)


end