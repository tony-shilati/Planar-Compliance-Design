function [] = QuadCircleInts(ax, ll, A)
%This function finds the intersections on the quad curve f1236 and the
%cicle that defines the locus of possible positions for joint 4 and plots
%the two intersections. 

[j3x, j3y] = grabData('J3', ax);

r4 = ll.lengths(3);
T4 = [1, 0, -j3y; 
      0, 1, j3x;
      0, 0, 1];

E4 = [1, 0, 0; 
      0, 1, 0; 
      0, 0, -(r4^2)];

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

% [solns1, solns2] = solve(eqns, [x, y]);
% solns.x 
% solns.y

x1 = double(circlies(1,1)); x2 = double(circlies(2,1));
y1 = double(circlies(1,2)); y2 = double(circlies(2,2));

% x1 = double(solns1(1)); x2 = double(solns2(1));
% y1 = double(solns1(2)); y2 = double(solns2(2));

drawPoint(x1, y1, 'T5', ax)
drawPoint(x2, y2, 'T6', ax)

end