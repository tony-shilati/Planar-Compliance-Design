function Synthesis5J_FLL()

addpath('PlanarComplianceApp/5JointFLL/')
addpath('PlanarComplianceApp/General_Functions/')
clearvars -global

%Phase 1 - nothing has happened

%Phase 2 - the joint lengths have been entered

%Phase 3 - The first joint has been placed. The circle defined by the reach
%of the distal joint from joint 1 has been placed and the axes have been 
%scaled to match it. The locus of possible postions for joint 2 has been 
%placed. Wrench 1 has been placed

%Phase 4 - Twist 12 has been placed on wrench 1. The intersection of wrench
%12 and the locus of possible positions for joint 2 defines the location of
%joint 2. 

%Phase 5 - Joint 2 is placed. The circle defined by the locus of possible 
%positions for joint 3 has been placed. The Quadratic Curve T2 has been placed. 

%Phase 5 - t34 has been placed close to the line segment J1-J2 and outside
%of the quadratic curve T2. The system of eqn 49 and 50 are solved for w3
%and w3'. T3 and T3' are plotted. 

%Phase 6 - The postiton of J3 is selected by the user to either be T3 or
%T3'. The circle defined by the locus of possible positions for joint 4 is
%plotted. The line w34 has been plotted. Joint 4 is plotted at the
%intersection of the circle and w34 that is closer to t12. The quadratic
%curve passing through the first four joints is plotted. Possible joint 5
%positions are plotted

%Phase 7 - The user chooses the location for the position of joint 5 such
%that is satifies the triangle conditions



global phase dragN dragL C

C = [12.50, -13.54, 3.41; -13.54, 15.91, -3.74; 3.41, -3.74, 0.95];
%C = inv([3 -2 1; -2 6 5; 1 5 9]);
dragN = [0, 0, 0, 0];
dragL = [];
phase = 1;

%Creates the 5J figure
fig = figure(1); clf;
set(fig,'Name','Realization of a 5 Joint Serial Mechanism with Fixed Link Lengths','NumberTitle','on');
set(fig,'units','normalized');
set(fig,'renderer','OpenGL','visible','off');
set(fig,'SizeChangedFcn', {@cTableResize, fig});

pan on;
pan off;

z = 6;

ax = axes();
linkaxes(ax);
axis([-z z -z z]);
set(ax,'units','normalized')
set(ax,'Position',[0.285, 0.05, 0.43, 0.9])
grid on; grid minor; box on;
axis equal; hold on;

set(ax,'XLimMode','manual');
set(ax,'YLimMode','manual');
set(fig,'WindowButtonDownFcn', {@MouseClick, ax})
set(fig,'WindowButtonMotionFcn', {@MouseDrag, ax})
set(fig,'WindowButtonUpFcn', @MouseRelease)
set(fig,'menubar','none'); 

scatter(0,0,'+','markerfacecolor',[0 0 0],'sizedata',120,'markeredgecolor',[0 0 0]);


%defines the home button
home = uicontrol('Style', 'pushbutton', ...
    'String','Home','Units', 'Normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.65, ...
    'BackgroundColor',[1 1 1], ...
    'ForegroundColor',[0 0 0], ...
    'Position',[0.025 0.93 0.1 0.05], ...
    'Callback',{@UICallback5JFLL,0,'Home'});

open_gde = uicontrol('Style', 'pushbutton', ...
    'String','Open Guide','Units', 'Normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.55, ...
    'BackgroundColor',[1 1 1], ...
    'ForegroundColor',[0 0 0], ...
    'Position',[0.145 0.93 0.1 0.05], ...
    'Callback',{@UICallback5JFLL,0,'open_gde'});


%% hp

%Creates the Input panel 
hp = uipanel('FontSize',10,...
    'units','normalized',...
    'tag','panel',...
    'title','Inputs',...
    'BackgroundColor','white', ...
    'Position', [0.01 0.02 0.25 0.9]);


