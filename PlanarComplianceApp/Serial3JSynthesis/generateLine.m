function [x, y, func ] = generateLine( x0, y0, C )

global m b

if nargin == 0
   x0 = 1;
   y0 = 0;
   K = [3 -2 1; -2 6 5; 1 5 9];
   C = inv(K);
end

% Stiffness
K = inv(C);


%Creates the position vector of the twist
r1 = [x0; y0; 0];

%Defines the unit vector in the k direction
k = [0; 0; 1];

%Calculates the first two elements of the Twist vector
v = cross(r1,k);

%Defines the twis vector
t = [v(1); v(2); 1];

%Calculates the wrench vector
w = K*t;

%Calculates the slope of the wrench line of action
m = w(2)/w(1);

%Creates a vector with the first two elements of the wrench 
w12 = [w(1); w(2)];

%Creates a unit vector in the direction of the wrench 
n = [w(1); w(2); 0]/norm(w12);

%Calculates the perpendicular distance between the wrench line of action
%and the origin
d = w(3)/norm(w12);

%Calculates the perpndicular distance vector from the origin to the line
%of action of the spring wrench 
r = d*cross(n, k);

%Calculates the y-intercept of the spring wrench line of action
b = r(2) - m*r(1);

func = @(x) m*x + b;

x = [0, 1];
y = func(x);

%According to paper I'm expecting y = -1/3 * x - 4/3

end

