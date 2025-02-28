function [] = Synthesis3S()

%adds folder with function m files to the search path 
addpath('PlanarComplianceApp/Parallel3SSynthesis/')
addpath('PlanarComplianceApp/General_Functions/')
clearvars -global


%Creates a figure to contain other figures 
fig = figure(1);clf;
set(fig,'Name','3 Spring Parallel Mechanism','NumberTitle','on');
set(fig,'units','pixels');
set(fig,'renderer','OpenGL','visible','off');
set(fig,'SizeChangedFcn', {@cTableResize, fig});
pan on;
pan off;


%sets global variables 
global K phase drag1 drag2 drag3
%defines the siffness/compliance matrix
K = [3 -2 1; -2 6 5; 1 5 9];
C = inv(K);


%sets the phase to the initial state
%phase 0 = nothing placed

%phase 0.5 = one point for defining wrench one has been placed

%phase 1 = point 1 and point 2 have been placed and wrench 1 and twist 1
%have been plotted

%Phase 2 = everything has been plotted
phase = 0;

drag1 = 0;      %crontrols the dragging of handle 1 (value = 0 or 1)
drag2 = 0;      %controls the dragging of handle 2 (value = 0 or 1)
drag3 = 0;      %controls the dragging of handle 3 ^^


%Creates an axis for the mechanism to be graphed on
ax = axes();
linkaxes(ax);
axis([-6 6 -6 6]);
set(ax,'units','normalized')
set(ax,'Position',[0.285, 0.05, 0.43, 0.9])
grid on; grid minor; box on;
axis equal; hold on;


%Set the limit mode to manual and calls the callback
%functions for interactions with the axis
set(ax,'XLimMode','manual');
set(ax,'YLimMode','manual');
set(fig,'WindowButtonDownFcn',{@MouseClick, ax});            %%%%%%
set(fig,'WindowButtonMotionFcn',{@MouseDrag, ax});           %%%%%%
set(fig,'WindowButtonUpFcn',{@MouseRelease, ax});            %%%%%%
set(fig,'menubar','none');


%Adds a point to identify the origin
scatter(0,0,'+','markerfacecolor',[0 0 0], ...
    'sizedata',120,'markeredgecolor',[0 0 0]);

set(gca,'FontSize',15);


%defines the home button
home = uicontrol('Style', 'pushbutton', ...
    'String','Home','Units', 'Normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.65, ...
    'BackgroundColor',[1 1 1], ...
    'ForegroundColor',[0 0 0], ...
    'Position',[0.025 0.93 0.1 0.05], ...
    'Callback',{@UIcallback3S,0,'Home'});


open_gde = uicontrol('Style', 'pushbutton', ...
    'String','Open Guide','Units', 'Normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.55, ...
    'BackgroundColor',[1 1 1], ...
    'ForegroundColor',[0 0 0], ...
    'Position',[0.145 0.93 0.1 0.05], ...
    'Callback',{@UIcallback3S,0,'open_gde'});

%% hp1
%creates a pannel to be used to control the Input
hp = uipanel('FontSize',10,...
    'units','normalized',...
    'tag','panel',...
    'title','Input',...
    'BackgroundColor','white',...
    'Position',[0.01 0.02 0.25 0.9]);

%Creates a table for the user to input the Stiffness matrix
table = uitable('units','normalized',...
            'parent',hp,...
            'Tag', 'table', ...
            'position',[0.1 0.782 0.8 0.15],...
            'fontsize',10,...
            'Data',K,...
            'Rowname',[],...
            'FontUnits','normalized', ...
            'FontSize', 0.2, ...
            'ColumnName',[],...
            'ColumnFormat',{'numeric' 'numeric' 'numeric'},...
            'RowStriping','off',...
            'ColumnEditable',[true true true],...
            'CellEditCallback',{@UIcallback3S,ax,'k'},...
            'SelectionHighlight','off');  

%Creates a label for the table created right before this
Klab = uicontrol('Style','text', 'Parent',hp, ...
    'Units', 'normalized', ...
    'String', 'Stiffness Matrix', ...
    'Position', [0.1 0.93 0.8 0.04], ...
    'HorizontalAlignment', 'center', ...
    'FontUnits','normalized', ...
    'FontSize', 0.725);

%Creates a label for the x inputs 
xInLab = uicontrol('Style', 'text', ...
    'Parent', hp, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'Position', [0.325 0.68 0.3 0.05], ...
    'String', 'X');

%creates a label for the y inputs
yInLab = uicontrol('Style', 'text', ...
    'Parent', hp, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'Position', [0.625 0.68 0.3 0.05], ...
    'String', 'Y');

%Creates a label for the point 1 inputs 
Pt1Lab = uicontrol('Style', 'text', ...
    'Parent', hp, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'Position', [0.025 0.63 0.3 0.05], ...
    'String', 'Point 1');