%Creates the table to input the compliance matrix
table = uitable('units','normalized',...
            'parent',hp,...
            'position',[0.1 0.782 0.8 0.15],...
            'FontUnits', 'normalized', ...
            'fontsize', 0.21,...
            'Data',C,...
            'Rowname',[],...
            'ColumnName',[],...
            'ColumnFormat',{'numeric' 'numeric' 'numeric'},...
            'RowStriping','off',...
            'ColumnEditable',[true true true],... 
            'CellEditCallback',{@UICallback5JFLL, ax, 'c'},...
            'SelectionHighlight','off',...
            'ColumnWidth',{55 55 55}, ...
            'Tag', 'table');

%Creates a label for the compliance matrix table 
clab = uicontrol('Style','text', 'Parent',hp, ...
    'Units', 'normalized', ...
    'String', 'Compliance Matrix', ...
    'Position', [0.1 0.93 0.8 0.03], ...
    'HorizontalAlignment', 'center', ...
    'FontUnits','normalized', ...
    'FontSize', 0.7);

%Creates label for the link length inputs
linklab = uicontrol('Style', 'Text', ...
    'Parent', hp, 'Units', 'normalized', ...
    'Position', [0.1 0.68 0.8 0.04], ...
    'String', 'Link Lengths', ...
    'HorizontalAlignment', 'center', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'Tag', 'llab');

%Creates a label for link length input 1
llab1 = uicontrol('Style', 'text', ...
    'Parent', hp, 'Units', 'normalized', ...
    'Position', [0.1 0.645 0.2 0.04], ...
    'String', 'Link 1', ...
    'HorizontalAlignment', 'center', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'Tag', 'llink1');

%Creates link length input 1
link1 = uicontrol('Style', 'edit', ...
    'Parent', hp, 'Units', 'normalized', ...
    'Position', [0.3 0.645 0.2 0.04], ...
    'String', '', 'Tag', 'link1', ...
    'FontUnits', 'normalized', 'FontSize', 0.7);

%Creates a label for link length input 2
llab2 = uicontrol('Style', 'text', ...
    'Parent', hp, 'Units', 'normalized', ...
    'Position', [0.1 0.604 0.2 0.04], ...
    'String', 'Link 2', ...
    'HorizontalAlignment', 'center', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'Tag', 'llink2');

%Creates link length input 2
link2 = uicontrol('Style', 'edit', ...
    'Parent', hp, 'Units', 'normalized', ...
    'Position', [0.3 0.604 0.2 0.04], ...
    'String', '', 'Tag', 'link2', ...
    'FontUnits', 'normalized', 'FontSize', 0.7);

%Creates a label for link length input 3
llab3 = uicontrol('Style', 'text', ...
    'Parent', hp, 'Units', 'normalized', ...
    'Position', [0.5 0.645 0.2 0.04], ...
    'String', 'Link 3', ...
    'HorizontalAlignment', 'center', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'Tag', 'llink3');

%Creates link length input 3
link3 = uicontrol('Style', 'edit', ...
    'Parent', hp, 'Units', 'normalized', ...
    'Position', [0.7 0.645 0.2 0.04], ...
    'String', '', 'Tag', 'link3', ...
    'FontUnits', 'normalized', 'FontSize', 0.7);

%Creates a label for link length input 4
llab4 = uicontrol('Style', 'text', ...
    'Parent', hp, 'Units', 'normalized', ...
    'Position', [0.5 0.604 0.2 0.04], ...
    'String', 'Link 4', ...
    'HorizontalAlignment', 'center', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'Tag', 'llink4');

%Creates link length input 4
link4 = uicontrol('Style', 'edit', ...
    'Parent', hp, 'Units', 'normalized', ...
    'Position', [0.7 0.604 0.2 0.04], ...
    'String', '', 'Tag', 'link4', ...
    'FontUnits', 'normalized', 'FontSize', 0.7);



%Creates an input box for the joint x coordinate
jx = uicontrol('Style', 'edit', ...
    'String', '', 'Parent', hp, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.5, ...
    'tag', 'Jx', ...
    'Position', [0.1 0.55 0.4 0.06], ...
    'Visible', 'off');

%creates an input box for the joint y coordinate
jy = uicontrol('Style', 'edit', ...
    'String', '', 'Parent', hp, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.5, ...
    'tag', 'Jy', ...
    'Position', [0.5 0.55 0.4 0.06], ...
    'Visible', 'off');

