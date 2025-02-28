function [] = MouseClick(obj, ~, ax)

global phase dragN dragL tmpCoor K

[x,y] = getCurrentXY(ax);
ylim = get(ax,'ylim');
xlim = get(ax,'xlim');

if y > ylim(2) || y < ylim(1) || x > xlim(2) || x < xlim(1)
    return;
end

if strcmp(get(obj,'type'),'figure')
    
    if phase == 1
        updateUI(x, y, ax, K, phase)
        dragN(1) = 1;
        phase = goToPhase(2,ax);

    elseif phase == 2
        updateUI(x, y, ax, K, phase)
        dragN(2) = 1;
        phase = goToPhase(3,ax);
        
    elseif phase == 3
        updateUI(x, y, ax, K, phase)
        dragN(3) = 1;
        phase = goToPhase(4,ax);

    elseif phase == 4
        [x1,y1] = grabData('N3',ax);

        if x1 ~= x && y1 ~= y
            updateUI(x, y, ax, K, phase)
            dragN(4) = 1;
            phase = goToPhase(5,ax);
            [ec1, ~] = checkConditions(ax);
            if ec1 == 1
                phase = goToPhase(3, ax);
            end
        end
        
    elseif phase == 5
        
        
        updateUI(x, y, ax, K, phase)
        dragN(5) = 1;
        phase = 6;
    
        [~, ec2] = checkConditions(ax);
        if ec2 == 1
            phase = goToPhase(5, ax);
        end
        
    elseif phase == 6
        % Does nothing unless V1 is clicked
        
    end
    
elseif strcmp(get(obj,'tag'),'N1')
    phase = goToPhase(2,ax);
    dragN(1) = 1;
    
elseif strcmp(get(obj,'tag'),'N2')
    phase = goToPhase(3,ax);
    dragN(2) = 1;
    
elseif strcmp(get(obj,'tag'),'N3')

    if phase == 4
        phase = goToPhase(4,ax);
        dragN(3) = 1;
    elseif phase > 4
        phase = goToPhase(5,ax);
        if phase == 5
            dragN(3) = 1;
        end
    end
    
elseif strcmp(get(obj,'tag'),'N4')

    phase = goToPhase(5,ax);
    dragN(4) = 1;
    
elseif strcmp(get(obj,'tag'),'N5')
    phase = goToPhase(6,ax);
    dragN(5) = 1;
    
elseif strcmp(get(obj,'tag'),'N6')
    phase = goToPhase(7,ax);
    dragN(6) = 1;
    
elseif strcmp(get(obj,'tag'),'L3')
    phase = goToPhase(5,ax);
    dragL(1) = 1;
    tmpCoor = [x,y];
    
elseif strcmp(get(obj,'tag'),'V1')
    if phase == 6
        phase = 7;
        updateUI(x, y, ax, K, phase)
        dragN(6) = 1;
        tmpCoor = [x,y];
        goToPhase(7,ax);
    end
    
end
end
