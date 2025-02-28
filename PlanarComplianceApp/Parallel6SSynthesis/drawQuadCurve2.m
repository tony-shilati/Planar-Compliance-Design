function drawQuadCurve2(ax, t1, t2, t3, t4)

global K

%Calculate the B matrix
B = (t1'*K*t2)*(t3*t4') - (t3'*K*t4)*(t1*t2');

%Calculate the H matrix
H = B + B';
H = inv(H);

h = @(x,y) H(1,1)*y.^2 + H(2,2)*x.^2 - 2*H(1,2)*x.*y + 2*H(1,3)*y - 2*H(2,3)*x + H(3,3);

delete(findall(ax, 'Tag', 'QuadCurve'))

QC = fimplicit(ax, h, 'LineWidth', 1, 'Color', 'r', 'Tag', 'QuadCurve');
uistack(QC, 'bottom')




end