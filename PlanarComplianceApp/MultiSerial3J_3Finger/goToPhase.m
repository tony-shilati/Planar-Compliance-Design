function [phase] = goToPhase(phase, ax)

global gdeData3J_3Finger V3J_3F
%% Gets neccesary objects
fig = get(ax, 'Parent');
pt1x = findobj(fig, 'Tag', 'pt1x');
pt1y = findobj(fig, 'Tag', 'pt1y');
pt2x = findobj(fig, 'Tag', 'pt2x');
pt2y = findobj(fig, 'Tag', 'pt2y');


gde = findobj(0, 'Tag', 'fig2');
msg = findobj(gde, 'Tag', 'msg');
%% Phase change conditions

if phase >= 12
    if phase < 23
        %%
        delete(findobj(fig, 'Tag', 'F3J3'))
        
        delete(findobj(fig, 'Tag', 'F3L1'))
        delete(findobj(fig, 'Tag', 'F3L2'))
        delete(findobj(fig, 'Tag', 'F3L3'))
    
        set(pt2x, 'String', '')
        set(pt2y, 'String', '')
    
        set(findobj(fig, 'Tag', 'jout3'), 'Data', {'', '', ''; '', '', ''})
    
    
    end
    
    
    if phase < 22
        %%
        delete(findobj(fig, 'Tag', 'F3J2'))
        delete(findobj(fig, 'Tag', 'crc32'))
        delete(findobj(fig, 'Tag', 'F3J31'))
        delete(findobj(fig, 'Tag', 'F3J32'))
    
        set(pt2x, 'String', '')
        set(pt2y, 'String', '')
    
    end
    
    if phase < 21
        %%
        delete(findobj(fig, 'Tag', 'F3J1'))
        delete(findobj(fig, 'Tag', 'crc31'))
        delete(findobj(fig, 'Tag', 'rho3'))
        delete(findobj(fig, 'Tag', 'l3'))
    
        set(pt2x, 'String', '')
        set(pt2y, 'String', '')
    end
    
    
    if phase < 20
        %% 
    
        delete(findobj(fig, 'Tag', 'crcf3'))
        delete(findobj(fig, 'Tag', 'crc33'))
    
        delete(findobj(fig, 'Tag', 'F2J3'))
    
        delete(findobj(fig, 'Tag', 'F2L1'))
        delete(findobj(fig, 'Tag', 'F2L2'))
        delete(findobj(fig, 'Tag', 'F2L3'))
    
        set(pt2x, 'String', '')
        set(pt2y, 'String', '')
    
        set(findobj(fig, 'Tag', 'jout2'), 'Data', {'', '', ''; '', '', ''})
    
    
    end
    
    if phase < 19
        %%
        delete(findobj(fig, 'Tag', 'F2J2'))
        delete(findobj(fig, 'Tag', 'crc22'))
        delete(findobj(fig, 'Tag', 'F2J31'))
        delete(findobj(fig, 'Tag', 'F2J32'))
    
        delete(findobj(fig, 'Tag', 'F2L1'))
        delete(findobj(fig, 'Tag', 'F2L2'))
        delete(findobj(fig, 'Tag', 'F2L3'))
    
        set(pt2x, 'String', '')
        set(pt2y, 'String', '')
    
    
    end
    
    if phase < 18
        %%
        delete(findobj(fig, 'Tag', 'F2J1'))
        delete(findobj(fig, 'Tag', 'crc21'))
    
        delete(findobj(fig, 'Tag', 'rho2'))
        delete(findobj(fig, 'Tag', 'l2'))
    
        set(pt2x, 'String', '')
        set(pt2y, 'String', '')
    
    end
    
    if phase < 17
        %% 
    
        delete(findobj(fig, 'Tag', 'crcf2'))
        delete(findobj(fig, 'Tag', 'crc23'))
    
        delete(findobj(fig, 'Tag', 'F1J3'))
    
        delete(findobj(fig, 'Tag', 'F1L1'))
        delete(findobj(fig, 'Tag', 'F1L2'))
        delete(findobj(fig, 'Tag', 'F1L3'))
    
        set(pt2x, 'String', '')
        set(pt2y, 'String', '')
    
        
       set(findobj(fig, 'Tag', 'jout1'), 'Data', {'', '', '', ''; '', '', '', ''})
       data = {'', '', ''; '', '', ''; '', '', ''};
       set(findobj(fig, 'Tag', 'cout1'), 'Data', data)
    
    
    end
    
    if phase < 16
        %%
        delete(findobj(fig, 'Tag', 'F1J2'))
        delete(findobj(fig, 'Tag', 'crc12'))
        delete(findobj(fig, 'Tag', 'F1J31'))
        delete(findobj(fig, 'Tag', 'F1J32'))
    
        set(pt2x, 'String', '')
        set(pt2y, 'String', '')
    
        
    end
    
    
    if phase < 15
        %%
        delete(findobj(fig, 'Tag', 'F1J1'))
        delete(findobj(fig, 'Tag', 'crc11'))
        delete(findobj(fig, 'Tag', 'rho1'))
        delete(findobj(fig, 'Tag', 'l1'))
    
        set(pt2x, 'String', '')
        set(pt2y, 'String', '')
    
        
    end
    
    
    if phase < 14
        %%
        delete(findobj(fig, 'Tag', 'crcf1'))
        delete(findobj(fig, 'Tag', 'crc13'))
    
        if phase == 13
            Visibility(ax, 0, 1, 2, 2, 2, 2)
            Clear_string(ax, 0, 0, 0, 2, 0, 2, 2)
        end
    
    end
    
    
    
    if phase < 13
        %%
        set(findobj(fig, 'Tag', 'J1C'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'J2C'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'J3C'), 'Visible', 'off')

        if phase == 12
            
        end
    
    
    end
