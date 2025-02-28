function [phase] = goToPhase( phase, ax )

global gdeData4S
%% Get neccesarry Objects
fig = get(ax, 'Parent');
jx = findobj(fig, 'Tag', 'Jx');
jy = findobj(fig, 'Tag', 'Jy');

gde = findobj(0, 'Tag', 'fig2');
msg = findobj(gde, 'Tag', 'msg');


if phase == 6
    set(msg, 'String', gdeData4S.msg6)
end


if phase < 6
    %%
        delete(findall(ax,'tag','J1'));
        delete(findall(ax,'tag','J2'));
        delete(findall(ax,'tag','J3'));
        delete(findall(ax,'tag','J4'));
        
        delete(findall(ax,'tag','W1'));
        delete(findall(ax,'tag','W2'));
        delete(findall(ax,'tag','W3'));
        delete(findall(ax,'tag','W4'));
    
    
         delete(findall(ax,'tag','N5'));
         set(jx, 'String', '')
         set(jy, 'String', '')

         l = 1;
        while l < 5
            lin = findobj(fig, 'Tag', ['lin' num2str(l)]);
            set(lin, 'String', '')
    
            wren = findobj(fig, 'Tag', ['wrench' num2str(l)]);
            set(wren, 'String', '')
    
            stiff = findobj(fig, 'Tag', ['stiff', num2str(l)]);
            set(stiff, 'String', '')
            l = l+1;
        end 

        Kout = findobj(fig, 'Tag', 'Kout');
        set(Kout, 'Data', {'', '', ''; '', '', ''; '', '', ''})

         if phase == 5 
             set(msg, 'String', gdeData4S.msg5)
         end 
end

if phase < 5
    %%
    %     delete(findall(ax,'tag','N5'));
    delete(findall(ax,'tag','N4'));
    delete(findall(ax,'tag','L3'));
    delete(findall(ax,'tag','P3'));
    set(jx, 'String', '')
    set(jy, 'String', '')

    if phase == 4
        
        set(msg, 'String', gdeData4S.msg4)
    end

end

if phase < 4
    %%
    delete(findall(ax,'tag','N3'));
    set(jx, 'String', '')
    set(jy, 'String', '')

    if phase == 3
        
        set(msg, 'String', gdeData4S.msg3)
    end
    
end

if phase < 3
    %%
    delete(findall(ax,'tag','V1'));
    delete(findall(ax,'tag','N2'));
    delete(findall(ax,'tag','L2'));
    set(jx, 'String', '')
    set(jy, 'String', '')

    
    if phase == 2
            set(msg, 'String', gdeData4S.msg2)
    end
end

if phase < 2
    %%
    delete(findall(ax,'tag','N1'));
    delete(findall(ax,'tag','L1'));
    set(jx, 'String', '')
    set(jy, 'String', '')

   
    set(msg, 'String', gdeData4S.msg1)


end

end

