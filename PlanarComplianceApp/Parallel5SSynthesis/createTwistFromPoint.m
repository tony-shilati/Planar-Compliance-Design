function [ t ] = createTwistFromPoint(x,y)

%Creates Unit Twist from a designated Point

r = [x; y];

v = [0 1; -1 0]*r;

t = [v(1); v(2); 1];

end