%Creates a label for the x input box
jlabx = uicontrol('Style', 'text', ...
    'String', 'X', ...
    'Units','normalized', 'FontUnits', 'normalized', ...
    'FontSize', 0.4, 'Parent', hp, ...
    'tag', 'JX', ...'
    'Position', [0.1 0.608 0.4 0.05], ...
    'Visible', 'off');

%Creates a label for the y input box
jlaby = uicontrol('Style', 'text', ...
    'String', 'Y', ...
    'Units','normalized', 'FontUnits', 'normalized', ...
    'FontSize', 0.4, 'Parent', hp, ...
    'tag', 'JY', ...
    'Position', [0.5 0.608 0.4 0.05], ...
    'Visible', 'off');

%Creates label for the box that shows the cursor x position
xlab = uicontrol('Style', 'text', ...
    'Tag', 'xalb', ...
    'String', 'X-Position', ...
    'Units', 'normalized', ...
    'FontUnits','normalized', ...
    'FontSize', 0.5, ...
    'Parent', hp, ...
    'Position', [0.35 0.385 0.3 0.05]);

%Creates a box that shows the cursor x position
xpos = uicontrol('Style', 'edit', ...
    'String', '', 'tag', 'xpos', ...
    'Units', 'normalized', ...
    'FontUnits','normalized', ...
    'FontSize', 0.7, ...
    'Parent', hp, ...
    'Position', [0.35 0.34 0.3 0.05], ...
    'Enable','inactive');

%Creates a label for the box that shows the cursor y position
ylab = uicontrol('Style', 'text', ...
    'Tag', 'ylab', ...
    'String', 'Y-Position', ...
    'Units', 'normalized', ...
    'FontUnits','normalized', ...
    'FontSize', 0.5, ...
    'Parent', hp, ...
    'Position', [0.65 0.385 0.3 0.05]);

%creates a box that shows the cursor y position
ypos = uicontrol('Style', 'edit', ...
    'String', '', 'tag', 'ypos', ...
    'units', 'Normalized', ...
    'FontUnits','normalized', ...
    'FontSize', 0.7, ...
    'Parent', hp, ...]
    'Position', [0.65 0.34 0.3 0.05], ...
    'Enable','inactive');

%Creates the box for updating the axes scalar
scalar = uicontrol('Style','edit','string','6',...
    'parent', hp, ...
    'units','normalized',...
    'fontunits','normalized',...
    'fontsize', 0.5,...
    'position',[0.025 0.34 0.3 0.05],...
    'tag','dim',...
    'Callback',{@UICallback5JFLL,ax,'dim'});                   

%Creates a label for the axes scalar box
scalarlab = uicontrol('Style','text','string','Axes Scaler:',...
    'HorizontalAlignment', 'center', ...
    'parent', hp, ...
    'units','normalized',...
    'fontunits','normalized',...
    'fontsize', 0.5,...
    'position',[0.025 0.385 0.3 0.05],...
    'tag','dimlabel');


%Creates the submit button
sbmt = uicontrol('Style', 'pushbutton', ...
    'Parent', hp, 'Units', 'normalized', ...
    'Position', [0.1 0.125 0.35 0.09], ...
    'String', 'Submit', ...
    'Tag', ' Submit', ...
    'ForegroundColor', [0 0 0], ...
    'BackgroundColor', [1 1 1], ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.5, ...
    'Callback', {@UICallback5JFLL, ax, 'Submit'}); 

%Creates the reset button
rst = uicontrol('Style','pushbutton',...
    'parent',hp,...
    'String','Reset',...
    'units','normalized',...
    'backgroundcolor',[1 1 1],...
    'foregroundcolor',[0 0 0],...
    'position',[0.55 0.125 0.35 0.09],...
    'fontunits','normalized',...
    'fontsize',0.5,...
    'tag','reset',...
    'value',0, ...
    'Callback', {@UICallback5JFLL, ax, 'reset'});



%% hpout

%Creates the output panel
hpout = uipanel('FontSize',10,...
    'units','normalized',...
    'tag','panelout',...
    'title','Outputs',...
    'BackgroundColor','white', ...
    'Position', [0.74 0.02 0.25 0.9]);


