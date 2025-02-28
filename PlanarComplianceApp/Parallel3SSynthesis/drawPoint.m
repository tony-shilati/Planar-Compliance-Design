function [] = drawPoint(x, y, tag, ax)

%tag point1 = unused
%tag point2 = twist1
%tag point3 = twist2
%tag point4 = twist3

%finds the tag of the point being plotted
markerTag = ['Tag' tag(6)];
mtag =  findobj(ax, 'Tag', markerTag);

%finds and previous point plotted with the same tag 
pt = findobj(ax, 'Tag', tag);

%deletes any previous tag and point to avoid duplicates
if ~isempty(pt)
    delete(pt)
end 
if ~isempty(mtag)
    delete(mtag)
end 

%Sets the color and label for the point being plotted
if strcmp(tag, 'point2')
    color = '#5DB5F8';
    text(x, y, '  T1', 'Tag', 'Tag2')
elseif strcmp(tag, 'point3')
    color = '#77AC30';
    text(x, y, '  T2', 'Tag', 'Tag3')
elseif strcmp(tag, 'point4')
    color = '#A2142F';
    text(x, y, '  T3', 'Tag', 'Tag3')
end 

%Plots the point
pt = scatter(x,y,'filled','markerfacecolor',color,'tag',tag,'sizedata',75, 'MarkerEdgeColor', [0 0 0]);

%Sets the callback for clicking on the point to @MouseClick
set(pt,'ButtonDownFcn',{@MouseClick, ax});
%Makes is so that the point is seen above other objects on the axes
uistack(pt, "top")
end