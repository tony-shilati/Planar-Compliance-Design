function [ ] = drawLine( x, y, ax)

global func C


pt = findobj(ax,'Tag','line');

if ~isempty(pt)
    delete(pt);
end

xlim = get(ax,'xlim');

[x1, y1, func] = generateLine(x,y,C);

slope = (y1(2) - y1(1)) / (x1(2) - x1(1));


%yval = slope*xlim + (2*y - (2*slope*x));
yval = func(xlim);

if isinf(slope)
    yval = get(ax,'ylim');
    xlim = x;
end

pl = plot(ax, xlim,yval,'-','tag','line','linewidth',2,'color',[0.9 0.9 0.3]);

set(pl,'ButtonDownFcn',{@MouseClick,ax});

end

