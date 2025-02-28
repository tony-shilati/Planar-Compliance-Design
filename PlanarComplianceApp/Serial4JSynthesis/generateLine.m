function [ func ] = generateLine( x0, y0, C )

if nargin == 0
   x0 = 1;
   y0 = 0;
   K = [3 -2 1; -2 6 5; 1 5 9];
   C = inv(K);
end

% Stiffness
K = inv(C);

% Twist One
t1 = [y0; -x0; 1];
% Wrench One
w1 = K*t1;

mag = norm(w1(1:2));
n = w1(1:2)/mag;
d = w1(3)/mag;
% Slope looks correct
slope = n(2)/n(1);

r = -d*[0 -1; 1 0]*n;

b = r(2) - (slope*r(1));

%b2 = -d/n(1)

func = @(x) slope*x + b;

%According to paper I'm expecting y = -1/3 * x - 4/3

end

