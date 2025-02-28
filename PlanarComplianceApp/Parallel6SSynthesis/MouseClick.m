function [] = MouseClick(obj, ~, ax)

global phase dragN dragL K

[x, y] = getCurrentXY(ax);

xlim = get(ax, 'xlim');
ylim = get(ax, 'ylim');

if x < xlim(1) || x > xlim (2) || y < ylim(1) || y > ylim(2)
    return
end

if strcmp(get(obj, 'type'), 'figure')
    if phase < 10
        UpdateUI(x, y, ax, K, phase)
        phase = phase + 1; goToPhase(phase, ax);
    end

elseif strcmp(get(obj, 'tag'), 'P1')
    dragN(1) = 1;
    if phase < 10
        phase = goToPhase(phase-1, ax);
    end

elseif strcmp(get(obj, 'tag'), 'P2')
    dragN(2) = 1;
    if phase < 10
        phase = goToPhase(phase-1, ax);
    end

elseif strcmp(get(obj, 'tag'), 'P3')
    dragN(3) = 1;
    if phase < 10
        phase = goToPhase(phase-1, ax);
    end

elseif strcmp(get(obj, 'tag'), 'N1')
    dragN(4) = 1;
    if phase < 10
        phase = goToPhase(phase-1, ax);
    end

elseif strcmp(get(obj, 'tag'), 'N2')
    dragN(5) = 1;
    if phase < 10
        phase = goToPhase(phase-1, ax);
    end

elseif strcmp(get(obj, 'tag'), 'N3')
    dragN(6) = 1;
    if phase < 10
        phase = goToPhase(phase-1, ax);
    end

elseif strcmp(get(obj, 'tag'), 'N4')
    dragN(7) = 1;
    if phase < 10
        phase = goToPhase(phase-1, ax);
    end

elseif strcmp(get(obj, 'tag'), 'N5')
    dragN(8) = 1;
    if phase < 10
        phase = goToPhase(phase-1, ax);
    end

elseif strcmp(get(obj, 'tag'), 'N6')
    dragN(9) = 1;
    if phase < 10
        phase = goToPhase(phase-1, ax);
    end

elseif  strcmp(get(obj, 'tag'), 'L1')
    dragL(1) = 1;
    if phase < 10
        phase = goToPhase(phase-1, ax);
    end

elseif strcmp(get(obj, 'tag'), 'L2')
    dragL(2) = 1;
    if phase < 10
        phase = goToPhase(phase-1, ax);
    end

elseif strcmp(get(obj, 'tag'), 'L3')
    dragL(3) = 1;
    if phase < 10
        phase = goToPhase(phase-1, ax);
    end

elseif strcmp(get(obj, 'tag'), 'L4')
    dragL(4) = 1;
    if phase < 10
        phase = goToPhase(phase-1, ax);
    end

elseif strcmp(get(obj, 'tag'), 'L5')
    dragL(5) = 1; 
    phase = goToPhase(phase-1, ax);

elseif strcmp(get(obj, 'tag'), 'L6')
    dragL(6) = 1;

end

end