function [x,y,K] = stiffnessCenter(K, ax)
%inputs are the compliance center from the table on the UI and the axes
%object
format long
%Outputs are the x and y coordinate of the compliance center and the
%Compliance matrix itself (updated to be made symetric if the user changes
%an off diagonal from the UI)

%% Ensures that the stiffness matrix is symmetric and calculates the stiffness center
K(2,1) = K(1,2);
K(3,1) = K(1,3);
K(3,2) = K(2,3);

%Updates the table displayed to the user to make it symmetric
figc = get(ax, 'parent');
table = findobj(figc, 'tag', 'table');
set(table, 'Data', K);

%checks to see if the matrix is not positive definite
try
    chol(K);
catch
    %displays a warning message to the user
    warndlg('The stiffness matrix must be positive definite', '', 'modal')
    uiwait

    %deletes the lines showing the neccesary coditions
    delete(findobj(ax, 'Tag', 'cone1'))
    delete(findobj(ax, 'Tag', 'cone2'))
    delete(findobj(ax, 'Tag', 'ccplot'))
    x = [];
    y = [];
    return
end

%Compliance matrix(inverse of stiffness matrix)
C = inv(K);

%Get neccesary indfomration for calculating the compliance center
omega = [0 -1;
         1 0];

g = [C(1,3);
     C(2,3)];

r = (omega*g)/C(3,3);


%sets the output arguments to be the x and y coordinates of the compliance
%center
x = r(1,1);
y = r(2,1);


delete(findobj(ax, 'Tag', 'cpoint'))
cpoint = scatter(ax, x,y,'*','markerfacecolor','red','sizedata',100,'markeredgecolor','red','tag','cpoint');
set(cpoint, 'ButtonDownFcn', {@MouseClick,ax})
uistack(cpoint, 'bottom')

%% Adds the lines and circle from the sufficient conditions
%Translated stiffness matrix
Cn = PlanarCnorm(C);
Kn = inv(Cn);
D = [Kn(1,1), Kn(1,2); Kn(2,1), Kn(2,2)];
[V, lambda] = eig(D);

%plot the circle from '2022 planar compliance Realization' paper
rk = sqrt(Kn(3,3) / (lambda(1,1)+ lambda(2,2)));   %circle radius

% ceter coordinates = cx, cy
theta = 0:0.01:2*pi;
xp=rk*cos(theta);
yp=rk*sin(theta);


delete(findobj(ax, 'Tag', 'cone1'))
delete(findobj(ax, 'Tag', 'cone2'))
delete(findobj(ax, 'Tag', 'ccplot'))
c = plot(ax,x+xp,y+yp, 'LineWidth', 0.05, 'Color', 'r', 'Tag', 'ccplot');
uistack(c, 'bottom')
set(c,'ButtonDownFcn',{@MouseClick,ax});


%Add code to plot the cone lines from '2022 planar compliance Realization' paper
%finds the angle of the cone lines with respect to the horizontal

%Angle of the red line with respect to the principal axes of the stiffness
%matrix
anglek = asin(sqrt(lambda(1,1)/(lambda(1,1) + lambda(2,2))));

%Angle of the principal axes with respect to the global axes
angle_e1 = atan2(V(2,1), V(1,1));
if angle_e1 < 0
    angle_e1 = angle_e1 + 2*pi;
end

%Gives the angle of the lines with respect to the global axes
angle1 = angle_e1 + anglek;
angle2 = angle_e1 - anglek;
%gets the slope of the first line
m1 = tan(angle1);
%gets the slope of the second line
m2 = tan(angle2);

%y-intercepts
b1 = y - m1*x;
b2 = y - m2*x;

%xvalues to be plotted
X = get(ax, 'xlim');

%Equations
Y1 = @(x) m1*X + b1;
Y2 = @(x) m2*X + b2;

%Y value to be plotted
y1 = Y1(X);
y2 = Y2(X);

%checks if the lines are vertical and adjusts
if isinf(m1)
    X = [x, x];
    y1 = get(ax, 'ylim');
end

if isinf(m2)
    X = [x, x];
    y2 = get(ax, 'ylim');
end

%Plot the lines
pl1 = plot(ax, X,y1,'r-','tag','cone1','linewidth', 0.05);
pl2 = plot(ax, X,y2,'r-','tag','cone2','linewidth', 0.05);
set(pl1,'ButtonDownFcn',{@MouseClick,ax});
set(pl2,'ButtonDownFcn',{@MouseClick,ax});
uistack(pl1, 'bottom')
uistack(pl2, 'bottom')

end

