function [phase] = goToPhase( phase, ax )

global gdeData5S

%% Gets neccesary objects
fig = get(ax, 'Parent');
jx = findobj(fig, 'Tag', 'Jx');
jy = findobj(fig, 'Tag', 'Jy');

gde = findobj(0, 'Tag', 'fig2');
msg = findobj(gde, 'Tag', 'msg');

if phase < 9
    %%
    delete(findall(ax,'tag','N8'));
    delete(findall(ax,'tag','J1'));
    delete(findall(ax,'tag','J2'));
    delete(findall(ax,'tag','J3'));
    delete(findall(ax,'tag','J4'));
    
    delete(findall(ax,'tag','t1t'));
    delete(findall(ax,'tag','t1'));
    delete(findall(ax,'tag','t2t'));
    delete(findall(ax,'tag','t2'));
    delete(findall(ax,'tag','t3t'));
    delete(findall(ax,'tag','t3'));
    delete(findall(ax,'tag','t4t'));
    delete(findall(ax,'tag','t4'));
    delete(findall(ax,'tag','t5t'));
    delete(findall(ax,'tag','t5'));
    
    delete(findall(ax,'tag','J5'));
    jx.String = '';
    jy.String = '';

    set(msg, 'String', gdeData5S.msg7)
    
end

if phase == 7
    %%
    
    delete(findall(ax,'tag','PATCH'));
    delete(findall(ax,'tag','W1'));
    delete(findall(ax,'tag','W2'));
    delete(findall(ax,'tag','W3'));
    delete(findall(ax,'tag','W4'));
    calcIntersections(ax);
    jx.String = '';
    jy.String = '';
    
    
end

if phase < 7
    %%
    
    delete(findall(ax,'tag','PATCH'));
    delete(findall(ax,'tag','W1'));
    delete(findall(ax,'tag','W2'));
    delete(findall(ax,'tag','W3'));
    delete(findall(ax,'tag','W4'));
    
    delete(findall(ax,'tag','N6'));
    delete(findall(ax,'tag','L5'));
    jx.String = '';
    jy.String = '';


    l = 1;
    while l < 6
        lin = findobj(fig, 'Tag', ['lin' num2str(l)]);
        set(lin, 'String', '')

        wrench = findobj(fig, 'Tag', ['wrench' num2str(l)]);
        set(wrench, 'String', '')

        stiff = findobj(fig, 'Tag', ['stiff', num2str(l)]);
        set(stiff, 'String', '')
        
        l = l + 1;
    end

    Kout = findobj(fig, 'Tag', 'Kout');
    set(Kout, 'Data', {'', '', ''; '', '', ''; '', '', ''})

    if phase == 6
        set(msg, 'String', gdeData5S.msg6)
    end

    
end

if phase < 6
    %%
    
    delete(findall(ax,'tag','N5'));
    delete(findall(ax,'tag','V1'));
    delete(findall(ax,'tag','L4'));
    jx.String = '';
    jy.String = '';

    if phase == 5
        set(msg, 'String', gdeData5S.msg5)

    end
    
end

if phase < 5
    %%
    jx.String = '';
    jy.String = '';

    if phase == 4
        set(msg, 'String', gdeData5S.msg4)
    end
   
end

if phase < 4
    %%
    delete(findall(ax, 'Tag', 'P3'));
    delete(findall(ax,'tag','N4'));
    delete(findall(ax,'tag','L3'));
    delete(findall(ax,'tag','N3'));
    jx.String = '';
    jy.String = '';

    if phase == 3
        set(msg, 'String', gdeData5S.msg3)
    
    end
end

if phase < 3
    %%
    delete(findall(ax,'tag','N2'));
    delete(findall(ax,'tag','L2'));
    jx.String = '';
    jy.String = '';

    if phase == 2 
        set(msg, 'String', gdeData5S.msg2)
    end
end

if phase < 2
    %%
    delete(findall(ax,'tag','L1'));
    delete(findall(ax,'tag','N1'));
    jx.String = '';
    jy.String = '';

    set(msg, 'String', gdeData5S.msg1)
end

end