%Creates an input box for point 1 x
pt1x = uicontrol('Style', 'edit', ...
    'Parent', hp, ...
    'String', '', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'Position', [0.325 0.63 0.3 0.05], ...
    'Tag', 'pt1x');

%creates an input box for point 1 y
pt1y = uicontrol('Style', 'edit', ...
    'Parent', hp, ...
    'String', '', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'Position', [0.625 0.63 0.3 0.05], ...
    'Tag', 'pt1y');

%Creates a label for the point 2 inputs
Pt2Lab = uicontrol('Style', 'text', ...
    'Parent', hp, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'Position', [0.025 0.58 0.3 0.05], ...
    'String', 'Point 2');

%creates an input box for point 2 x
pt2x = uicontrol('Style', 'edit', ...
    'Parent', hp, ...
    'String', '', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'Position', [0.325 0.58 0.3 0.05], ...
    'Tag', 'pt2x');

%creates an input box for point 2 y
pt2y = uicontrol('Style', 'edit', ...
    'Parent', hp, ...
    'String', '', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'Position', [0.625 0.58 0.3 0.05], ...
    'Tag', 'pt2y');

%Creates a label for the box showing the x position
xlab = uicontrol('Style', 'text', ...
    'Tag', 'xlab', ...
    'String', 'X-Position', ...
    'Units', 'normalized', ...
    'FontUnits','normalized', ...
    'FontSize', 0.45, ...
    'Parent', hp, ...
    'Position', [0.025 0.45 0.265 0.05]);



%creates the box that shows the x position
xpos = uicontrol('Style', 'edit', ...
    'String', '', 'tag', 'xpos', ...
    'Units', 'normalized', ...
    'FontUnits','normalized', ...
    'FontSize', 0.6, ...
    'Parent', hp, ...
    'Position', [0.025 0.41 0.265 0.05], ...
    'Enable','inactive');



%Creates a label for the box showing the y position
ylab = uicontrol('Style', 'text', ...
    'Tag', 'ylab', ...
    'String', 'Y-Position', ...
    'Units', 'normalized', ...
    'FontUnits','normalized', ...
    'FontSize', 0.45, ...
    'Parent', hp, ...
    'Position', [0.29 0.45 0.265 0.05]);



%Creates the box showing the y position
ypos = uicontrol('Style', 'edit', ...
    'String', '', 'tag', 'ypos', ...
    'units', 'Normalized', ...
    'FontUnits','normalized', ...
    'FontSize', 0.6, ...
    'Parent', hp, ...]
    'Position', [0.29 0.41 0.265 0.05], ...
    'Enable','inactive');


%creates a label for the axes scalar box
scalarLab = uicontrol('Style','text','string','Axes Scaler: ',...
    'HorizontalAlignment', 'center', ...
    'parent', hp, ...
    'units','normalized',...
    'fontunits','normalized',...
    'fontsize', 0.45,...
    'position',[0.63 0.45 0.3 0.05],...     %[0.025 0.33 0.3 0.05] Format 1
    'tag','dimlabel');



%creates the axes scalar box
scalar = uicontrol('Style','edit','string','6',...
    'Value', 6, ...
    'parent', hp, ...
    'units','normalized',...
    'fontunits','normalized',...
    'fontsize', 0.5,...
    'position',[0.63 0.41 0.3 0.05],... %[0.025 0.28 0.3 0.05] Format 1
    'tag','dim',...
    'Callback',{@UIcallback3S,ax,'dim'});

%Creates a sumbit button for after users enter their values
sbmt = uicontrol('Style', 'pushbutton', ...
    'Parent', hp, 'Units', 'normalized', ...
    'Position', [0.1 0.17 0.35 0.09], ...
    'String', 'Submit', ...
    'Tag', ' Submit', ...
    'ForegroundColor', [0 0 0], ...
    'BackgroundColor', [1 1 1], ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.5, ...
    'Callback', {@UIcallback3S, ax, 'Submit'});            


%creates a reset button
rst = uicontrol('Style','pushbutton',...
    'parent', hp, ...
    'String','Reset',...
    'units','normalized',...
    'backgroundcolor',[1 1 1],...
    'foregroundcolor',[0 0 0],...
    'position',[0.55 0.17 0.35 0.09],...
    'fontunits','normalized',...
    'fontsize',0.5,...
    'tag','reset',...
    'value',0,...
    'Callback',{@UIcallback3S,ax,'reset'});


%% hp2
%Creates a pannel for the user to view the output
hp2 = uipanel('FontSize',10,...
    'units','normalized',...
    'tag','panel2',...
    'title','Output',...
    'BackgroundColor','white',...
    'Position',[0.74 0.02 0.25 0.9]);

%creates a label for the table above
linLab = uicontrol('Style','text', ...
    'Parent',hp2, ...
    'Units', 'normalized', ...
    'String', 'Spring Line of Action Equations', ...
    'FontUnits','normalized', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.91 0.9 0.04]);

