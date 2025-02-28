function [] = MouseClick(obj, ~, ax)

%defines the global variables 
global phase drag1 drag2 drag3 drag4

fig = get(ax, 'Parent');
pt1x = findobj(fig, 'Tag', 'pt1x');
pt1y = findobj(fig, 'Tag', 'pt1y');
pt2x = findobj(fig, 'Tag', 'pt2x');
pt2y = findobj(fig, 'Tag', 'pt2y');

try
[tx1, ty1] = calcTwist(ax, 'TwistOne');
catch
end


%find the boundaries of the axes
ylim = get(ax,'ylim');
xlim = get(ax,'xlim');

%finds the current position of the mouse on the axes
[x, y] = getCurrentXY(ax);
X = num2str(x);
Y = num2str(y);

if strcmp(get(obj, 'type'), 'figure')
    if phase == 0
            %if no points have been placed 
            % and the mouse clicked within the axes boundaries
            if y < ylim(2) && y > ylim(1) && x < xlim(2) && x > xlim(1)
                set(pt1x, 'String', X)
                set(pt1y, 'String', Y)
                UIcallback3S(0, 0, ax, 'Submit')

            
            end
    
    elseif phase == 0.5
        if y < ylim(2) && y > ylim(1) && x < xlim(2) && x > xlim(1)
            set(pt2x, 'String', X)
            set(pt2y, 'String', Y)
            UIcallback3S(0, 0, ax, 'Submit')
        end 

    elseif phase == 1
        if y < ylim(2) && y > ylim(1) && x < xlim(2) && x > xlim(1)
            set(pt2x, 'String', X)
            set(pt2y, 'String', Y)
            UIcallback3S(0, 0, ax, 'Submit')
        end 

    elseif phase == 2 && y < ylim(2) && y > ylim(1) && x < xlim(2) && x > xlim(1)
        
            
           
    end 
end

    
%else if the user cliks on handle one
if strcmp(get(obj, 'tag'), 'handle1')
    drag1 = 1;
    delete(findobj(fig, 'tag', 'leg'))
    delete(findobj(ax, 'tag', 'line2'))
    delete(findobj(ax, 'tag', 'line3'))
    delete(findobj(ax, 'tag', 'point3'))
    delete(findobj(ax, 'tag', 'point4'))
    delete(findobj(ax, 'tag', 'Tag3'))
    delete(findobj(ax, 'tag', 'Tag4'))
    delete(findobj(ax, 'tag', 'handle3'))
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')
    set(findobj(fig, 'Tag', 'cnfrm'), 'Visible', 'off')

    %Sets the output panel to be blank
    l = 1;
    while l < 4
        set(findobj(fig, 'Tag', ['lin' num2str(l)]), 'String', '')
        set(findobj(fig, 'Tag', ['wrench' num2str(l)]), 'String', '')
        set(findobj(fig, 'Tag', ['stiff' num2str(l)]), 'String', '')

        l = l+1;
    end

    %Resets the calculated matrix output
    Kout = findobj(fig, 'Tag', 'Kout');
    set(Kout, 'Data', {'', '', ''; '', '', ''; '', '', ''})

    
    set(pt1x, 'String', tx1)
    set(pt1y, 'String', ty1)
    
    

elseif strcmp(get(obj, 'tag'), 'handle2')
    drag2 = 1;
    phase = 1;
    delete(findobj(fig, 'tag', 'leg'))
    delete(findobj(ax, 'tag', 'line2'))
    delete(findobj(ax, 'tag', 'line3'))
    delete(findobj(ax, 'tag', 'point3'))
    delete(findobj(ax, 'tag', 'point4'))
    delete(findobj(ax, 'tag', 'Tag3'))
    delete(findobj(ax, 'tag', 'Tag4'))
    delete(findobj(ax, 'tag', 'handle3'))
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')
    set(findobj(fig, 'Tag', 'cnfrm'), 'Visible', 'off')

    %Sets the output panel to be blank
    l = 1;
    while l < 4
        set(findobj(fig, 'Tag', ['lin' num2str(l)]), 'String', '')
        set(findobj(fig, 'Tag', ['wrench' num2str(l)]), 'String', '')
        set(findobj(fig, 'Tag', ['stiff' num2str(l)]), 'String', '')

        l = l+1;
    end

    %Resets the calculated matrix output
    Kout = findobj(fig, 'Tag', 'Kout');
    set(Kout, 'Data', {'', '', ''; '', '', ''; '', '', ''})

    set(pt1x, 'String', tx1)
    set(pt1y, 'String', ty1)

elseif strcmp(get(obj, 'tag'), 'handle3')
    delete(findobj(fig, 'tag', 'leg'))
    set(findobj(fig, 'Tag', 'cnfrm'), 'Visible', 'off')
    drag3 = 1;

elseif strcmp(get(obj, 'tag'), 'line1')
    drag4 = 1;
    phase = 1;
    delete(findobj(fig, 'tag', 'leg'))
    delete(findobj(ax, 'tag', 'line2'))
    delete(findobj(ax, 'tag', 'line3'))
    delete(findobj(ax, 'tag', 'point3'))
    delete(findobj(ax, 'tag', 'point4'))
    delete(findobj(ax, 'tag', 'Tag3'))
    delete(findobj(ax, 'tag', 'Tag4'))
    delete(findobj(ax, 'tag', 'handle3'))
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

    %Sets the output panel to be blank
    l = 1;
    while l < 4
        set(findobj(fig, 'Tag', ['lin' num2str(l)]), 'String', '')
        set(findobj(fig, 'Tag', ['wrench' num2str(l)]), 'String', '')
        set(findobj(fig, 'Tag', ['stiff' num2str(l)]), 'String', '')

        l = l+1;
    end

    %Resets the calculated matrix output
    Kout = findobj(fig, 'Tag', 'Kout');
    set(Kout, 'Data', {'', '', ''; '', '', ''; '', '', ''})

    set(pt1x, 'String', tx1)
    set(pt1y, 'String', ty1)
    

end

end 








