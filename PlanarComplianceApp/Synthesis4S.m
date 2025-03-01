function [] = Synthesis4S()

addpath('PlanarComplianceApp/Parallel4SSynthesis/')
addpath('PlanarComplianceApp/General_Functions/')
clearvars -global

%Phase 1 - Nothing has happened

%Phase 2 - Twist 1 has been placed and wrench 1 has been plotted

%Phase 3 - Twist 2 has been placed, wrench 2 has been placed, and a line
%segment between twist 1 and 2 has been placed

%Phase 4 - Handle 1 for wrench 3 has been placed

%Phase 5 - Handle 2 for wrench 3 has been placed and wrench 3 has been
%placed

%Phase 6 - Everything has been placed

global phase dragN dragL K
K = [3 -2 1; -2 6 5; 1 5 9];
phase = 1;
dragN = [0;0;0;0;0];
dragL = [0;0;0];

fig = figure(1); clf;
set(fig,'Name','Realization of a 4 Spring Parallel Mechanism','NumberTitle','on');
set(fig,'units','pixels');
set(fig,'renderer','OpenGL','visible','off');
set(fig,'SizeChangedFcn', {@cTableResize, fig});
pan on;
pan off;

z = 6;

ax = axes();
linkaxes(ax);
axis([-z z -z z]);
set(ax, 'Units', 'normalized')
set(ax,'Position',[0.285, 0.05, 0.43, 0.9])
grid on; grid minor; box on;
axis equal; hold on;

set(ax,'XLimMode','manual');
set(ax,'YLimMode','manual');
set(ax,'ButtonDownFcn',{@MouseClick, ax});
set(fig,'WindowButtonMotionFcn',{@MouseDrag, ax});
set(fig,'WindowButtonUpFcn', @MouseRelease);
set(fig,'menubar','none');

% Creates a legend with only the desired values present
p1 = plot([0, 0], [0.0001, 0], 'Color', [0.3010 0.7450 0.9330], 'LineWidth', 2, 'DisplayName', 'Spring 1', 'Tag', 'M1');
p2 = plot([0, 0], [0.0001, 0], 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 2, 'DisplayName', 'Spring 2', 'Tag', 'M2');
p3 = plot([0, 0], [0.0001, 0], 'Color', [0.6350 0.0780 0.1840], 'LineWidth', 2, 'DisplayName', 'Spring 3', 'Tag', 'M3');
p4 = plot([0, 0], [0.0001, 0], 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 2, 'DisplayName', 'Spring 4', 'Tag', 'M4');

leg = legend;
leg.AutoUpdate = "off";
Ls = leg.String;
Lss = size(Ls);
for i = 1:Lss(2)
    if ~strcmp(Ls(1, i), 'Spring 1') && ~strcmp(Ls(1, i), 'Spring 2') && ~strcmp(Ls(1, i), 'Spring 3') && ...
            ~strcmp(Ls(1, i), 'Spring 4')
        Ls(1, i) = {''};
    end
end
legend(Ls)

scatter(0,0,'+','markerfacecolor',[0 0 0],'sizedata',120,'markeredgecolor',[0 0 0]);

%defines the home button
home = uicontrol('Style', 'pushbutton', ...
    'String','Home','Units', 'Normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.65, ...
    'BackgroundColor',[1 1 1], ...
    'ForegroundColor',[0 0 0], ...
    'Position',[0.025 0.93 0.1 0.05], ...
    'Callback',{@UIcallback4S,0,'Home'});

open_gde = uicontrol('Style', 'pushbutton', ...
    'String','Open Guide','Units', 'Normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.55, ...
    'BackgroundColor',[1 1 1], ...
    'ForegroundColor',[0 0 0], ...
    'Position',[0.145 0.93 0.1 0.05], ...
    'Callback',{@UIcallback4S,0,'open_gde'});

%% hp

