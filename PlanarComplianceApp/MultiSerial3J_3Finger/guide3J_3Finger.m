function guide3J_3Finger

global gdeData3J_3Finger
delete(findobj(0,'Tag', 'fig2'))
%% creates the prompt window that instructs the user 
gde = figure(2);
set(gde,'renderer','OpenGL','visible','off');
set(gde, 'Units', 'pixels')
set(gde,'menubar','none')
set(gde, 'Tag', 'fig2')

pan on;
pan off;


%% Defines an object that stores guide message data

gdeData3J_3Finger = guide_message;

gdeData3J_3Finger.msg1 = ['    Welcome to the Three, Three Joint Finger, Multiserial Mechanism Designer. ' ...
    'The panel to the left of the plot allows you to control the program. ' ...
    'The panel to the right of the plot shows you the specifications of your mechanism. ' ...
    'This includes the line of action of each spring, the neccesary stiffness of each spring, and the stiffness matrix calculated ' ...
    'using the spring stiffnesses. The calculated stiffness matrix is for confirmation that the spring stiffnesses will realize the stiffness matrix. ' ...
    'To enter the stiffness matrix that you would like to realize, select the matrix cells on the diagonal and above the diagonal and enter your desired value. ' ...
    'This matrix must be symmetric positive definite because the spring stiffnesses must be positive to passively realize the stiffness matrix. ' ...
    'The program will automatically update off-diagonal values to keep the matrix symmetric. ' fprintf('%s\n%s') newline ...
    '   In this synthesis procedure you will design a six spring parrallel mechanism, and then use duality to convert it to ' ...
    'a two, three joint arm, multiserial mechanism. ' fprintf('%s\n%s') newline ...
    '   The red circle surrounding the stiffness center is caculated using the eigenvalues of the stiffness matrix. ' ...
    'At least one wrench line of action must  intersect the circle and at least one wrench line of action must not intersect the circle for the stiffness ' ...
    'to be passively realized. ' fprintf('%s\n%s') newline ...
    '   The red lines passing through the stiffness center are also caluclated using the eigenvalues of the stiffness matrix and are oriented relative to its eigenvectors. ' ...
    'Each wrench has a line perpendicular to it that also passes through the stiffness center. The spring wrenches must be positioned such a way that there is at least one of these ' ...
    'lines in each of the two regions created by the red lines on the plot. This condition must be satisfied for the stiffness to be passively realized.' fprintf('%s\n%s') newline ...
    '   To begin, either select two points on the axes or enter the coordinates of two points and press submit. This will define the first two twist centers. ' ...
    'The lines of action of the first two springs will intersect at the first twist center, and the lines of action of the third and fourth springs will intersect at the second twist center.'];

gdeData3J_3Finger.msg2 = 'Select or enter the coordinates of another point to define the location of the second twist center. The line of action of the third and fourth springs will intersect at this location.';

gdeData3J_3Finger.msg3 = 'Select or enter the coordinates of another point to define the line of action of the first spring. This line will pass through the selected point and the first twist center.';

gdeData3J_3Finger.msg4 = 'Select or enter the coordinates of another point to define the line of action of the second spring. This line will pass through the selected point and the first twist center.';

gdeData3J_3Finger.msg5 = 'Select or enter the coordinates of another point to define the line of action of the third spring. This line will pass through the selected point and the second twist center.';

gdeData3J_3Finger.msg6 = 'Select or enter the coordinates of another point to define the line of action of the fourth spring. This line will pass through the selected point and the second twist center.';

gdeData3J_3Finger.msg7 = ['Select or enter another point to define the third twist center. The lines of action of the fifth and sixth spring will intersect at this location. One of the lines of action of the fifth and sixth springs passing through the third twist center ' ...
            'must intersect the quadratic curve that touches the lines of action of the first four springs. ' ...
            'The other wrench that passes through the third twist center must not intersect the same quadratic curve to garuntee that the signs of the stifnesses of spring five and six are the same. ' ...
            'This condition is true for any two springs in this mechanism'];

gdeData3J_3Finger.msg8 = ['Select or enter the coordinates of another point to define the line of action of the fifth spring. ' ... 
    'This line will pass through the third twist center and the selected point.'];

gdeData3J_3Finger.msg9 = ['Select or enter the coordinates of another point to define the line of action of the sixth spring. ' ... 
    'This line will pass through the third twist center and the selected point. ' ...
    'Now that all the wrenches have been placed you must move the wrenches around, by dragging the nodes you placed to define the wrenches, untill all spring stiffnesses are positive. ' ...
    'To make all of the stiffnesses positive, all wrenches must satisfy the the condition given two slides ago. ' ...
    'If you would like to see the quadratic curve associated with any two wrenches, enter the numbers of the wrenches in the boxes above the plot and press submit. ' ...
    'If you enter the number of one wrench and press submit, the quadratic curve that touches the other five wrenches will be displayed. ' ...
    'If you would like to change the sign of any wrench, you must change its intersection status with the quadratic curve defined by the other five wrenches. ' ...
    'If you move any of the spring wrenches that the quadratic curve is defined by, you will have to press submit again to see the new quadratic curve.' ...
    'Once all of the spring stiffnesses are positive, press convert mechanism to generate the multiserial mechanism'];

gdeData3J_3Finger.msg10 = ['Before converting the mechanism, you must split the spring wrenches into groups of three. ' ...
    'Each group of three will be used to makeup one of the arms. Enter the groups in their respective boxes and press submit. '];

gdeData3J_3Finger.msg11 = ['The two, three joint arm, multiserial mechanism is now complete. ' ...
    'The location of each joint and the compliance of each joint has been displayed in the output panel.'];

%% creates a textbox in the window and sets the initial message
msg = uicontrol('Style', 'Text', ...
    'Parent', gde, ...
    'FontUnits', 'normalized', ...
    'Fontsize', 0.035, ...
    'units', 'normalized', ...
    'String', gdeData3J_3Finger.msg1, ...
    'Position', [0.01, 0.01, 0.98, 0.98], ...
    'BackgroundColor', [1, 1, 1], ...
    'Tag', 'msg', ...
    'HorizontalAlignment', 'left');


%% Creates buttons to go backward and forward

next = uicontrol('Style', 'pushbutton', ...
    'Parent', gde, ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'String', 'Next >', ...
    'units', 'normalized', ...
    'Position', [0.52, 0.05, 0.1, 0.05], ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0, 0, 0], ...
    'Callback', {@guideCallback3J_3Finger, 'Next', msg});

Previous = uicontrol('Style', 'pushbutton', ...
    'Parent', gde, ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'String', '< Previous', ...
    'units', 'normalized', ...
    'Position', [0.38, 0.05, 0.1, 0.05], ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0, 0, 0], ...
    'Callback', {@guideCallback3J_3Finger, 'Previous', msg});






%% Sets the intial window position and size
resolution = get(0,'screensize');
set(gde,'position',[resolution(3)/13,resolution(4)/9,1200,670]);

set(gde,'visible','on'); hold on

end