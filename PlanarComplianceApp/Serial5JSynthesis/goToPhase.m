function [phase] = goToPhase(phase, ax)

global gdeData5J

%% Gets the neccesary objects
fig = get(ax, 'Parent');

gde = findobj(0, 'Tag', 'fig2');
msg = findobj(gde, 'Tag', 'msg');

pt1x = findobj(fig, 'Tag', 'pt1x');
pt1y = findobj(fig, 'Tag', 'pt1y');
pt2x = findobj(fig, 'Tag', 'pt2x');
pt2y = findobj(fig, 'Tag', 'pt2y');


if phase < 10
    %%
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

end

if phase < 9
    %%

    delete(findall(ax, 'Tag', 'text'))

    delete(findobj(ax, 'Tag', 'J1'))
    delete(findobj(ax, 'Tag', 'J2'))
    delete(findobj(ax, 'Tag', 'J3'))
    delete(findobj(ax, 'Tag', 'J4'))
    delete(findobj(ax, 'Tag', 'J5'))

    delete(findobj(ax, 'Tag', 'link1'))
    delete(findobj(ax, 'Tag', 'link2'))
    delete(findobj(ax, 'Tag', 'link3'))
    delete(findobj(ax, 'Tag', 'link4'))

    jout = findobj(fig, 'Tag', 'jout');
    jout2 = findobj(fig, 'Tag', 'jout2');
    jout.Data{1,2} = ''; jout.Data{1,3} = '';
    jout.Data{2,2} = ''; jout.Data{2,3} = '';
    set(jout2, 'Data', {'', '', ''; '', '', ''})
    set(findobj(fig, 'Tag', 'Cout'), 'Data', {'', '', ''; '', '', ''; '', '', ''})

    set(findobj(fig, 'Tag', 'comp1'), 'String', '') 
    set(findobj(fig, 'Tag', 'comp2'), 'String', '') 
    set(findobj(fig, 'Tag', 'comp3'), 'String', '') 
    set(findobj(fig, 'Tag', 'comp4'), 'String', '') 
    set(findobj(fig, 'Tag', 'comp5'), 'String', '') 
    
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')


    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

    delete(findobj(ax, 'Tag', 'N7'))
    delete(findobj(ax, 'Tag', 'L4'))

    if phase == 8 
        set(msg, 'String', gdeData5J.msg8)
    end


end

if phase < 8 
    %%
    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')

    delete(findobj(ax, 'Tag', 'P4'))
    delete(findobj(ax, 'Tag', 'P6P'))
    delete(findobj(ax, 'Tag', 'PL'))
    delete(findobj(ax, 'Tag', 'L3'))

    if phase == 7
        set(msg, 'String', gdeData5J.msg7)
    end

end

if phase < 7 
    %%
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

    delete(findobj(ax, 'Tag', 'N5'))

    if phase == 6
        set(msg, 'String', gdeData5J.msg6)
    end

end

if phase < 6
    %%
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt2x, 'Enable', 'off')
    set(pt2y, 'Enable', 'off')

    delete(findobj(ax, 'Tag', 'P3'))
    
    if phase == 5
        set(msg, 'String', gdeData5J.msg5)
    end

end

if phase < 5
    %%
    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')

    delete(findobj(ax, 'Tag', 'N4'))
    delete(findobj(ax, 'Tag', 'L2'))
    delete(findobj(ax, 'Tag', 'P2'))

    if phase == 4
        set(msg, 'String', gdeData5J.msg4)
    end

end

if phase < 4
    %%
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

    delete(findobj(ax, 'Tag', 'N3'))

    if phase == 3
        set(msg, 'String', gdeData5J.msg3)
    end


end

if phase < 3
    %%
    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')

    delete(findobj(ax, 'Tag', 'N2'))
    delete(findobj(ax, 'Tag', 'P1'))
    delete(findobj(ax, 'Tag', 'L1'))

    if phase == 2
        set(msg, 'String', gdeData5J.msg2)
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

    delete(findobj(ax, 'Tag', 'N1'))

    set(msg, 'String', gdeData5J.msg1)


end


end