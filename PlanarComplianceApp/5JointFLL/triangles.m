function [] = triangles(ax)

%Get the neccesary data to draw triangles 
[j1x, j1y] = grabData('J1', ax);
[j2x, j2y] = grabData('J2', ax);
[j3x, j3y] = grabData('J3', ax);
[j4x, j4y] = grabData('J4', ax);
[j5x, j5y] = grabData('J5', ax);

%Draw the triangles
    %trianle 12
plot([j3x, j5x], [j3y, j5y], '--',  'Color', [0 0.4470 0.7410], 'Tag', 't12')
plot([j3x, j4x], [j3y, j4y], '--',  'Color', [0 0.4470 0.7410], 'Tag', 't12')
plot([j4x, j5x], [j4y, j5y], '--',  'Color', [0 0.4470 0.7410], 'Tag', 't12')

    %triangle 34
    %trianle 12
plot([j1x, j5x], [j1y, j5y], '--',  'Color', [0.9290 0.6940 0.1250], 'Tag', 't34')
plot([j1x, j2x], [j1y, j2y], '--',  'Color', [0.9290 0.6940 0.1250], 'Tag', 't34')
plot([j2x, j5x], [j2y, j5y], '--',  'Color', [0.9290 0.6940 0.1250], 'Tag', 't34')    

end