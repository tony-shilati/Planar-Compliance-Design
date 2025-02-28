function guide4J

global gdeData4J
delete(findobj(0,'Tag', 'fig2'))
%% creates the prompt window that instructs the user 
gde = figure(2);
set(gde,'renderer','OpenGL','visible','off');
set(gde, 'Units', 'pixels')
set(gde,'menubar','none')
set(gde,'Tag', 'fig2')

pan on;
pan off;

%% Defines an object that stores guide message data

gdeData4J = guide_message;

gdeData4J.msg1 = ['Welcome to the Four Joint Elastic Serial Mechanism Designer! ' fprintf('%s\n%s') newline   fprintf('%s\n%s') newline ...
    'The window titled "Figure 1" provides a graphical user interface for the design of a mechanism that realizes a desired compliant behavior. ' ...
    'The panel on the window far left allows program inputs to be provided as text. ' ...
    'The panel on the far right provides a description of the design and the compliance matrix, calculated based on the design, to confirm that the desired behavior is realized. ' fprintf('%s\n%s') newline   fprintf('%s\n%s') newline...
    'To start, in the panel on the left, enter the desired compliance matrix to be realized by the mechanism.  ' ...
    'Since passive realization requires the matrix to be symmetric positive definite, only the cells in the matrix upper triangle allow text input.  (The cells in the lower triangle are automatically populated.)  ' ...
    'An alert is provided if the desired matrix is not positive definite, for which case the matrix entered must be modified prior to beginning the design process.'  fprintf('%s\n%s') newline fprintf('%s\n%s') newline ... ...
    'Once the matrix is entered, the location of the compliance center is identified by a red star in a plot in the center panel.  A red circle centered at this location is also generated.  ' ...
    'This circle roughly indicates the average distance that the joints must have from the compliance center.  The joint locations must surround the compliance center. Also, at least one joint ' ...
    'must be located inside the circle and at least one joint must be located outside the circle. ' fprintf('%s\n%s') newline ...
    'Two sets of parallel lines surrounding the compliance center are also generated.  ' ...
    'For each set of parallel lines, at least one joint must be between the lines and at least one joint must be outside of the lines. ' fprintf('%s\n%s') newline fprintf('%s\n%s') newline ...
    'This synthesis procedure consists of defining four construction lines. The joint positions found using this procedure are located at the intersections of the construction lines. '...
    'To begin the mechanism design process, the first construction line (designated "L1" in the legend) must be selected by placing two nodes that it will pass through.  ' ...
   'This selection can be made either by: 1) entering the X- and Y- Coordinates of the nodes in text fields in the far left panel (and clicking on Submit), or 2) ' ...
    'clicking a desired location on the plot in the center panel to define each node.  In the lower left panel, the size of the square plot area (+/- defined value for each axis) can be selected using the "Axes Scaler" text field; ' ... 
    'and the current cursor X- and Y- Positions are displayed in real time.'  fprintf('%s\n%s') newline  fprintf('%s\n%s') newline ...
    'Using L1, a construction point (designated "P1") constraining the possible location of the second construction line (designated "L2" in the legend) is generated'];

gdeData4J.msg2 = ['The location of the first node can be moved by either: 1) clicking on and dragging it, 2) clicking the Reset button '...
    'and entering new node 1 X- and Y- Coordinates in text fields (and clicking on Submit), or 3) clicking the Reset button and clicking ' ...
    'a new location on the plot in the center panel. The second node location can be selected by: 1) entering the node 2 X- and Y- ' ...
    'Coordinates and then clicking on Submit or 2) clicking a desired location on the plot in the center panel. ' ... 
    'Once node 2 is placed, L1 will automatically be plotted passing through node 1 and node 2. ' ...
    'P1, constraining the placement of L2, will also be generated.'];

gdeData4J.msg3 = ['The location and orientation of L1 can be changed by: 1) clicking and dragging the nodes associated with it to a new ' ...
    'location, 2) clicking and dragging the line to a new location, or 3) clicking the reset button and entering new X- and Y- coordinateds for node 1 and 2 in the text fields. ' ...
    'If L1 is moved, P1 will be automatically updated. The second construction line, L2, must intersect P1. ' ...
    'To select L2, either: 1) enter the X- and Y- coordinates of a third node, or 2) click a location on the plot in the center panel to select node 3. ' ...
    'Once node 3 is selected, L2 (passing through node 3 and P1) will be generated. A construction point associated with L2 ' ...
    '(designated "P2") will also be generated. '];

