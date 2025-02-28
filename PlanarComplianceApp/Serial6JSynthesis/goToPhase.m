function [phase] = goToPhase(phase, ax)

global gdeData6J
%% Gets neccesary objects
fig = get(ax, 'Parent');
pt1x = findobj(fig, 'Tag', 'pt1x');
pt1y = findobj(fig, 'Tag', 'pt1y');
pt2x = findobj(fig, 'Tag', 'pt2x');
pt2y = findobj(fig, 'Tag', 'pt2y');

gde = findobj(0, 'Tag', 'fig2');
msg = findobj(gde, 'Tag', 'msg');


if phase < 9
    %%
    delete(findall(ax, 'Tag', 'text1'))
    delete(findall(ax, 'Tag', 'text2'))
    delete(findall(ax, 'Tag', 'text3'))
    delete(findall(ax, 'Tag', 'text4'))
    delete(findall(ax, 'Tag', 'text5'))
    delete(findall(ax, 'Tag', 'text6'))
    delete(findobj(ax, 'Tag', 'J6'))
    Cout = findobj(fig, 'Tag', 'Cout');
    set(Cout, 'Data', {'', '', ''; '', '', ''; '', '', ''})

    
    set(findobj(fig, 'Tag', 'comp1'), 'String', '')
    set(findobj(fig, 'Tag', 'comp2'), 'String', '')
    set(findobj(fig, 'Tag', 'comp3'), 'String', '')
    set(findobj(fig, 'Tag', 'comp4'), 'String', '')
    set(findobj(fig, 'Tag', 'comp5'), 'String', '')
    set(findobj(fig, 'Tag', 'comp6'), 'String', '')


    delete(findobj(ax, 'Tag', 'C1')); delete(findobj(ax, 'Tag', 'C2'));
    delete(findobj(ax, 'Tag', 'C3')); delete(findobj(ax, 'Tag', 'C4'));
    delete(findobj(ax, 'Tag', 'C5'));

    delete(findobj(ax, 'Tag', 'D1')); delete(findobj(ax, 'Tag', 'D2'));
    delete(findobj(ax, 'Tag', 'D3')); delete(findobj(ax, 'Tag', 'D4'));

    if phase == 8 
        set(msg, 'String', gdeData6J.msg8)

    end

end


if phase < 8
    %%
   set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt2x, 'Enable', 'off')
    set(pt2y, 'Enable', 'off')
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')

    delete(findobj(ax, 'Tag', 'J5'))

    if phase == 7
        set(msg, 'String', gdeData6J.msg7)

    end

end


if phase < 7
    %%
    set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt2x, 'Enable', 'off')
    set(pt2y, 'Enable', 'off')
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')

    delete(findobj(ax, 'Tag', 'J4')) 
    delete(findobj(ax, 'Tag', 'QuadCurve'))

    if phase == 6
        set(msg, 'String', gdeData6J.msg6)
    end

end

if phase < 6
    %%
    set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt2x, 'Enable', 'off')
    set(pt2y, 'Enable', 'off')
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')

    delete(findobj(ax, 'Tag', 'J3'))

    if phase == 5
        [l2x, l2y] = grabData('L2', ax);
        m2 = (l2y(1) - l2y(2)) / (l2x(1) - l2x(2));
        b2 = l2y(1) - m2*l2x(1);
        M2 = sprintf('%0.3f', m2);
        B2 = sprintf('%0.3f', b2);

        set(msg, 'String', gdeData6J.msg5)
    end

end


if phase < 5
    %%
    set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt2x, 'Enable', 'off')
    set(pt2y, 'Enable', 'off')
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')

    delete(findobj(ax, 'Tag', 'J2'))

    if phase == 4
        [l1x, l1y] = grabData('L1', ax);
        m1 = (l1y(1) - l1y(2)) / (l1x(1) - l1x(2));
        b1 = l1y(1) - m1*l1x(1);
        M1 = sprintf('%0.3f', m1);
        B1 = sprintf('%0.3f', b1);

        set(msg, 'String', gdeData6J.msg4)
    end
end

if phase < 4
    %%
    set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt2x, 'Enable', 'off')
    set(pt2y, 'Enable', 'off')

    set(pt1x, 'String', '')
    set(pt1y, 'String', '')
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    delete(findobj(ax, 'Tag', 'J1'))
    delete(findobj(ax, 'Tag', 'N4'))
    delete(findobj(ax, 'Tag', 'L2'))
    delete(findobj(ax, 'Tag', 'P2'))

    if phase == 3
        set(msg, 'String', gdeData6J.msg3)

    end
end


if phase < 3
    %%
    set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

    set(pt1x, 'String', '')
    set(pt1y, 'String', '')
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    delete(findobj(ax, 'Tag', 'N3'))

    if phase == 2
        set(msg, 'String', gdeData6J.msg2)
    end
end


if phase < 2
    %%
    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')
    set(pt1y, 'String', '0')
    set(pt1x, 'String', '0')

    delete(findobj(ax, 'Tag', 'N2'))
    delete(findobj(ax, 'Tag', 'L1'))
    delete(findobj(ax, 'Tag', 'P1'))

    set(msg, 'String', gdeData6J.msg1)

end


end