%Creates the input panel
hp = uipanel('FontSize',10,...
    'units','normalized',...
    'tag','panel',...
    'title','Inputs',...
    'BackgroundColor','white',...
    'Position',[0.01 0.02 0.25 0.9]);


%creates a table for the comliance matrix
table = uitable('units','normalized',...
            'parent',hp,...
            'position',[0.1 0.782 0.8 0.15],...
            'FontUnits', 'normalized', ...
            'fontsize',0.23,...
            'Data',K,...
            'Rowname',[],...
            'ColumnName',[],...
            'ColumnFormat',{'numeric' 'numeric' 'numeric'},...
            'RowStriping','off',...
            'ColumnEditable',[true true true],...
            'CellEditCallback',{@UIcallback4S,ax,'c'},...
            'SelectionHighlight','off',...
            'ColumnWidth',{55 55 55}, ...
            'Tag', 'table');

%Creates a label for the table created right before this
Klab = uicontrol('Style','text', 'Parent',hp, ...
    'Units', 'normalized', ...
    'String', 'Stiffness Matrix', ...
    'Position', [0.1 0.93 0.8 0.04], ...
    'HorizontalAlignment', 'center', ...
    'FontUnits','normalized', ...
    'FontSize', 0.725);

%Creates an input box for the joint x coordinate
jx = uicontrol('Style', 'edit', ...
    'String', '', 'Parent', hp, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.5, ...
    'tag', 'Jx', ...
    'Position', [0.1 0.55 0.4 0.06]);

%creates an input box for the joint y coordinate
jy = uicontrol('Style', 'edit', ...
    'String', '', 'Parent', hp, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.5, ...
    'tag', 'Jy', ...
    'Position', [0.5 0.55 0.4 0.06]);

%Creates a label for the x input box
jxlab = uicontrol('Style', 'text', ...
    'String', 'X-Coordinate', ...
    'Units','normalized', 'FontUnits', 'normalized', ...
    'FontSize', 0.4, 'Parent', hp, ...
    'tag', 'JX', ...'
    'Position', [0.1 0.608 0.4 0.05]);

%Creates a label for the y input box
jylab = uicontrol('Style', 'text', ...
    'String', 'Y-Coordinate', ...
    'Units','normalized', 'FontUnits', 'normalized', ...
    'FontSize', 0.4, 'Parent', hp, ...
    'tag', 'JY', ...
    'Position', [0.5 0.608 0.4 0.05]);

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
    'Callback',{@UIcallback4S,ax,'dim'});                   

%Creates a label for the axes scalar box
scalarlab = uicontrol('Style','text','string','Axes Scaler:',...
    'HorizontalAlignment', 'center', ...
    'parent', hp, ...
    'units','normalized',...
    'fontunits','normalized',...
    'fontsize', 0.5,...
    'position',[0.025 0.385 0.3 0.05],...
    'tag','dimlabel');

%Creates a reset button
rst = uicontrol('Style','pushbutton',...
    'parent',hp,...
    'String','Reset',...
    'units','normalized',...
    'backgroundcolor',[1 1 1],...
    'foregroundcolor',[0 0 0],...
    'position',[0.55 0.16 0.35 0.09],...
    'fontunits','normalized',...
    'fontsize',0.5,...
    'tag','reset',...
    'value',0,...
    'Callback',{@UIcallback4S,ax,'reset'});

%Creates the submit button
sbmt = uicontrol('Style', 'pushbutton', ...
    'Parent', hp, 'Units', 'normalized', ...
    'Position', [0.1 0.16 0.35 0.09], ...
    'String', 'Submit', ...
    'Tag', ' Submit', ...
    'ForegroundColor', [0 0 0], ...
    'BackgroundColor', [1 1 1], ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.5, ...
    'Callback', {@UIcallback4S, ax, 'Submit'}); 


%% hpout
hpout = uipanel('FontSize',10,...
    'units','normalized',...
    'tag','panelout',...
    'title','Output',...
    'BackgroundColor','white',...
    'Position',[0.74 0.02 0.25 0.9]);


