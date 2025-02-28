function [] = connectJoints(ax)

%Get the joint locations
[j1x, j1y] = grabData('J1', ax);
[j2x, j2y] = grabData('J2', ax);
[j3x, j3y] = grabData('J3', ax);
[j4x, j4y] = grabData('J4', ax);
[j5x, j5y] = grabData('J5', ax);
[j6x, j6y] = grabData('J6', ax);

%Connect the joints 

text(j1x, j1y, '  J1', 'FontSize', 10, 'Tag', 'text1')
text(j2x, j2y, '  J2', 'FontSize', 10, 'Tag', 'text2')
text(j3x, j3y, '  J3', 'FontSize', 10, 'Tag', 'text3')
text(j4x, j4y, '  J4', 'FontSize', 10, 'Tag', 'text4')
text(j5x, j5y, '  J5', 'FontSize', 10, 'Tag', 'text5')
text(j6x, j6y, '  J6', 'FontSize', 10, 'Tag', 'text6')


drawLine([j1x, j2x], [j1y, j2y], 'C1', ax)
drawLine([j2x, j3x], [j2y, j3y], 'C2', ax)
drawLine([j3x, j4x], [j3y, j4y], 'C3', ax)
drawLine([j4x, j5x], [j4y, j5y], 'C4', ax)
drawLine([j5x, j6x], [j5y, j6y], 'C5', ax)

drawPoint(ax, 'J1', j1x, j1y)
drawPoint(ax, 'J2', j2x, j2y)
drawPoint(ax, 'J3', j3x, j3y)
drawPoint(ax, 'J4', j4x, j4y)
drawPoint(ax, 'J5', j5x, j5y)
drawPoint(ax, 'J6', j6x, j6y)

%Add a label for each joint

