function Clear_string(ax, point1_io, point2_io, link_io, spring_info, comp_info, curve_info, stiff_out)
% 0 = clear
% 1 = do nothing

fig = get(ax, 'Parent');

%% point 1 X-Y inputs
if point1_io == 0
    set(findobj(fig, 'Tag', 'pt1x'), 'String', '')
    set(findobj(fig, 'Tag', 'pt1y'), 'String', '')

else

end

%% Point 2 X-Y inputs
if point2_io == 0
    set(findobj(fig, 'Tag', 'pt2x'), 'String', '')
    set(findobj(fig, 'Tag', 'pt2y'), 'String', '')

else

end

%% Link length inputs
if link_io == 0
    data = {'', '', ''; '', '', ''; '', '', ''};
    set(findobj(fig, 'Tag', 'LenTable'), 'Data', data)

else

end

%% Spring outputs

if spring_info == 0
    l=1;
    while l < 7
        set(findobj(fig, 'Tag', ['lin' num2str(l)]), 'String', '')
        set(findobj(fig, 'Tag', ['stiff' num2str(l)]), 'String', '')
        set(findobj(fig, 'Tag', ['wrench' num2str(l)]), 'String', '')

        l = l + 1;
    end


else

end

%% Compliance outputs

if comp_info == 0
    data = {'', '', ''; '', '', ''; '', '', ''};
    set(findobj(fig, 'Tag', 'cout1'), 'Data', data)

    set(findobj(fig, 'Tag', 'jout1'), 'Data', {'', '', '', ''; '', '', '', ''})
    set(findobj(fig, 'Tag', 'jout2'), 'Data', {'', '', ''; '', '', ''})
    set(findobj(fig, 'Tag', 'jout3'), 'Data', {'', '', ''; '', '', ''})
    
else

end

%% curve info

if curve_info == 0
    set(findobj(fig, 'Tag', 'ent1'), 'String', '')
    set(findobj(fig, 'Tag', 'ent2'), 'String', '')

else

end

%% Stiffness matrix output

if stiff_out == 0
    data = {'', '', ''; '', '', ''; '', '', ''};
    set(findobj(fig, 'Tag', 'Kout'), 'Data', data)

else

end


end