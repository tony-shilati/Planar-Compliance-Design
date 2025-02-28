function [] = MouseRelease(~, ~, ax)

global dragN dragL phase Ps


if phase == 17
    if dragN(11) == 1 || dragN(12) == 1
        fig = findobj(0, 'Tag', 'fig');
        delete(findobj(ax, 'Tag', 'crc11'))
        delete(findobj(ax, 'Tag', 'crc13'))
    
        [cx, cy] = grabData('P2', ax);
        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        rf2 = norm(ll_data(2,:), 1);
        drawCircle(ax, rf2, cx, cy, 'crcf2', 0)
        r23 = ll_data(2,3);
        drawCircle(ax, r23, cx, cy, 'crc23', 1)
    end
    
end

if phase == 20
    if dragN(14) == 1 || dragN(15) == 1
        fig = findobj(0, 'Tag', 'fig');
        delete(findobj(ax, 'Tag', 'crc21'))
        delete(findobj(ax, 'Tag', 'crc23'))
    
        [cx, cy] = grabData('P3', ax);
        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        rf3 = norm(ll_data(3,:), 1);
        drawCircle(ax, rf3, cx, cy, 'crcf3', 0)
        r33 = ll_data(3,3);
        drawCircle(ax, r33, cx, cy, 'crc33', 1)
    end
    
end

if phase == 23
    if dragN(17) == 1 || dragN(18) == 1
        delete(findobj(ax, 'Tag', 'crc31'))
        delete(findobj(ax, 'Tag', 'crc33'))

        delete(findobj(ax, 'Tag', 'rho'))
        delete(findobj(ax, 'Tag', 'l'))
   
    end
    
end




dragN = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
dragL = [0;0;0;0;0;0];

end