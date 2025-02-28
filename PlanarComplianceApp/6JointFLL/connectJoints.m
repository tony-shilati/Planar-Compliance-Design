function [] = connectJoints(ax)

%Get the joint locations
[j1x, j1y] = grabData('J1', ax);
[j2x, j2y] = grabData('J2', ax);
[j3x, j3y] = grabData('J3', ax);
[j4x, j4y] = grabData('J4', ax);
[j5x, j5y] = grabData('J5', ax);
[j6x, j6y] = grabData('J6', ax);

%Add a label for each joint
text(j1x, j1y, '  J1', 'FontSize', 10, 'Tag', 'text1')
text(j2x, j2y, '  J2', 'FontSize', 10, 'Tag', 'text2')
text(j3x, j3y, '  J3', 'FontSize', 10, 'Tag', 'text3')
text(j4x, j4y, '  J4', 'FontSize', 10, 'Tag', 'text4')
text(j5x, j5y, '  J5', 'FontSize', 10, 'Tag', 'text5')
text(j6x, j6y, '  J6', 'FontSize', 10, 'Tag', 'text6')

%Connect the joints

drawLine(ax, 'C1', [j1x, j2x], [j1y, j2y])
drawLine(ax, 'C2', [j2x, j3x], [j2y, j3y])
drawLine(ax, 'C3', [j3x, j4x], [j3y, j4y])
drawLine(ax, 'C4', [j4x, j5x], [j4y, j5y])
drawLine(ax, 'C5', [j5x, j6x], [j5y, j6y])

%Plot the points bove the lines so they are stacked above them on the ui
drawPoint(j1x, j1y, 'J1', ax)
drawPoint(j2x, j2y, 'J2', ax)
drawPoint(j3x, j3y, 'J3', ax)
drawPoint(j4x, j4y, 'J4', ax)
drawPoint(j5x, j5y, 'J5', ax)
drawPoint(j6x, j6y, 'J6', ax)



