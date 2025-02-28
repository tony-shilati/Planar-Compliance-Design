function [x, y] = calcInt(coef11, coef12, coef21, coef22, b1, b2)
%This function calculates the intersection point of two lines

% [coef11 coef12] [x] _ [b1]
% [coef21 coef22] [y] – [b2]

A = [coef11 coef12; coef21 coef22];

x_matrix = [b1 coef12; b2 coef22];

y_matrix = [coef11 b1; coef21 b2];

x = det(x_matrix)/det(A);

y = det(y_matrix)/det(A);


end
