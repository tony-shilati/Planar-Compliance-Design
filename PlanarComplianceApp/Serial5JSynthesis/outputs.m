function [] = outputs(ax, C)

%Get acess to the Output boxes
fig = get(ax, 'Parent');

[x, y] = compliantCenter(C, ax);

Jout1 = findobj(fig, 'Tag', 'jout');
Jout2 = findobj(fig, 'Tag', 'jout2');

comp1 = findobj(fig, 'Tag', 'comp1');
comp2 = findobj(fig, 'Tag', 'comp2');
comp3 = findobj(fig, 'Tag', 'comp3');
comp4 = findobj(fig, 'Tag', 'comp4');
comp5 = findobj(fig, 'Tag', 'comp5');

Cout = findobj(fig, 'Tag', 'Cout');

%Get the necesary information for the calculations
[x1, y1] = grabData('J1', ax);
[x2, y2] = grabData('J2', ax);
[x3, y3] = grabData('J3', ax);
[x4, y4] = grabData('J4', ax);
[x5, y5] = grabData('J5', ax);

t1 = [y1; -x1; 1];
t2 = [y2; -x2; 1];
t3 = [y3; -x3; 1];
t4 = [y4; -x4; 1];
t5 = [y5; -x5; 1];

w12 = cross(t1, t2);
w14 = cross(t1, t4);
w23 = cross(t2, t3);
w35 = cross(t3, t5);
w45 = cross(t4, t5);

%Calculate invididual joint complinaces and the compliance matrix

c1 = (w23'*C*w45) / ((w23'*t1) * (w45'*t1));
c2 = (w14'*C*w35) / ((w14'*t2) * (w35'*t2));
c3 = (w12'*C*w45) / ((w12'*t3) * (w45'*t3));
c4 = (w12'*C*w35) / ((w12'*t4) * (w35'*t4));
c5 = (w14'*C*w23) / ((w14'*t5) * (w23'*t5));

Cmat = c1*t1*t1' + c2*t2*t2' + c3*t3*t3' + c4*t4*t4' + c5*t5*t5';

%Format the results 
C1 = sprintf('%0.4f', c1);
C2 = sprintf('%0.4f', c2);
C3 = sprintf('%0.4f', c3);
C4 = sprintf('%0.4f', c4);
C5 = sprintf('%0.4f', c5);

X = sprintf('%0.3f', x);
Y = sprintf('%0.3f', y);
X1 = sprintf('%0.3f', x1);
Y1 = sprintf('%0.3f', y1);
X2 = sprintf('%0.3f', x2);
Y2 = sprintf('%0.3f', y2);
X3 = sprintf('%0.3f', x3);
Y3 = sprintf('%0.3f', y3);
X4 = sprintf('%0.3f', x4);
Y4 = sprintf('%0.3f', y4);
X5 = sprintf('%0.3f', x5);
Y5 = sprintf('%0.3f', y5);

jout1 = {X, X1, X2; Y, Y1, Y2};
jout2 = {X3, X4, X5; Y3, Y4, Y5};


%Output the results to the user
set(Cout, 'Data', Cmat)

set(Jout1, 'Data', jout1)
set(Jout2, 'Data', jout2)

set(comp1, 'String', C1)
set(comp2, 'String', C2)
set(comp3, 'String', C3)
set(comp4, 'String', C4)
set(comp5, 'String', C5)




end