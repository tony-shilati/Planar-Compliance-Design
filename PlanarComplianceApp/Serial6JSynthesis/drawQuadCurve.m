function [ind] = drawQuadCurve(ax, C, num)

%Get neccesary information
[j1x, j1y] = grabData('J1', ax);
[j2x, j2y] = grabData('J2', ax);
[j3x, j3y] = grabData('J3', ax);
[j4x, j4y] = grabData('J4', ax);



t1 = [j1y; -j1x; 1];
t2 = [j2y; -j2x; 1];
t3 = [j3y; -j3x; 1];
t4 = [j4y; -j4x; 1];

w12 = cross(t1, t2); w12 = w12/norm([w12(1), w12(2)]);
w34 = cross(t3, t4); w34 = w34/norm([w34(1), w34(2)]);
w13 = cross(t1, t3); w13 = w13/norm([w13(1), w13(2)]);
w24 = cross(t2, t4); w24 = w24/norm([w24(1), w24(2)]);

H = (w12'*C*w34)*(w13*w24') - (w13'*C*w24)*(w12*w34');

A = H + H';

%f = @(x,y) [y; -x; 1]'*A*[y; -x; 1];
f = @(x,y) (y.^2)*A(1,1) + (x.^2)*A(2,2) - 2*x.*y*A(1,2) + 2*y*A(1,3) - 2*x*A(2,3) + A(3,3);


if num == 1
    %Output Quadratic Curve

    delete(findobj(ax, 'Tag', 'QuadCurve'))
    qc = fimplicit(f, 'Tag', 'QuadCurve', 'LineWidth', 1, 'Color', 'r');
    uistack(qc, 'bottom');

    ind = 0;

elseif num == 2
    [j5x, j5y] = grabData('J5', ax);
    [j6x, j6y] = grabData('J6', ax);
    m56 = (j6y - j5y) / (j6x - j5x); 
    b56 = j5y - m56*j5x;

    X = [j5x, j6x];
    xarray = min(X):0.01:max(X);
    
    func56 = @(x) m56*x + b56;
    yarray = func56(xarray);

    ind = 0;
    l = 1;
    while l < length(xarray)
        F1 = f(xarray(l), yarray(l));
        F2 = f(xarray(l+1), yarray(l+1));
        if sign(F2) ~= sign(F1)
            ind = ind + 1;
        end
        l = l + 1;
    end
            


end



end