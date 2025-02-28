function [x,y,C] = compliantCenter(C, ax)
format long
C(2,1) = C(1,2);
C(3,1) = C(1,3);
C(3,2) = C(2,3);

figc = get(ax, 'parent');
table = findobj(figc, 'tag', 'table');
set(table, 'Data', C);

%checks to see if the matrix is not positive definite
try
    chol(C);

catch
    %displays a warning message to the user
    warndlg('The compliance matrix must be positive definite', '', 'modal')
    uiwait

    delete(findobj(ax, 'Tag', 'px'))
    delete(findobj(ax, 'Tag', 'nx'))
    delete(findobj(ax, 'Tag', 'py'))
    delete(findobj(ax, 'Tag', 'ny'))
    delete(findobj(ax, 'Tag', 'ccplot'))
    return
end


%Gets the Stiffness Matrix

%Calculates the x and y position of the compliance center
omega = [0 -1;
         1 0];

g = [C(1,3);
     C(2,3)];

r = (omega*g)/C(3,3);

x = r(1,1);
y = r(2,1);

%Plots the compliance center
delete(findobj(ax, 'Tag', 'cpoint'))
sc = scatter(x,y,'*','markerfacecolor','red','sizedata',100,'markeredgecolor','red','tag','cpoint');
set(sc, 'ButtonDownFcn', {@MouseClick, ax})
uistack(sc, 'bottom')

%% plot the sufficient condtions





%Calculates the eigen values and eigen vectors of the 2x2 matrix in the top
%left of Cc
[EVs, ~] = eig(C(1:2,1:2));

% Eigen Vectors and a vector in the +k direction
v1 = EVs(1:2,1); v1 = v1/norm(v1);
v2 = EVs(1:2,2); v2 = v2/norm(v2);
k = [0, 0, 1]';

if cross([v1;1], [v2;1])'*k == 1
    vx = v1;
    vy = v2;
else
    vx = v2;
    vy = v1;
end

% angle of compliance relative to reference axes
theta = acosd([1,0]*vx);

To = Tmat(-x, -y, -theta);

% Diagonalized C
Cc = To'*C*To;

% Calculate the 2x2 rotation matrix based on the rotation angle provided in
% the first section
R_2x2 = [cosd(theta), -sind(theta);
         sind(theta), cosd(theta)];

% Rotate a unit x- and y- vector to be aligned with the stiffness principal
% axes
x_vector = R_2x2*[1;0];
y_vector = R_2x2*[0;1];

% Calculate the perpendicular distance beteen the stiffness cneter and the 
% condition lines from "Compliance Realization With Planar Serial 
% Mechanisms Having Fixed Link Lengths"
x_distance = sqrt(Cc(1,1)/Cc(3,3));
y_distance = sqrt(Cc(2,2)/Cc(3,3));

% Turn the unit vector and distances into unit wrenches along the condition
% lines as if the stiffness center was at the origin
wx_pos = [x_vector; -x_distance];
wx_neg = [x_vector; x_distance];

wy_pos = [y_vector; -y_distance];
wy_neg = [y_vector; y_distance];

% Generate a transformation matrix from the origin to the stiffness center
T = Tmat(x, y, 0);

% Transform the wrenchs from the origin to the stiffness center
wx_pos = T'*wx_pos;
wx_neg = T'*wx_neg;

wy_pos = T'*wy_pos;
wy_neg = T'*wy_neg;


%deletes the horizontal lines if they already exist
delete(findall(ax, 'Tag', 'cl'))

%plots the lines
Yline1 = wrenchPlot(wx_pos, 'r', 0.05, 'cl', ax);
Yline2 = wrenchPlot(wx_neg, 'r', 0.05, 'cl', ax);
Xline1 = wrenchPlot(wy_pos, 'r', 0.05, 'cl', ax);
Xline2 = wrenchPlot(wy_neg, 'r', 0.05, 'cl', ax);

set(Yline1,'ButtonDownFcn',{@MouseClick,ax});
set(Yline2,'ButtonDownFcn',{@MouseClick,ax});
set(Xline1,'ButtonDownFcn',{@MouseClick,ax});
set(Xline2,'ButtonDownFcn',{@MouseClick,ax});

uistack(Yline1, 'bottom')
uistack(Yline2, 'bottom')
uistack(Xline1, 'bottom')
uistack(Xline2, 'bottom')


%% Plots the circle around the comliance center
ccplot = findobj(ax, 'Tag', 'ccplot');
delete(ccplot)

%plots the circle
rk = sqrt((Cc(1,1) + Cc(2,2)) / Cc(3,3));   %circle radius
% ceter coordinates = cx, cy
theta_plot = 0:0.01:2*pi;
xp=rk*cos(theta_plot);
yp=rk*sin(theta_plot);
circ = plot(ax, x+xp,y+yp, 'LineWidth', 0.05, 'Color', 'r', 'Tag', 'ccplot');
uistack(circ, 'bottom')
set(circ,'ButtonDownFcn',{@MouseClick,ax});


end

