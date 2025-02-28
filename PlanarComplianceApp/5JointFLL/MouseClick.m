function MouseClick( obj, ~, ax )

global C phase dragN ll
tag = get(obj, 'Tag');
fig = get(ax, 'Parent');
[x, y] = getCurrentXY(ax);


xlim = get(ax, 'xlim');
ylim = get(ax, 'ylim');

if x < xlim(1) || x > xlim(2) || y < ylim(1) || y > ylim(2)
    return
end

if strcmp(get(obj, 'type'), 'figure')
    if phase > 1 && phase < 5
        updateUI(x, y, ax, C, phase);
        phase = goToPhase(phase + 1, ax);

    elseif phase == 5
        updateUI(x, y, ax, C, phase);
        [~, ~, ~, ~, ~, ec6] = checkConditions(ax, C, phase, ll);
        if ec6 == 1
            phase = goToPhase(5, ax);
            return
        end
        phase = goToPhase(6, ax);

    elseif phase > 5
        updateUI(x, y, ax, C, phase);
        phase = goToPhase(phase + 1, ax);

    end
end

if strcmp(tag, 'J1')
    dragN(1) = 1;
    phase = goToPhase(3, ax);

elseif strcmp(tag, 'P1')
    dragN(2) = 1;
    phase = goToPhase(4, ax);

elseif strcmp(tag, 'P2')
    dragN(3) = 1;
    phase = goToPhase(6, ax);

end

end