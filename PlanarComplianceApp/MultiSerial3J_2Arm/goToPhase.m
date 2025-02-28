function [phase] = goToPhase(phase, ax)

global gdeData3J_2Arm
%% Gets neccesary objects
fig = get(ax, 'Parent');
pt1x = findobj(fig, 'Tag', 'pt1x');
pt1y = findobj(fig, 'Tag', 'pt1y');
pt2x = findobj(fig, 'Tag', 'pt2x');
pt2y = findobj(fig, 'Tag', 'pt2y');


gde = findobj(0, 'Tag', 'fig2');
msg = findobj(gde, 'Tag', 'msg');

if phase < 12
    %%
    if phase == 11
        %Turn off the neccesary labels in the outputs box
        set(findobj(fig, 'Tag', 'linLab'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'wrenchLab'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'stiffLab'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'Klab'), 'Visible', 'off')
    
    
        %Turn on the neccesary labels and output boxes
        set(findobj(fig, 'Tag', 'compLab'), 'Visible', 'on')
        set(findobj(fig, 'Tag', 'jout'), 'Visible', 'on')
        set(findobj(fig, 'Tag', 'jout2'), 'Visible', 'on')
        set(findobj(fig, 'Tag', 'jlab'), 'Visible', 'on')

        l=1;
        while l < 7
        %Turn off the neccesary output boxes and their labels
        set(findobj(fig, 'Tag', ['lin' num2str(l) 'Lab']), 'Visible', 'off')
        set(findobj(fig, 'Tag', ['lin' num2str(l)]), 'Visible', 'off')
    
        set(findobj(fig, 'Tag', ['stiff' num2str(l)]), 'Visible', 'off')
        set(findobj(fig, 'Tag', ['stiff' num2str(l) 'Lab']), 'Visible', 'off')
    
        set(findobj(fig, 'Tag', ['wrench' num2str(l)]), 'Visible', 'off')
        set(findobj(fig, 'Tag', ['wrench' num2str(l) 'Lab']), 'Visible', 'off')
    
        %Turn on the neccesary output boxes and their labels
        set(findobj(fig, 'Tag', ['comp' num2str(l)]), 'Visible', 'on')
        set(findobj(fig, 'Tag', ['comp' num2str(l) 'Lab']), 'Visible', 'on')

        %Change the guide message
        set(msg, 'String', gdeData3J_2Arm.msg11)
    
        l = l + 1;
        end
        
    
        
    end


end


if phase < 11
    %%
    set(pt1x, 'Visible', 'on')
    set(pt1y, 'Visible', 'on')
    set(pt2x, 'Visible', 'on')
    set(pt2y, 'Visible', 'on')

    set(findobj(fig, 'Tag', 'Pt1L'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'Pt2L'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'XL'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'YL'), 'Visible', 'on')


    set(findobj(fig, 'Tag', 'g11'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'g12'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'g13'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'g21'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'g22'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'g23'), 'Visible', 'off')

    set(findobj(fig, 'Tag', 'g11'), 'String', '')
    set(findobj(fig, 'Tag', 'g12'), 'String', '')
    set(findobj(fig, 'Tag', 'g13'), 'String', '')
    set(findobj(fig, 'Tag', 'g21'), 'String', '')
    set(findobj(fig, 'Tag', 'g22'), 'String', '')
    set(findobj(fig, 'Tag', 'g23'), 'String', '')

    set(findobj(fig, 'Tag', 'grp1'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'grp2'), 'Visible', 'off')

    if phase == 10
         %Change the guide message
        set(msg, 'String', gdeData3J_2Arm.msg10)

    end

if phase < 10
    %%
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

    delete(findobj(fig, 'Tag', 'N6'))
    delete(findobj(fig, 'Tag', 'L6'))

    set(findobj(fig, 'Tag', 'ent1'), 'visible', 'off')
    set(findobj(fig, 'Tag', 'ent2'), 'visible', 'off')
    set(findobj(fig, 'Tag', 'ent1lab'), 'visible', 'off')
    set(findobj(fig, 'Tag', 'ent2lab'), 'visible', 'off')
    set(findobj(fig, 'Tag', 'cvt'), 'visible', 'off')

    l = 1;
    while l < 7
        set(findobj(fig, 'Tag', ['lin' num2str(l)]), 'String', '')
        set(findobj(fig, 'Tag', ['wrench' num2str(l)]), 'String', '')
        set(findobj(fig, 'Tag', ['stiff' num2str(l)]), 'String', '')

        l = l + 1;
    end

    Kout = findobj(fig, 'Tag', 'Kout');
    set(Kout, 'Data', {'', '', ''; '', '', ''; '', '', ''})

    if phase == 9
        set(msg, 'String', gdeData3J_2Arm.msg9)

    end
end

if phase < 9
    %%
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

    delete(findobj(fig, 'Tag', 'N5'))
    delete(findobj(fig, 'Tag', 'L5'))

    [p3x, p3y] = grabData('P3', ax);
    p3X = sprintf('%0.3f', p3x);
    p3Y = sprintf('%0.3f', p3y);
    set(pt1x, 'String', p3X)
    set(pt1y, 'String', p3Y)

    if phase == 8
        set(msg, 'String', gdeData3J_2Arm.msg8)

    end


end

if phase < 8
    %%
    delete(findobj(fig, 'Tag', 'P3'))
    delete(findobj(fig, 'Tag', 'QuadCurve'))
    delete(findobj(ax, 'Tag', 'text3'))

    if phase == 7
        set(msg, 'String', gdeData3J_2Arm.msg7)

    end

end

if phase < 7
    %%
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

    delete(findobj(fig, 'Tag', 'N4'))
    delete(findobj(fig, 'Tag', 'L4'))

    [p2x, p2y] = grabData('P2', ax);
    p2X = sprintf('%0.3f', p2x);
    p2Y = sprintf('%0.3f', p2y);
    set(pt1x, 'String', p2X)
    set(pt1y, 'String', p2Y)

    if phase == 6
        set(msg, 'String', gdeData3J_2Arm.msg6)

    end

end

if phase < 6
    %%
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

    delete(findobj(fig, 'Tag', 'N3'))
    delete(findobj(fig, 'Tag', 'L3'))

    if phase == 5
        set(msg, 'String', gdeData3J_2Arm.msg5)

    end

end

if phase < 5
    %%
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

    delete(findobj(fig, 'Tag', 'N2'))
    delete(findobj(fig, 'Tag', 'L2'))

    [p1x, p1y] = grabData('P1', ax);
    p1X = sprintf('%0.3f', p1x);
    p1Y = sprintf('%0.3f', p1y);
    set(pt1x, 'String', p1X)
    set(pt1y, 'String', p1Y)

    if phase == 4
        set(msg, 'String', gdeData3J_2Arm.msg4)

    end

end

if phase < 4
    %%
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

    delete(findobj(fig, 'Tag', 'N1'))
    delete(findobj(fig, 'Tag', 'L1'))

    if phase == 3
        set(msg, 'String', gdeData3J_2Arm.msg3)

    end

end

if phase < 3
    %%
    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')

    if phase == 2
        set(msg, 'String', gdeData3J_2Arm.msg2)

    end

end


if phase < 2
    %%
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

    

    set(msg, 'String', gdeData3J_2Arm.msg1)

end


end