function [] = connectJoints(ax)


%get the neccesary infomation to conncet the joints
[j1x, j1y] = grabData('J1', ax);
[j2x, j2y] = grabData('J2', ax);
[j3x, j3y] = grabData('J3', ax);
[j4x, j4y] = grabData('J4', ax);
[j5x, j5y] = grabData('J5', ax);

%connect and label the joints
drawLine(ax, 'C1', [j1x, j2x], [j1y, j2y])
drawLine(ax, 'C2', [j2x, j3x], [j2y, j3y])
drawLine(ax, 'C3', [j3x, j4x], [j3y, j4y])
drawLine(ax, 'C4', [j4x, j5x], [j4y, j5y])

text(j1x, j1y, '   J1', 'FontSize', 10, 'Tag', 'txt1')
text(j2x, j2y, '   J2', 'FontSize', 10, 'Tag', 'txt2')
text(j3x, j3y, '   J3', 'FontSize', 10, 'Tag', 'txt3')
text(j4x, j4y, '   J4', 'FontSize', 10, 'Tag', 'txt4')
text(j5x, j5y, '   J5', 'FontSize', 10, 'Tag', 'txt5')


end