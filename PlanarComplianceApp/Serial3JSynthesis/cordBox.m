function cordBox(x, y, ax)

global phase func gdeData3J C

%Gets the objects for the figures
fig = get(ax, 'Parent');
child = get(0, 'children'); gde = child(2);

%Gets the text box object that displays the messages
child2 = get(gde, 'Children'); msg = child2(3);

%this file is responsible for updating the interface afeter the user
%interacts with the coordinate input box

if phase == 0
    if isnan(x) || isnan(y)
        invalidSelection()
    else
        hold on;
        drawPoint(x,y,'point1',ax);
        phase = 1;
        set(msg, 'String', gdeData3J.msg2);
    end
elseif phase == 1
    if isnan(x) || isnan(y)
        invalidSelection()
    else
        y = func(x);
        drawPoint(x,y,'point2',ax);
        
        [x2,y2] = generateJ3(x,y,C,func);
        drawPoint(x2,y2,'point3',ax);
        
        phase = 2;

        set(msg, 'String', gdeData3J.msg3)
    end 
elseif phase == 2
    if isnan(x) || isnan(y)
        invalidSelection()
    else
        delete(findobj('tag','link'))
        delete(findobj(ax, 'Tag', 'J2'))
        delete(findobj(ax, 'Tag', 'J3'))
        delete(findobj(ax, 'Tag', 'point2'))
        delete(findobj(ax, 'Tag', 'point3'))

        y = func(x);
        drawPoint(x,y,'point2',ax);
        
        [x2,y2] = generateJ3(x,y,C,func);
        drawPoint(x2,y2,'point3',ax);
    end

end
    
end