gdeData4J.msg4 = ['The orientation of L2 can be changed by clicking on and dragging node 3 to a new location. P2 will be automatically updated if the orientation of L2 is changed. ' ...
    'If L1 or the nodes associated with L1 are clicked on and moved, L2 and P2 will be deleted and P1 will be automatically updated. ' ...
    'The dashed line segment connecting P1 and P2 constrains the placement of the third construction line (designated "L3" in the legend). ' ...
    'L3 cannot intersect the dashed segment. If L3 is placed such that it intersects the dashed segment, an error message will show and L3 will be deleted. ' ...
    'When L3 is placed, a construction point associated with L3 (designated "P3"), which constrains the location of construction line 4 (designated "L4" in the legend), will be generated. ' ...
    'P3 and the compliance center (marked with the red star) must be seperated by the dashed line segment. ' ...
    'If the dashed segment does not seperate P3 and the compliance center, an error message will show and L3 and P3 will be deleted. ' ...
    'This condition is more likely to be satisfied if L3 and the dashed segment are on opposite sides of the complaince center. ' ...
    'L3 can be placed, similar to L1, using two nodes (node 4 and 5) that it will pass through. ' ...
    'These nodes can be selected by: 1) entering the X- and Y- Coordinates of the nodes in text fields in the far left panel (and clicking on Submit), or 2) ' ...
    'clicking a desired location on the plot in the center panel to define each node.'];

gdeData4J.msg5 = ['The location of node 4 can be changed by clicking on and dragging it to a new location. If L1 or the nodes associated with it are moved, L2, P2, and node 4 will be deleted. ' ...
    'If L2 is moved, node 4 will be deleted. the fifth node location can be selected by: 1) entering the node 5 X- and Y- ' ...
    'Coordinates and then clicking on Submit or 2) clicking a desired location on the plot in the center panel. Once node 5 is placed, L3 will be plotted passing through node 4 and node 5. ' ...
    'P3 will also be automatically generated. If the conditions associated with the dashed line segment are not satisfied, L3 and P3 will be deleted. If this is the case, they will have to be placed again.'];

gdeData4J.msg6 = ['The location and orientation of L3 can be changed by: 1) clicking and dragging the nodes associated with it to a new ' ...
    'location or 2) clicking and dragging the line to a new location. If L1 or the nodes associated with it are moved, L2, P2, L3, and P3 will be deleted. ' ...
    'If L2 is moved, L3 and P3 will be deleted. Since the placement of L4 is constrained by P3, only one node (node 6) needs ' ...
    'to be selected to define L4. Similar to L3, L4 is not allowed to intersect the dashed line connecting P1 and P2. The sixth node location can be selected by: ' ...
    '1) entering the node 6 X- and Y- Coordinates and then clicking on Submit or 2) clicking a desired location on the plot in the center panel. Once node 6 is placed, ' ...
    'line 4 will be ploted passing through P3 and node 6. If L4 intersects the dashed line segment, it will be deleted and will have to be placed again. The joints, and ' ...
    'links connecting the joints, will be automatically generated.'];

gdeData4J.msg7 = ['The mechanism is now complete! ' ...
    'To change the geometry of the mechanism, node 6 can be clicked on and dragged to a new location. The joints ' ...
    'and links will automatically update as node 6 is dragged. ' ...
    'If L1 or the nodes associated L1 are moved, the joints, the links, L4, L3, P3, L2, and P2 will be deleted. ' ... 
    'If L2 is moved, the joints, the links, L4, L3, and P3, will be deleted. ' ...
    'If L3 or the nodes associated L3 are moved, the joints, the links, and L4 will be deleted. ' ...
    'To restart the mechanism design process, click on Reset.'] ;


%% creates a textbox in the window and sets the initial message
msg = uicontrol('Style', 'Text', ...
    'Parent', gde, ...
    'FontUnits', 'normalized', ...
    'Fontsize', 0.026, ...
    'units', 'normalized', ...
    'String', gdeData4J.msg1, ...
    'Position', [0.01, 0.01, 0.98, 0.98], ...
    'BackgroundColor', [1, 1, 1], ...
    'Tag', 'msg', ...
    'HorizontalAlignment','left');


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
    'Callback', {@guideCallback4J, 'Next', msg});

Previous = uicontrol('Style', 'pushbutton', ...
    'Parent', gde, ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'String', '< Previous', ...
    'units', 'normalized', ...
    'Position', [0.38, 0.05, 0.1, 0.05], ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0, 0, 0], ...
    'Callback', {@guideCallback4J, 'Previous', msg});






%% Sets the intial window position and size
resolution = get(0,'screensize');
set(gde,'position',[resolution(3)/13,resolution(4)/9,1200,670]);

set(gde,'visible','on'); hold on



end