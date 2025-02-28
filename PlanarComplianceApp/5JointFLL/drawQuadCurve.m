function [] = drawQuadCurve(ax, C, ll)

%get neccesary information
[j1x, j1y] = grabData('J1', ax);
[j2x, j2y] = grabData('J2', ax);
[j3x, j3y] = grabData('J3', ax);
[j4x, j4y] = grabData('J4', ax);

t1 = [j1y; -j1x; 1];
t2 = [j2y; -j2x; 1];
t3 = [j3y; -j3x; 1];
t4 = [j4y; -j4x; 1];

w12 = cross(t1,t2); w34 = cross(t3, t4);
w13 = cross(t1,t3); w24 = cross(t2, t4);

H = (w12'*C*w34)*(w13*w24') - (w13'*C*w24)*(w12*w34');
A = H + H';
%Create the quadratic curve equation

f = @(x,y) A(1,1).*y.^2 + A(2,2).*x.^2 - 2*A(1,2)*x.*y + 2*A(1,3).*y - 2*A(2,3).*x + A(3,3);

%Plot the quadratic curve

fimp = fimplicit(f, 'Color', 'b', 'Tag', 'QuadCurve');
uistack(fimp, 'bottom')


r5 = ll.lengths(4);
T4 = [1, 0, -j4y; 
      0, 1, j4x;
      0, 0, 1];

E4 = [1, 0, 0; 
      0, 1, 0; 
      0, 0, -(r5^2)];

%G4 = C*(T4'*E4*T4)*;

syms x y

t = [y; -x; 1];

eqns = [(t'*A*t == 0);
        (t'*(T4'*E4*T4)*t == 0)];

circlies = [0,0;0,0];
while circlies(1,:) == circlies(2,:)
    for n = 1:2
        S = vpasolve(eqns,[x,y],'Random',true);
      
        circlies(n,1) = S.x(1);
        circlies(n,2) = S.y(1);
          
    end
end

x1 = double(circlies(1,1)); x2 = double(circlies(2,1));
y1 = double(circlies(1,2)); y2 = double(circlies(2,2));


drawPoint(x1, y1, 'T5', ax)
drawPoint(x2, y2, 'T6', ax)


end