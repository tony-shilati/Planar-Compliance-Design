function [ ] = drawPoint( x, y, tag, ax)
%for 3J synthesis
global x1 y1

pt = findobj(ax,'tag',tag);

if strcmp(tag,'point1')
    x1 = x;
    y1 = y;
    size = 90;
    text(x1, y1,'   J1', 'tag', 'J1');
elseif strcmp(tag,'point2')
    size = 90;
    text(x, y, '   J2', 'tag', 'J2');
elseif strcmp(tag,'point3')
    size = 90;
    text(x, y, '  J3', 'tag', 'J3');
end

if ~isempty(pt)
    delete(pt);
end

pt = scatter(ax, x,y,'filled','markerfacecolor',[0.2 0.6 1],'tag',tag,'sizedata',size, 'MarkerEdgeColor', [0 0 0]);

set(pt,'ButtonDownFcn',{@MouseClick, ax});

if strcmp(tag,'point1')
    drawLine(x,y,ax);
end

if strcmp(tag,'point3')
   drawConnections(ax); 
end


end

