function [] = MouseClick(obj, ~, ax)

global phase dragN dragL C

[x,y] = getCurrentXY(ax);
ylim = get(ax,'ylim');
xlim = get(ax,'xlim');

if y > ylim(2) || y < ylim(1) || x > xlim(2) || x < xlim(1)
    return;
end

if strcmp(get(obj,'type'),'figure')

    if phase == 1           
        updateUI(x, y, ax, C, phase)
        dragN(1) = 1;
        phase = goToPhase(2, ax);
       
    elseif phase == 2
        updateUI(x, y, ax, C, phase)
        dragN(2) = 1;
        phase = goToPhase(3, ax);
    
    elseif phase == 3
        updateUI(x, y, ax, C, phase)
        dragN(3) = 1;
        phase = goToPhase(4, ax);
    
    elseif phase == 4
        dragN(4) = 1;
        updateUI(x, y, ax, C, phase)
        phase = goToPhase(5, ax);
    
    elseif phase == 5
        updateUI(x, y, ax, C, phase)
        phase = goToPhase(6, ax);
        checkCondintions(ax, C);
    
    elseif phase == 6 
        dragN(5) = 1;
        updateUI(x, y, ax, C, phase)
        phase = goToPhase(7, ax);
    
    
    elseif phase == 7
        dragN(6) = 1;
        updateUI(x, y, ax, C, phase)
        phase = goToPhase(8, ax);
    
    
    elseif phase == 8
        dragN(7) = 1;
        updateUI(x, y, ax, C, phase)
        phase = goToPhase(9, ax);
        checkCondintions(ax, C);
    
    end


elseif strcmp(get(obj,'tag'), 'N1')
    if phase == 2
        phase = goToPhase(2, ax);
        dragN(1) = 1;
    elseif phase > 2
        phase = goToPhase(3, ax);
        dragN(1) = 1;
    end

elseif strcmp(get(obj,'tag'), 'N2')
    phase = goToPhase(3, ax);
    dragN(2) = 1;

elseif strcmp(get(obj,'tag'), 'N3')
    if phase == 4
        phase = goToPhase(4, ax);
        dragN(3) = 1;
    elseif phase > 4
        phase = goToPhase(5, ax);
        dragN(3) = 1;
    end

elseif strcmp(get(obj,'tag'), 'N4')
    phase = goToPhase(5, ax);
    dragN(4) = 1;

elseif strcmp(get(obj,'tag'), 'N5')
    if phase == 7
        phase = goToPhase(7, ax);
        dragN(5) = 1;
    elseif phase > 7
        phase = goToPhase(8, ax);
        dragN(5) = 1;
    end

elseif strcmp(get(obj,'tag'), 'N6')
    phase = goToPhase(8, ax);
    dragN(6) = 1;

elseif strcmp(get(obj,'tag'), 'N7')
    phase = goToPhase(9, ax);
    dragN(7) = 1;

elseif strcmp(get(obj,'tag'), 'L1')
    phase = goToPhase(3, ax);
    dragL(1) = 1;

elseif strcmp(get(obj,'tag'), 'L2')
    phase = goToPhase(5, ax);
    dragL(2) = 1;

%elseif strcmp(get(obj,'tag'), 'L3')
%    phase = goToPhase(8, ax);
%    dragL(3) = 1;

end

end

