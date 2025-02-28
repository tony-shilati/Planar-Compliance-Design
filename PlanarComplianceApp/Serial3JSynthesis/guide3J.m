function guide3J

global gdeData3J
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

gdeData3J = guide_message;
gdeData3J.msg1 = ['Welcome to the Three Joint Elastic Serial Mechanism Designer! ' fprintf('%s\n%s') newline   fprintf('%s\n%s') newline ...
    'The window titled "Figure 1" provides a graphical user interface for the design of a mechanism that realizes a desired compliant behavior. ' ...
    'The panel on the window far left allows program inputs to be provided as text. ' ...
    'The panel on the far right provides a description of the design and the compliance matrix calculated based on the design to confirm that the desired behavior is realized. ' fprintf('%s\n%s') newline   fprintf('%s\n%s') newline...
    'To start, in the panel on the left, enter the desired compliance matrix to be realized by the mechanism.  ' ...
    'Since passive realization requires the matrix to be symmetric positive definite, only the cells in the matrix upper triangle allow text input.  (The cells in the lower triangle are automatically populated.)  ' ...
    'An alert is provided if the desired matrix is not positive definite, for which case the matrix entered must be modified prior to beginning the design process.'  fprintf('%s\n%s') newline fprintf('%s\n%s') newline ... ...
    'Once the matrix is entered, the location of the compliance center is identified by a red star in a plot in the center panel.  A red circle centered at this location is also generated.  ' ...
    'This circle roughly indicates the average distance that the joints must have from the compliance center.  The joint locations must surround the compliance center and at least one joint ' ...
    'must be located inside the circle and at least one joint must be located outside the circle. ' fprintf('%s\n%s') newline ...
    'Two sets of parallel lines surrounding the compliance center are also generated.  ' ...
    'For each set of parallel lines, at least one joint must be between the lines and at least one joint must be outside of the lines. ' fprintf('%s\n%s') newline fprintf('%s\n%s') newline ...
    'To begin the mechanism design process, the location of the first joint can be selected using the guidance provided by the circle and the sets of parallel lines.  ' ...
    'This selection can be made either by: 1) entering the Joint 1 X- and Y- Coordinates in text fields in the far left panel (and clicking on Submit), or 2) ' ...
    'clicking and dragging to a desired location in the plot in the center panel.  In the lower left panel, the size of the square plot area (+/- defined value for each axis) can be selected using the "Axes Scaler" text field; ' ... 
    'and the current cursor X- and Y- Positions are displayed in real time.'  fprintf('%s\n%s') newline  fprintf('%s\n%s') newline ...
    'Using the selected first joint location, a construction line restricting the possible locations of Joints 2 and 3 is generated.'];
  

gdeData3J.msg2 = ['The location of Joint 1 can be moved either by: 1) clicking on the current Joint 1 location and dragging it to a new location, or 2) clicking the Reset button '...
    'and then entering new Joint 1 X- and Y- Coordinates in text fields.  If the location of Joint 1 is moved, the line restricting the possible locations of Joint 2 is automatically updated. ' ...
    'The Joint 2 location can be selected by entering the Joint 2 X- and Y- Coordinates and then clicking on Submit. ' ... 
    'The point on the construction line that is closest to the entered location will be used as the Joint 2 location. ' ...
    'Alternately, clicking a point on the line will select the Joint 2 location.  '  ...  
    'The Joint 3 location will be automatically displayed on the plot once Joint 2 is selected. '];

gdeData3J.msg3 = ['The mechanism is now complete. ' ...
    'To change the locations of Joints 2 and 3, Joint 2 can be dragged along the construction line associated with Joint 1. ' ...
    'If Joint 1 is dragged, both Joints 2 and 3 will be deleted.  The design process can be restarted at any time by clicking the Reset button.'];


%% creates a textbox in the window and sets the initial message
msg = uicontrol('Style', 'Text', ...
    'Parent', gde, ...
    'FontUnits', 'normalized', ...
    'Fontsize', 0.0275, ...
    'units', 'normalized', ...
    'String', gdeData3J.msg1, ...
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
    'Callback', {@guideCallback3J, 'Next', msg});

Previous = uicontrol('Style', 'pushbutton', ...
    'Parent', gde, ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'String', '< Previous', ...
    'units', 'normalized', ...
    'Position', [0.38, 0.05, 0.1, 0.05], ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0, 0, 0], ...
    'Callback', {@guideCallback3J, 'Previous', msg});






%% Sets the intial window position and size
resolution = get(0,'screensize');
set(gde,'position',[resolution(3)/13,resolution(4)/9,1200,670]);

set(gde,'visible','on'); hold on

end