end




if phase < 12
    %%

    if phase == 11
        Visibility(ax, 1, 0, 1, 0, 1, 2)
        Clear_string(ax, 0, 0, 0, 1, 0, 0, 1)
        
        %Change the guide message
        set(msg, 'String', gdeData3J_3Finger.msg11)

    end

end



if phase < 11
    %%

    Clear_string(ax, 1, 0, 1, 1, 1, 1, 0)
    Visibility(ax, 2, 2, 2, 2, 0, 2)


    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')
    delete(findobj(fig, 'Tag', 'N6'))
    delete(findobj(fig, 'Tag', 'L6'))


    if phase == 10
        set(msg, 'String', gdeData3J_3Finger.msg10)

    end
end

if phase < 10
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

    if phase == 9
        set(msg, 'String', gdeData3J_3Finger.msg9)

    end


end

if phase < 9
    %%
    delete(findobj(fig, 'Tag', 'P3'))
    delete(findobj(ax, 'Tag', 'text3'))

    if phase == 8
        set(msg, 'String', gdeData3J_3Finger.msg8)

    end

end

if phase < 8
    %%
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')

    delete(findobj(fig, 'Tag', 'N4'))
    delete(findobj(fig, 'Tag', 'L4'))
    delete(findobj(fig, 'Tag', 'QuadCurve'))

    [p2x, p2y] = grabData('P2', ax);
    p2X = sprintf('%0.3f', p2x);
    p2Y = sprintf('%0.3f', p2y);
    set(pt1x, 'String', p2X)
    set(pt1y, 'String', p2Y)

    if phase == 7
        set(msg, 'String', gdeData3J_3Finger.msg7)

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

    delete(findobj(fig, 'Tag', 'N3'))
    delete(findobj(fig, 'Tag', 'L3'))

    if phase == 6
        set(msg, 'String', gdeData3J_3Finger.msg6)

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

    delete(findobj(fig, 'Tag', 'N2'))
    delete(findobj(fig, 'Tag', 'L2'))

    [p1x, p1y] = grabData('P1', ax);
    p1X = sprintf('%0.3f', p1x);
    p1Y = sprintf('%0.3f', p1y);
    set(pt1x, 'String', p1X)
    set(pt1y, 'String', p1Y)

    if phase == 5
        set(msg, 'String', gdeData3J_3Finger.msg5)

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

    delete(findobj(fig, 'Tag', 'N1'))
    delete(findobj(fig, 'Tag', 'L1'))

    if phase == 4
        set(msg, 'String', gdeData3J_3Finger.msg4)

    end

end

if phase < 4
    %%
    set(pt1x, 'Enable', 'off')
    set(pt1y, 'Enable', 'off')
    delete(findobj(ax, 'Tag', 'P2'))
    delete(findobj(ax, 'Tag', 'text2'))

    if phase == 3
        set(msg, 'String', gdeData3J_3Finger.msg3)

    end

end


if phase < 3
    %%
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')
    set(pt2x, 'String', '')
    set(pt2y, 'String', '')

    set(pt1x, 'Enable', 'on')
    set(pt1y, 'Enable', 'on')
    set(pt2x, 'Enable', 'on')
    set(pt2y, 'Enable', 'on')
    
    delete(findobj(ax, 'Tag', 'P1'))
    delete(findobj(ax, 'Tag', 'text1'))

    K = double(get(findobj(fig, 'Tag', 'table'), 'Data'));
    stiffnessCenter(K, ax);

    
    if phase == 2 
        set(msg, 'String', gdeData3J_3Finger.msg2)

    end

end


if phase < 2
    %%

    set(pt2x, 'Enable', 'off')
    set(pt2y, 'Enable', 'off')
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')

    V3J_3F.x = [];
    V3J_3F.y = [];
    
    set(msg, 'String', gdeData3J_3Finger.msg1)

    fin = findobj(fig, 'Tag', 'Finish');
    set(fin, 'Visible', 'on')

    delete(get(ax, 'Children'))
    scatter(0,0,'+','markerfacecolor',[0 0 0],'sizedata',120,'markeredgecolor',[0 0 0]);


end

end