function [] = fingerSynth(ax, x, y, kx, ky, Kp33, signal, finger, r_crc1, r_crc2, r_crc3)
format long
global phase
%% inputs
% x and y are the coordinates of the base joint
% kx and ky are the coordinates of the tip of the given finger
fing = num2str(finger);

%% outputs
% m_l is the slope of line l

%% Get neccessary vectors for calculations
omega = [0, -1; 1, 0];

r = [(x-kx); (y-ky)];

if strcmp(signal, 'J1')
    
    %% Converts the point stiffness matrix to a 2x2 matrix
    
    %2x2 point compliance
    Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
   
    %% calculates line l slope
    
    v = omega'*r;
    f = Kp22*v;
    m_l = f(2)/f(1);
    
    
    %% plots lines
    %function of line l
    bl1 = ky - m_l*kx;
    ly1 = @(x) m_l*x + bl1;

    %Values used to plot the line of action of the force
    x2 = kx+1;
    y2 = ly1(x2);

    

    %plots the lines passing through the contact point
    drawLine([kx, x], [ky, y], 'rho', ax)
    drawLine([x2, kx], [y2, ky], 'l', ax)

elseif strcmp(signal, 'J2')
    %% 
    %Gets the colsest point on the circle to the selected point
    [x1, y1] = grabData(['F' fing 'J1'], ax);
    m = (y-y1) / (x-x1);

    syms xi yi

    eqns = [((xi - x1)^2 + (yi - y1)^2 == r_crc1^2);
            (yi - y1 == m*(xi - x1))];

    s = solve(eqns, [xi yi]);
    xI = s.xi;
    yI = s.yi;

    d1 = sqrt((x - xI(1))^2 + (y - yI(1))^2);
    d2 = sqrt((x - xI(2))^2 + (y - yI(2))^2);

    if d1 <= d2
        %plots the second joint location
        drawPoint(xI(1), yI(1), ['F' fing 'J2'], ax)

    elseif d2 < d1
        %plots the second joint location
        drawPoint(xI(2), yI(2), ['F' fing 'J2'], ax)

    end



    %% 
    %Gets the circle intersection points
    [x1, y1] = grabData(['F' fing 'J2'], ax);

    syms xi2 yi2

    eqns2 = [((xi2 - x1)^2 + (yi2 - y1)^2 == r_crc2^2);
            ((xi2 - kx)^2 + (yi2 - ky)^2 == r_crc3^2)];

    s2 = solve(eqns2, [xi2 yi2]);
    xI2 = double(s2.xi2);
    yI2 = double(s2.yi2);

    if any(~isreal([xI2, yI2]))
        return
    else
        drawPoint(xI2(1), yI2(1), ['F' fing 'J31'], ax)
        drawPoint(xI2(2), yI2(2), ['F' fing 'J32'], ax)
    end
   
elseif strcmp(signal, 'J3')
    [p1x, p1y] = grabData(['F' fing 'J31'], ax);
    [p2x, p2y] = grabData(['F' fing 'J32'], ax);

    if isempty(p1x) && ~isempty(p2x)
        delete(findobj(ax, 'Tag', ['F' fing 'J32']))
        drawPoint(p2x, p2y, ['F' fing 'J3'], ax)

        connectJoints(ax, finger)

    elseif ~isempty(p1x) && isempty(p2x)
        delete(findobj(ax, 'Tag', ['F' fing 'J31']))
        drawPoint(p1x, p1y, ['F' fing 'J3'], ax)

        connectJoints(ax, finger)

    elseif ~isempty(p1x) && ~isempty(p2x)
        d1 = sqrt((x - p1x)^2 + (y - p1y)^2);
        d2 = sqrt((x - p2x)^2 + (y - p2y)^2);

        if d1 <= d2
            drawPoint(p1x, p1y, ['F' fing 'J3'], ax)
            delete(findobj(ax, 'Tag', ['F' fing 'J31']))
            delete(findobj(ax, 'Tag', ['F' fing 'J32']))

            connectJoints(ax, finger)

            
    
        elseif d2 < d1
            drawPoint(p2x, p2y, ['F' fing 'J3'], ax)
            delete(findobj(ax, 'Tag', ['F' fing 'J31']))
            delete(findobj(ax, 'Tag', ['F' fing 'J32']))

            connectJoints(ax, finger)
    
        end

    end

    if finger == 1
        color = [0 0.4470 0.7410];
    
    elseif finger == 2
        color = [0.9290 0.6940 0.1250];
    
    elseif finger == 3
        color = [0.8500 0.3250 0.0980];
    
    end
    
    %replots the finger tip in the finger color
    delete(findobj(ax, 'Tag', ['P' fing]))

    scatter(ax,kx,ky,'filled','markerfacecolor', color,'markeredgecolor', color,...
    'tag', ['P' fing],'sizedata',60);



end


end