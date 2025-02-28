function [phase] = goToPhase( phase, ax )

global gdeData4J
%% Gets access to the UI components to update them 
fig = get(ax, 'Parent');

gde = findobj(0, 'Tag', 'fig2');
msg = findobj(gde, 'Tag', 'msg');

pt1x = findobj(fig, 'Tag', 'pt1x');
pt1y = findobj(fig, 'Tag', 'pt1y');
pt2x = findobj(fig, 'Tag', 'pt2x');
pt2y = findobj(fig, 'Tag', 'pt2y');

if phase == 7 
    set(msg, 'String', gdeData4J.msg7)
    set(msg, 'FontSize', 0.04)
end


if phase < 7
    %%
    delete(findall(ax,'tag','N7'));
    delete(findall(ax,'tag','L4'));

    delete(findall(ax,'tag','J1'));
    delete(findall(ax,'tag','J2'));
    delete(findall(ax,'tag','J3'));
    delete(findall(ax,'tag','J4'));
    delete(findall(ax,'tag','link1'));
    delete(findall(ax,'tag','link2'));
    delete(findall(ax,'tag','link3'));
    delete(findall(ax,'tag','link4'));


    delete(findall(ax,'tag','P4'));
    
    figh = get(ax,'parent');
    jh = findobj(figh,'tag','jout');
    jout = get(jh,'Data');
    cx = jout{1,1};
    cy = jout{2,1};
    jout = {cx,'','','','',;cy,'','','',''};
    set(jh,'Data',jout);

    l = 1;
    while l < 5
        comp = findobj(fig, 'Tag', ['comp' num2str(l)]);
        set(comp, 'String', '')
        l = l + 1;
    end

    Cout = findobj(fig, 'Tag', 'Cout');
    set(Cout, 'Data', {'', '', ''; '', '', ''; '', '', ''})

    if phase == 6
        set(msg, 'String', gdeData4J.msg6)
        set(msg, 'FontSize', 0.04)
    end

    try
        [t3x,t3y] = calcTwist(ax, 'TwistThree');
        set(pt1x, 'Enable', 'off')
        set(pt1y, 'Enable', 'off')
        set(pt2x, 'Enable', 'on')
        set(pt2y, 'Enable', 'on')
        t3X = sprintf('%0.4f', t3x);
        t3Y = sprintf('%0.4f', t3y);
        set(pt1x, 'String', t3X)
        set(pt1y, 'String', t3Y)
        set(pt2x, 'String', '')
        set(pt2y, 'String', '')
        
    catch
    end
    
    
end

if phase < 6
    %%
    delete(findall(ax,'tag','N6'));
    delete(findall(ax,'tag','L3'));
    delete(findall(ax,'tag','P3'));

    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    if phase == 5
        set(msg, 'String', gdeData4J.msg5)
        set(msg, 'FontSize', 0.04)
    end


end

if phase < 5
    %%
    delete(findall(ax,'tag','N5'));
    
    if phase == 4
        set(msg, 'String', gdeData4J.msg4)
        set(msg, 'FontSize', 0.04)
    end
    set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')
end

if phase < 4
    %%
    delete(findall(ax,'tag','N3'));
    delete(findall(ax,'tag','L2'));
    delete(findall(ax,'tag','P2'));
    delete(findall(ax,'tag','V1'));

    try
        [t1x, t1y] = calcTwist(ax, 'TwistOne');
        set(pt1x, 'Enable', 'off')
        set(pt1y, 'Enable', 'off')
        t1X = sprintf('%0.4f', t1x);
        t1Y = sprintf('%0.4f', t1y);
        set(pt1x, 'String', t1X)
        set(pt1y, 'String', t1Y)
        set(pt2x, 'String', '')
        set(pt2y, 'String', '')
    catch
    end

    if phase == 3
        set(msg, 'String', gdeData4J.msg3)
        set(msg, 'FontSize', 0.04)
    end
    
end

if phase < 3
    %%
    delete(findall(ax,'tag','N2'));
    delete(findall(ax,'tag','L1'));
    delete(findall(ax,'tag','P1'));

    [n1x, n1y] = grabData('N1', ax);
    set(pt1x, 'String', n1x)
    set(pt1y, 'String', n1y)

    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    if phase == 2
        set(msg, 'String', gdeData4J.msg2)
        set(msg, 'FontSize', 0.04)
    end
end

if phase < 2
    %%
    delete(findall(ax,'tag','N1'));

    %Resets the x and y coordinate input boxes
    set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(msg, 'String', gdeData4J.msg1)
    set(msg, 'FontSize', 0.026)
end

end