%creates a label for the table above
linLab = uicontrol('Style','text', ...
    'Parent',hpout, ...
    'Units', 'normalized', ...
    'String', 'Spring Line of Action Equations', ...
    'FontUnits','normalized', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.94 0.9 0.04]);

%creates an ouput box for line equation 1
lin1 = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', '  ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.899 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'lin1');

%Creates a label for line equation 1
lin1lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 1', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.899 0.25 0.04]);

%creates an ouput box for line equation 2
lin2  = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.858 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'lin2');

%Creates a label for line 2 equation
lin2lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 2', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.858 0.25 0.04]);

%creates an ouput box for line equation 3
lin3 = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.818 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'lin3');

%Creates a label for line 3 equation
lin3lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 3', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.818 0.25 0.04]);


%creates an ouput box for line equation 4
lin4 = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.777 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'lin4');

%Creates a label for line 4 equation
lin4lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 4', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.777 0.25 0.04]);

%Creates a label for the spring wrenches
wrenchlab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Transpose Spring Wrenches', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.72 0.9 0.04]);

%creates an ouput box for spring wrench 1
wrench1 = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
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
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 1', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.679 0.25 0.04]);

%creates an ouput box for spring wrench 2
wrench2  = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
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
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 2', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.638 0.25 0.04]);

%creates an ouput box for spring wrench 3
wrench3 = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
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
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 3', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.597 0.25 0.04]);

%creates an ouput box for spring wrench 4
wrench4 = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.556 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'wrench4');

%Creates a label for spring wrench 3
wrench4lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 4', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.556 0.25 0.04]);

%Creates a label for the spring stiffnesses
stiffLab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring Stiffness', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.477 0.9 0.04]);

%creates an ouput box for spring stiffness 1
stiff1 = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', '  ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.436 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'stiff1');

%Creates a label for spring stiffness 1
stiff1lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 1', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.436 0.25 0.04]);

%creates an ouput box for Spring stiffness 2
stiff2  = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.395 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'stiff2');

%Creates a label for spring 2 stiffness
stiff2lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 2', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.395 0.25 0.04]);

%creates an ouput box for spring stiffness 3
stiff3 = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.354 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'stiff3');

%Creates a label for spring stiffness 3
stiff3lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 3', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.354 0.25 0.04]);

%creates an ouput box for spring stifffness 4
stiff4 = uicontrol('Style', 'text', ...
    'Parent', hpout, ...
    'String', ' ', ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.7, ...
    'BackgroundColor', [1 1 1], ...
    'ForegroundColor', [0 0 0], ...
    'Position', [0.3 0.313 0.65 0.04], ...
    'HorizontalAlignment','left', ...
    'Tag', 'stiff4');

%Creates a label for spring stiffness 4
stiff4lab = uicontrol('Style', 'Text', ...
    'Parent', hpout, ...
    'Units', 'normalized', ...
    'FontUnits', 'normalized', ...
    'String', 'Spring 4', ...
    'FontSize', 0.7, ...
    'Position', [0.05 0.313 0.25 0.04]);

%Creates a table to output the calculated stiffness matrix
Kout = uitable('units','normalized',...
            'parent',hpout,...
            'Tag', 'Kout', ...
            'position',[0.1 0.08 0.8 0.15],...
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
Klab = uicontrol('Style','text', 'Parent',hpout, ...
    'Units', 'normalized', ...
    'String', 'Calculated Siffness Matrix', ...
    'Position', [0.1 0.23 0.8 0.03], ...
    'HorizontalAlignment', 'center', ...
    'FontUnits','normalized', ...
    'FontSize', 0.7);

%%

%Displays the compliant center on the axes
stiffnessCenter(K, ax);

%positions the window on the screen
resolution = get(0,'screensize');
set(fig,'position',[resolution(3)/12,resolution(4)/8,1200,670]);

guide4S()

set(fig,'visible','on'); hold on;
set(gcf,'menubar','figure');

end
