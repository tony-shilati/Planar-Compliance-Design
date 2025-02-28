function Visibility(ax, point_io, link_io, spring_info, comp_info, curve_info, sep_cond)
% 0 = off
% 1 = on
%anything larger than 1 will cause the program to do nothing to that gui
%component

fig = get(ax, 'Parent');

 
%% Inputs for point locations 
if point_io == 0
    set(findobj(fig, 'Tag', 'pt1x'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'pt1y'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'pt2x'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'pt2y'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'Pt1L'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'Pt2L'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'XL'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'YL'), 'Visible', 'off')

elseif point_io == 1
    set(findobj(fig, 'Tag', 'pt1x'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'pt1y'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'pt2x'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'pt2y'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'Pt1L'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'Pt2L'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'XL'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'YL'), 'Visible', 'on')

else

end

%% inputs for links
if link_io == 0
    set(findobj(fig, 'Tag', 'LenTable'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'LenLab'), 'Visible', 'off')

elseif link_io == 1
    set(findobj(fig, 'Tag', 'LenTable'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'LenLab'), 'Visible', 'on')

else

end

%% Stiffness info
if spring_info == 0
    set(findobj(fig, 'Tag', 'linLab'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'wrenchLab'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'stiffLab'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'Klab'), 'Visible', 'off')

    l=1;
    while l < 7                                                                    
        set(findobj(fig, 'Tag', ['lin' num2str(l) 'Lab']), 'Visible', 'off')
        set(findobj(fig, 'Tag', ['lin' num2str(l)]), 'Visible', 'off')
    
        set(findobj(fig, 'Tag', ['stiff' num2str(l)]), 'Visible', 'off')
        set(findobj(fig, 'Tag', ['stiff' num2str(l) 'Lab']), 'Visible', 'off')
    
        set(findobj(fig, 'Tag', ['wrench' num2str(l)]), 'Visible', 'off')
        set(findobj(fig, 'Tag', ['wrench' num2str(l) 'Lab']), 'Visible', 'off')

        l = l + 1;
    end

elseif spring_info == 1
    set(findobj(fig, 'Tag', 'linLab'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'wrenchLab'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'stiffLab'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'Klab'), 'Visible', 'on')

    l=1;
    while l < 7                                                                    
        %Turn off the neccesary output boxes and their labels
        set(findobj(fig, 'Tag', ['lin' num2str(l) 'Lab']), 'Visible', 'on')
        set(findobj(fig, 'Tag', ['lin' num2str(l)]), 'Visible', 'on')
    
        set(findobj(fig, 'Tag', ['stiff' num2str(l)]), 'Visible', 'on')
        set(findobj(fig, 'Tag', ['stiff' num2str(l) 'Lab']), 'Visible', 'on')
    
        set(findobj(fig, 'Tag', ['wrench' num2str(l)]), 'Visible', 'on')
        set(findobj(fig, 'Tag', ['wrench' num2str(l) 'Lab']), 'Visible', 'on')

        l = l + 1;
    end

else

end

%% compliance info
if comp_info == 0
    set(findobj(fig, 'Tag', 'compLab'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'cout1'), 'Visible', 'off')

    i = 1;
    while i < 4
        set(findobj(fig, 'Tag', ['jout' num2str(i)]), 'Visible', 'off')
        set(findobj(fig, 'Tag', ['jlab' num2str(i)]), 'Visible', 'off')

        i=i+1;
    end

elseif comp_info == 1
    set(findobj(fig, 'Tag', 'compLab'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'cout1'), 'Visible', 'on')

    i = 1;
    while i < 4
        set(findobj(fig, 'Tag', ['jout' num2str(i)]), 'Visible', 'on')
        set(findobj(fig, 'Tag', ['jlab' num2str(i)]), 'Visible', 'on')
        
        i=i+1;
    end

else

end


%% Input boxes at top of Gui that controls which curve is being shown 
if curve_info == 0
    set(findobj(fig, 'Tag', 'ent1lab'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'ent2lab'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'ent1'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'ent2'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'cvt'), 'Visible', 'off')

elseif curve_info == 1
    set(findobj(fig, 'Tag', 'ent1lab'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'ent2lab'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'ent1'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'ent2'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'cvt'), 'Visible', 'on')

else

end

%% Seperation condition buttons

if sep_cond == 0
    set(findobj(fig, 'Tag', 'J1C'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'J2C'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'J3C'), 'Visible', 'off')

elseif sep_cond == 1
    set(findobj(fig, 'Tag', 'J1C'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'J2C'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'J3C'), 'Visible', 'on')

end

end