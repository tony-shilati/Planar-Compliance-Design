function [] = MouseDrag(~, ~, ax)

global phase drag1 drag2 func C

%gets the figure objects
fig = get(ax, 'Parent');


%% Displays the current location of the mouse over the axes
[x,y] = getCurrentXY(ax);
ylim = get(ax,'ylim');
xlim = get(ax,'xlim');
if xlim(1) < x && x < xlim(2) && ylim(1) < y && y< ylim (2)
    xy = findobj(ax, 'tag', 'xy');
    delete(xy)
    xpos = findobj(fig, 'tag', 'xpos');
    ypos = findobj(fig, 'tag', 'ypos');
    xpos1 = sprintf('%0.3f', x);
    ypos1 = sprintf('%0.3f', y);
    set(xpos, 'String', xpos1);
    set(ypos, 'String', ypos1);

else
    xy = findobj(ax, 'tag', 'xy');
    delete(xy)
end 


%% Updates the ui when the mouse is clicked and dragged
if drag1 == 1
    %% Updates the UI when Joint 1 is being dragged
    

   j1 = findobj('tag', 'J1');
   j2 = findobj('tag', 'J2');
   j3 = findobj('tag', 'J3');
   delete(j1);
   try
       delete(j2)
       delete(j3)
       jh = findobj(fig,'tag','jout');
       Jout = get(jh,'Data');
       X = sprintf('%0.3f', x);
       Y = sprintf('%0.3f', y);
       Jout{1,2} = X;
       Jout{2,2} = Y;
       
       set(jh,'Data',Jout);
   catch
   end

    if phase == 1 || phase == 0
        drawPoint(x,y,'point1',ax);
        
        phase = 1;
    elseif phase == 2
        
    elseif phase == 3
        
    end
 
elseif drag2 == 1
    %% Updates the UI when joint 2 is being dragged
    [x, y] = getCurrentXY(ax);
    
    try
        j2 = findobj('tag', 'J2');
        j3 = findobj('tag', 'J3');
        delete(j3)
        delete(j2)
    catch
    end
    if phase == 1 || phase == 0

    elseif phase == 2
        y = func(x);
        drawPoint(x,y,'point2',ax);
        [x2,y2] = generateJ3(x,y,C,func);
        drawPoint(x2,y2,'point3',ax);
        phase = 2;     
    end
    
end

end

