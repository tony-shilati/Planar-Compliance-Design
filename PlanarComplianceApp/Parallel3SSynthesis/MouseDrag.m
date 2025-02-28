function [] = MouseDrag(obj, ~, ax)

global phase drag1 drag2 drag3 drag4

fig = get(ax, 'Parent');

%find the current position of the cursor
[x, y] = getCurrentXY(ax);

%Get acces to the coordinate input boxes
pt1x = findobj(fig, 'Tag', 'pt1x');
pt1y = findobj(fig, 'Tag', 'pt1y');
pt2x = findobj(fig, 'Tag', 'pt2x');
pt2y = findobj(fig, 'Tag', 'pt2y');

%find the boundaries of the axes in the figure
ylim = get(ax,'ylim');
xlim = get(ax,'xlim');

%if the cursor is in bounds of the axes on the figure
if xlim(1) < x && x < xlim(2) && ylim(1) < y && y< ylim (2)

    %delete the children of axes with the tag 'xy'
    delete(findobj(ax, 'tag', 'xy'))

    %find children of the figure with the given tags
    xpos = findobj(fig, 'tag', 'xpos');
    ypos = findobj(fig, 'tag', 'ypos');

    %Change the number of decimals to 2
    xpos1 = sprintf('%0.2f', x);
    ypos1 = sprintf('%0.2f', y);

    %Display the x and y values on the gui
    set(xpos, 'String', xpos1);
    set(ypos, 'String', ypos1);



if drag1 == 1
    if phase == 0.5
        delete(findobj(ax, 'Tag', 'line1'))
        delete(findobj(ax, 'Tag', 'handle2'))
        delete(findobj(ax, 'Tag', 'point2'))
        drawHandle(ax, 'handle1', x, y)
    elseif phase > 0.5 
        phase = 0;
        delete(findobj(ax, 'tag', 'line2'))
        delete(findobj(ax, 'tag', 'line3'))
        delete(findobj(ax, 'tag', 'point3'))
        delete(findobj(ax, 'tag', 'point4'))
        delete(findobj(ax, 'tag', 'Tag3'))
        delete(findobj(ax, 'tag', 'Tag4'))
        delete(findobj(ax, 'tag', 'handle3'))
    
        hndl2 = findobj(ax, 'Tag', 'handle2');
        set(pt2x, 'String', hndl2.XData)
        set(pt2y, 'String', hndl2.YData)
        set(pt1x, 'String', x)
        set(pt1y, 'String', y)
    
        UIcallback3S(0, 0, ax, 'Submit')
    
        
        set(pt2x, 'Enable', 'on')
        set(pt2y, 'Enable', 'on')
    end


elseif drag2 == 1
    phase = 0.5;
    delete(findobj(ax, 'tag', 'line2'))
    delete(findobj(ax, 'tag', 'line3'))
    delete(findobj(ax, 'tag', 'point3'))
    delete(findobj(ax, 'tag', 'point4'))
    delete(findobj(ax, 'tag', 'Tag3'))
    delete(findobj(ax, 'tag', 'Tag4'))
    delete(findobj(ax, 'tag', 'handle3'))

        
    hndl1 = findobj(ax, 'Tag', 'handle1');
    set(pt1x, 'String', hndl1.XData)
    set(pt1y, 'String', hndl1.YData)
    set(pt2x, 'String', x)
    set(pt2y, 'String', y)
        

    UIcallback3S(0, 0, ax, 'Submit')
 
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

elseif drag3 == 1

    drawHandle(ax, 'handle3', x, y)
    phase = 1;


    set(pt2x, 'String', num2str(x))
    set(pt2y, 'String', num2str(y))

    delete(findobj(ax, 'tag', 'line2'))
    delete(findobj(ax, 'tag', 'line3'))
    delete(findobj(ax, 'tag', 'point3'))
    delete(findobj(ax, 'tag', 'point4'))
    delete(findobj(ax, 'tag', 'Tag3'))
    delete(findobj(ax, 'tag', 'Tag4'))
    delete(findobj(ax, 'tag', 'handle3'))
    try
        UIcallback3S(0, 0, ax, 'Submit')
    catch
    end

elseif drag4 ==1
    phase = 0;
    hndl1 = findobj(ax, 'Tag', 'handle1');
    h1x = hndl1.XData;
    h1y = hndl1.YData;
    hndl2 = findobj(ax, 'Tag', 'handle2');
    h2x = hndl2.XData;
    h2y = hndl2.YData;
    m1 = (h2y - h1y)/(h2x - h1x);

    [H1x, H1y] = perpIntersect(x, y, m1, h1x, h1y);
    [H2x, H2y] = perpIntersect(x, y, m1, h2x, h2y);


    set(pt2x, 'String', H2x)
    set(pt2y, 'String', H2y)
    set(pt1x, 'String', H1x)
    set(pt1y, 'String', H1y)

    UIcallback3S(0, 0, ax, 'Submit')
    
end 


end 