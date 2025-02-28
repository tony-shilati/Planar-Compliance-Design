function [phase] = goToPhase(phase, ax)

global gdeData5J_FLL
%% Gets the neccesary objects
fig = get(ax, 'Parent');

Jx = findobj(fig, 'Tag', 'Jx');
Jy = findobj(fig, 'Tag', 'Jy');

link1 = findobj(fig, 'Tag', 'link1');
link2 = findobj(fig, 'Tag', 'link2');
link3 = findobj(fig, 'Tag', 'link3');
link4 = findobj(fig, 'Tag', 'link4');

llink1 = findobj(fig, 'Tag', 'llink1');
llink2 = findobj(fig, 'Tag', 'llink2');
llink3 = findobj(fig, 'Tag', 'llink3');
llink4 = findobj(fig, 'Tag', 'llink4');

gde = findobj(0, 'Tag', 'fig2');
msg = findobj(gde, 'Tag', 'msg');

if phase < 8
    %%
    set(Jx, 'String', '')
    set(Jy, 'String', '')

    delete(findobj(ax, 'Tag', 'J5'))
    delete(findobj(ax, 'Tag', 'C1'))
    delete(findobj(ax, 'Tag', 'C2'))
    delete(findobj(ax, 'Tag', 'C3'))
    delete(findobj(ax, 'Tag', 'C4'))
    delete(findobj(ax, 'Tag', 'C5'))

    delete(findobj(ax, 'Tag', 'txt1'))
    delete(findobj(ax, 'Tag', 'txt2'))
    delete(findobj(ax, 'Tag', 'txt3'))
    delete(findobj(ax, 'Tag', 'txt4'))
    delete(findobj(ax, 'Tag', 'txt5'))

    delete(findall(ax, 'Tag', 't12'))
    delete(findall(ax, 'Tag', 't34'))

    set(findobj(fig, 'Tag', 'comp1'), 'String', '')
    set(findobj(fig, 'Tag', 'comp2'), 'String', '')
    set(findobj(fig, 'Tag', 'comp3'), 'String', '')
    set(findobj(fig, 'Tag', 'comp4'), 'String', '')
    set(findobj(fig, 'Tag', 'comp5'), 'String', '')

    set(findobj(fig, 'Tag', 'Cout'), 'Data', {'', '', ''; '', '', ''; '', '', ''})

end

    if phase == 7
        %%
        set(msg, 'String', gdeData5J_FLL.msg7)
    end


if phase < 7
    %%
    set(Jx, 'String', '')
    set(Jy, 'String', '')

    delete(findobj(ax, 'Tag', 'J3'))
    delete(findobj(ax, 'Tag', 'crc4'))
    delete(findobj(ax, 'Tag', 'L3'))
    delete(findobj(ax, 'Tag', 'J4'))
    delete(findobj(ax, 'Tag', 'crc5'))
    delete(findobj(ax, 'Tag', 'T5'))
    delete(findobj(ax, 'Tag', 'T6'))
    delete(findobj(ax, 'Tag', 'QuadCurve'))

    if phase == 6
        set(msg, 'String', gdeData5J_FLL.msg6)
    end

end

if phase < 6
    %%
    set(Jx, 'String', '')
    set(Jy, 'String', '')

    delete(findobj(ax, 'Tag', 'P2'))
    delete(findobj(ax, 'Tag', 'T3'))
    delete(findobj(ax, 'Tag', 'T4'))

    if phase == 5
        set(msg, 'String', gdeData5J_FLL.msg5)
    end


end

if phase < 5
    %%
    if phase == 4
        set(msg, 'String', gdeData5J_FLL.msg4)
    end

end
%%
if phase < 4
    %%
    set(Jx, 'String', '')
    set(Jy, 'String', '')

    delete(findobj(ax, 'Tag', 'P1'))
    delete(findobj(ax, 'Tag', 'L2'))
    delete(findobj(ax, 'Tag', 'J2'))
    delete(findobj(ax, 'Tag', 'crc3'))
    delete(findobj(ax, 'Tag', 'T2quad'))
    delete(findobj(ax, 'Tag', 'T7'))
    delete(findobj(ax, 'Tag', 'T8'))

    if phase == 3
        
        set(msg, 'String', gdeData5J_FLL.msg3)
    end


end

if phase < 3
    %%
    set(findobj(fig, 'Tag', 'llab'), 'Visible', 'off')
    set(link1, 'Visible', 'off')
    set(link2, 'Visible', 'off')
    set(link3, 'Visible', 'off')
    set(link4, 'Visible', 'off')

    set(llink1, 'Visible', 'off')
    set(llink2, 'Visible', 'off')
    set(llink3, 'Visible', 'off')
    set(llink4, 'Visible', 'off')

    set(Jx, 'visible', 'on')
    set(Jy, 'visible', 'on')
    set(findobj(fig, 'Tag', 'JX'), 'visible', 'on')
    set(findobj(fig, 'Tag', 'JY'), 'visible', 'on')

    set(Jx, 'String', '')
    set(Jy, 'String', '')

    delete(findobj(ax, 'Tag', 'J1'))
    delete(findobj(ax, 'Tag', 'crc1'))
    delete(findobj(ax, 'Tag', 'crc2'))
    delete(findobj(ax, 'Tag', 'L1'))

    if phase == 2
        set(msg, 'String', gdeData5J_FLL.msg2)
    end
    

end

if phase < 2
    %%
    set(findobj(fig, 'Tag', 'llab'), 'Visible', 'on')
    set(llink1, 'Visible', 'on')
    set(llink2, 'Visible', 'on')
    set(llink3, 'Visible', 'on')
    set(llink4, 'Visible', 'on')

    set(link1, 'String', '')
    set(link2, 'String', '')
    set(link3, 'String', '')
    set(link4, 'String', '')

    set(link1, 'Visible', 'on')
    set(link2, 'Visible', 'on')
    set(link3, 'Visible', 'on')
    set(link4, 'Visible', 'on')

    set(Jx, 'visible', 'off')
    set(Jy, 'visible', 'off')
    set(findobj(fig, 'Tag', 'JX'), 'visible', 'off')
    set(findobj(fig, 'Tag', 'JY'), 'visible', 'off')

    if phase == 1
        set(msg, 'String', gdeData5J_FLL.msg1)
    end

end



%% larger than ifs
if phase > 4
    delete(findobj(ax, 'Tag', 'crc2'))

end


if phase > 6
    delete(findobj(ax, 'Tag', 'crc3'))
    delete(findobj(ax, 'Tag', 'T2quad'))

end

if phase > 7
    delete(findobj(ax, 'Tag', 'crc5'))
    delete(findobj(ax, 'Tag', 'QuadCurve'))

end



end