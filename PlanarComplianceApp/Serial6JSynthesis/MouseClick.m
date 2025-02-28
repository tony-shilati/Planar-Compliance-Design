function [] = MouseClick(obj, ~, ax)

global phase C dragN dragL

tag = get(obj, 'Tag');
[x, y] = getCurrentXY(ax);

xlim = get(ax, 'xlim');
ylim = get(ax, 'ylim');

if x < xlim(1) || x > xlim (2) || y < ylim(1) || y > ylim(2)
    return
end

if strcmp(get(obj, 'type'), 'figure')
    if phase < 4
        UpdateUI(ax, C, x, y, phase)

        if phase == 3
            ec1 = checkConditions(ax, C, phase);
            if ec1 == 1 
                phase = goToPhase(2, ax);
                return
            end
        end

        phase = phase + 1; goToPhase(phase, ax);
              

    elseif phase > 6
        UpdateUI(ax, C, x, y, phase)

        if phase == 8
            checkConditions(ax, C, phase);
        end

        phase = phase + 1; goToPhase(phase, ax);
    end

elseif strcmp(tag, 'N2')
    dragN(2) = 1;

elseif strcmp(tag, 'N3')
    dragN(3) = 1;

elseif strcmp(tag, 'N4')
    dragN(4) = 1;

elseif strcmp(tag, 'J2')
    dragN(5) = 1;

elseif strcmp(tag, 'J3')
    dragN(6) = 1;
    if phase == 6
        phase = goToPhase(5, ax);
    end

elseif strcmp(tag, 'J4')
    dragN(7) = 1;

elseif strcmp(tag, 'J5')
    dragN(8) = 1;  

elseif strcmp(tag, 'J6')
    dragN(9) = 1;

elseif strcmp(tag, 'L1')
    if phase == 4
        UpdateUI(ax, C, x, y, phase)
        phase = phase + 1; goToPhase(phase, ax);
    else
        dragL(1) = 1;
        phase = goToPhase(phase-1, ax);
    end

elseif strcmp(tag, 'L2')
    if phase == 5 || phase == 6
        UpdateUI(ax, C, x, y, phase)
        phase = phase + 1; goToPhase(phase, ax);
        
    else 
        dragL(2) = 1;
    end

elseif strcmp(tag, 'D1') || strcmp(tag, 'D2') || strcmp(tag, 'D3') || strcmp(tag, 'D4')
    delete(findobj(ax, 'Tag', 'D1'))
    delete(findobj(ax, 'Tag', 'D2'))
    delete(findobj(ax, 'Tag', 'D3'))
    delete(findobj(ax, 'Tag', 'D4'))


end

end