%Creates initial output data for the joint position table
[Cx, Cy, ~] = compliantCenter(C, ax);
cx = sprintf('%0.3f', Cx);
cy = sprintf('%0.3f', Cy);
Jout1 = {cx,'','';
       cy,'',''};

Jout2 = {'','','';
       '','',''};

%Creates the output table for the joint positions
Jtab1 = uitable('units','normalized',...
            'parent',hpout,...
            'position',[0.05 0.84 0.9 0.1],...
            'FontUnits', 'normalized', ...
            'fontsize',0.15,...
            'Data',Jout1,...
            'tag','jout',...
            'Rowname',{'X','Y'},...
            'ColumnName',{'Cc','J1','J2'},...
            'ColumnFormat',{'numeric' 'numeric' 'numeric'},...
            'RowStriping','off',...
            'SelectionHighlight','off');

%Creates the output table for the joint positions
Jtab2 = uitable('units','normalized',...
            'parent',hpout,...
            'position',[0.05 0.73 0.9 0.1],...
            'FontUnits', 'normalized', ...
            'fontsize',0.15,...
            'Data',Jout2,...
            'tag','jout2',...
            'Rowname',{'X','Y'},...
            'ColumnName',{'J3', 'J4', 'J5'},...
            'ColumnFormat',{'numeric' 'numeric' 'numeric'},...
            'RowStriping','off',...
            'SelectionHighlight','off');



%creates a label for the output table 
Jlab = uicontrol('Style','text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'String', 'Joint Positions', ...
    'FontUnits','normalized', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.94 0.9 0.04]);

%Creates a label for the joint compliances
compLab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Joint Compliance', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.62 0.9 0.04]);


%creates an ouput box for joint compliance 1
comp1 = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', '  ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.579 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'comp1');

%Creates a label for joint 1 compliance
comp1lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Joint 1', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.579 0.25 0.04]);

%creates an ouput box for joint 2 compliance
comp2  = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.538 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'comp2');

%Creates a label for joint 2 compliance 
comp2lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Joint 2', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.538 0.25 0.04]);

%creates an ouput box for joint 3 compliance
comp3 = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.497 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'comp3');

%Creates a label for joint 3 compliance
comp3lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Joint 3', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.497 0.25 0.04]);

%creates an ouput box for joint 4 compliance
comp4 = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.456 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'comp4');

%Creates a label for joint 4 compliance
comp4lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Joint 4', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.456 0.25 0.04]);

%creates an ouput box for joint 5 compliance
comp5 = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.415 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'comp5');

%Creates a label for joint 5 compliance
comp5lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Joint 5', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.415 0.25 0.04]);

%Creates a table for the Calculated compliance matrix output
Cout = uitable('units','normalized',...
            'parent',hpout,...
            'Tag', 'Cout', ...
            'position',[0.1 0.1 0.8 0.15],...
            'Data', {'', '', ''; '', '', ''; '', '', ''},...
            'Rowname',[],...
            'FontUnits','normalized', ...
            'FontSize', 0.21, ...
            'ColumnName',[],...
            'ColumnFormat',{'numeric' 'numeric' 'numeric'},...
            'RowStriping','off',...
            'ColumnEditable',[false false false],... 
            'SelectionHighlight','off');

%creats a label for the C out table 
Clab = uicontrol('Style','text', 'Parent',hpout, ...
    'Units', 'normalized', ...
    'String', 'Calculated Compliance Matrix', ...
    'Position', [0.1 0.25 0.8 0.03], ...
    'HorizontalAlignment', 'center', ...
    'FontUnits','normalized', ...
    'FontSize', 0.7);

%%

%Displays the complinace center on the plot
[x, y, C] = compliantCenter(C, ax);
scatter(x,y,'*','markerfacecolor','red','sizedata',100,'markeredgecolor','red','tag','cpoint');

%Sizes and positions the main window
set(fig, 'Units', 'pixels')
resolution = get(0,'screensize');
set(fig,'position',[resolution(3)/12,resolution(4)/8,1200,670]);

%Opens the guide window
guide5J_FLL()

set(fig,'visible','on'); hold on
set(gcf,'menubar','figure');








end