%creates an ouput box for line equation 1
lin1 = uicontrol('Style', 'text', ...
    'Parent', hp2, ...
    'String', '  ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.869 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'lin1');

%Creates a label for line equation 1
lin1lab = uicontrol('Style', 'Text', ...
    'Parent', hp2, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 1', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.869 0.25 0.04]);

%creates an ouput box for line equation 2
lin2  = uicontrol('Style', 'text', ...
    'Parent', hp2, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.828 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'lin2');

%Creates a label for line 2 equation
lin2lab = uicontrol('Style', 'Text', ...
    'Parent', hp2, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 2', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.828 0.25 0.04]);

%creates an ouput box for line equation 3
lin3 = uicontrol('Style', 'text', ...
    'Parent', hp2, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.787 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'lin3');

%Creates a label for line 3 equation
lin3lab = uicontrol('Style', 'Text', ...
    'Parent', hp2, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 3', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.787 0.25 0.04]);

%Creates a label for the spring wrenches
wrenchlab = uicontrol('Style', 'Text', ...
    'Parent', hp2, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Transpose Spring Wrenches', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.72 0.9 0.04]);

%creates an ouput box for spring wrench 1
wrench1 = uicontrol('Style', 'text', ...
    'Parent', hp2, ...
    'String', '  ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.679 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'wrench1');

%Creates a label for spring wrench 1
wrench1lab = uicontrol('Style', 'Text', ...
    'Parent', hp2, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 1', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.679 0.25 0.04]);

%creates an ouput box for spring wrench 2
wrench2  = uicontrol('Style', 'text', ...
    'Parent', hp2, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.638 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'wrench2');

%Creates a label for spring wrench 2
wrench2lab = uicontrol('Style', 'Text', ...
    'Parent', hp2, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 2', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.638 0.25 0.04]);

%creates an ouput box for spring wrench 3
wrench3 = uicontrol('Style', 'text', ...
    'Parent', hp2, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.597 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'wrench3');

%Creates a label for spring wrench 3
wrench3lab = uicontrol('Style', 'Text', ...
    'Parent', hp2, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 3', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.597 0.25 0.04]);


%Creates a label for the spring stiffnesses
stifflab = uicontrol('Style', 'Text', ...
    'Parent', hp2, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring Stiffness', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.53 0.9 0.04]);

%creates an ouput box for spring stiffness coeficient 1
stiff1 = uicontrol('Style', 'text', ...
    'Parent', hp2, ...
    'String', '  ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.489 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'stiff1');

%Creates a label for spring stiffness coeficient 1
stiff1lab = uicontrol('Style', 'Text', ...
    'Parent', hp2, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 1', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.489 0.25 0.04]);

%creates an ouput box for spring stiffness coeficient 2
stiff2  = uicontrol('Style', 'text', ...
    'Parent', hp2, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.448 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'stiff2');

%Creates a label for stiffness coeficient 2
stiff2lab = uicontrol('Style', 'Text', ...
    'Parent', hp2, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 2', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.448 0.25 0.04]);

%creates an ouput box for spring stiffness coeficient 3
stiff3 = uicontrol('Style', 'text', ...
    'Parent', hp2, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.407 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'stiff3');

%Creates a label for spring stiffness coeficient 3
stiff3lab = uicontrol('Style', 'Text', ...
    'Parent', hp2, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 3', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.407 0.25 0.04]);

%Creates a table to output the calculated stiffness matrix
Kout = uitable('units','normalized',...
            'parent',hp2,...
            'Tag', 'Kout', ...
            'position',[0.1 0.15 0.8 0.15],...
            'Data',{'', '', ''; '', '', ''; '', '', ''},...
            'Rowname',[],...
            'FontUnits','normalized', ...
            'FontSize', 0.2, ...
            'ColumnName',[],...
            'ColumnFormat',{'numeric' 'numeric' 'numeric'},...
            'RowStriping','off',...
            'ColumnEditable',[false false false],... 
            'SelectionHighlight','off');

%creats a label for the K out table 
Klab = uicontrol('Style','text', 'Parent',hp2, ...
    'Units', 'normalized', ...
    'String', 'Calculated Siffness Matrix', ...
    'Position', [0.1 0.3 0.8 0.03], ...
    'HorizontalAlignment', 'center', ...
    'FontUnits','normalized', ...
    'FontSize', 0.7);


%%


% plots compliance center
    [x,y] = stiffnessCenter(K, ax);
    scatter(x,y,'*','markerfacecolor','red','sizedata',100,'markeredgecolor','red','tag','cpoint');





%sets the figure size and position based on the size of the screen 
resolution = get(0,'screensize');
set(fig,'position',[resolution(3)/12,resolution(4)/8,1200,670]);

%makes the figure visible to the user
set(fig,'visible','on'); hold on
set(gcf,'menubar','figure')

%Opens the guide message window
guide3S()

end 