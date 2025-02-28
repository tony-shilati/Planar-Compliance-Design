function [] = Outputs(ax, C)

fig  = get(ax, 'Parent');
[x, y, C] = compliantCenter(C, ax);

%Get neccesary information to calculate ouputs 
[j1x, j1y] = grabData('J1', ax);
[j2x, j2y] = grabData('J2', ax);
[j3x, j3y] = grabData('J3', ax);
[j4x, j4y] = grabData('J4', ax);
[j5x, j5y] = grabData('J5', ax);
[j6x, j6y] = grabData('J6', ax);

t1 = [j1y; -j1x; 1]; t1x = t1*t1'; t1_tilde = [t1x(1,1), t1x(1,2), t1x(1,3), t1x(2,2), t1x(2,3), t1x(3,3)]';
t2 = [j2y; -j2x; 1]; t2x = t2*t2'; t2_tilde = [t2x(1,1), t2x(1,2), t2x(1,3), t2x(2,2), t2x(2,3), t2x(3,3)]';
t3 = [j3y; -j3x; 1]; t3x = t3*t3'; t3_tilde = [t3x(1,1), t3x(1,2), t3x(1,3), t3x(2,2), t3x(2,3), t3x(3,3)]';
t4 = [j4y; -j4x; 1]; t4x = t4*t4'; t4_tilde = [t4x(1,1), t4x(1,2), t4x(1,3), t4x(2,2), t4x(2,3), t4x(3,3)]';
t5 = [j5y; -j5x; 1]; t5x = t5*t5'; t5_tilde = [t5x(1,1), t5x(1,2), t5x(1,3), t5x(2,2), t5x(2,3), t5x(3,3)]';
t6 = [j6y; -j6x; 1]; t6x = t6*t6'; t6_tilde = [t6x(1,1), t6x(1,2), t6x(1,3), t6x(2,2), t6x(2,3), t6x(3,3)]';
T_tilde = [t1_tilde, t2_tilde, t3_tilde, t4_tilde, t5_tilde, t6_tilde]; 
C_tilde = [C(1,1), C(1,2), C(1,3), C(2,2), C(2,3), C(3,3)]';

%Calculate the outputs

c = T_tilde\C_tilde;

C_mat = c(1)*t1*t1' + c(2)*t2*t2' + c(3)*t3*t3' + c(4)*t4*t4' + c(5)*t5*t5' + c(6)*t6*t6';

%Format the Outputs
j1X = sprintf('%0.3f', j1x); j1Y = sprintf('%0.3f', j1y);
j2X = sprintf('%0.3f', j2x); j2Y = sprintf('%0.3f', j2y);
j3X = sprintf('%0.3f', j3x); j3Y = sprintf('%0.3f', j3y);
j4X = sprintf('%0.3f', j4x); j4Y = sprintf('%0.3f', j4y);
j5X = sprintf('%0.3f', j5x); j5Y = sprintf('%0.3f', j5y);
j6X = sprintf('%0.3f', j6x); j6Y = sprintf('%0.3f', j6y);

C1 = sprintf('%0.4f', c(1));
C2 = sprintf('%0.4f', c(2));
C3 = sprintf('%0.4f', c(3));
C4 = sprintf('%0.4f', c(4));
C5 = sprintf('%0.4f', c(5));
C6 = sprintf('%0.4f', c(6));

%Output the outputs

jtab1 = findobj(fig, 'Tag', 'jout');
jtab2 = findobj(fig, 'Tag', 'jout2');

cx = sprintf('%0.3f', x); cy = sprintf('%0.3f', y);
jout1 = {cx, j1X, j2X; cy, j1Y, j2Y};
jout2 = {j3X, j4X, j5X, j6X; j3Y, j4Y, j5Y, j6Y};

set(jtab1, 'Data', jout1)
set(jtab2, 'Data', jout2)

set(findobj(fig, 'Tag', 'comp1'), 'String', C1)
set(findobj(fig, 'Tag', 'comp2'), 'String', C2)
set(findobj(fig, 'Tag', 'comp3'), 'String', C3)
set(findobj(fig, 'Tag', 'comp4'), 'String', C4)
set(findobj(fig, 'Tag', 'comp5'), 'String', C5)
set(findobj(fig, 'Tag', 'comp6'), 'String', C6)

set(findobj(fig, 'Tag', 'Cout'), 'Data', C_mat)

end