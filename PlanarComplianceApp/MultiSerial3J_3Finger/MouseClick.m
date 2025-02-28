function [] = MouseClick(obj, ~, ax)
global phase dragN dragL K
tag = get(obj, 'Tag');

[x, y] = getCurrentXY(ax);

xlim = get(ax, 'xlim');
ylim = get(ax, 'ylim');

if x < xlim(1) || x > xlim (2) || y < ylim(1) || y > ylim(2)
    return
end

fig = get(ax, 'Parent');
if phase > 12
    ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
end

%% 
if strcmp(get(obj, 'type'), 'axes') || (~strcmp(tag, 'P1') && ~strcmp(tag, 'P2') ...
        &&  ~strcmp(tag, 'P3') &&  ~strcmp(tag, 'N1') &&  ~strcmp(tag, 'N2') ...
        &&  ~strcmp(tag, 'N3') &&  ~strcmp(tag, 'N4') &&  ~strcmp(tag, 'N5') ...
        &&  ~strcmp(tag, 'N6') &&  ~strcmp(tag, 'L1') &&  ~strcmp(tag, 'L2') ...
        &&  ~strcmp(tag, 'L3') &&  ~strcmp(tag, 'L4') &&  ~strcmp(tag, 'L5') ...
        &&  ~strcmp(tag, 'L6') && ~strcmp(tag, 'F1J1') && ~strcmp(tag, 'F1J2') ...
        && ~strcmp(tag, 'F1J3') && ~strcmp(tag, 'F2J1') && ~strcmp(tag, 'F2J2') ...
        && ~strcmp(tag, 'F2J3') && ~strcmp(tag, 'F3J1') && ~strcmp(tag, 'F3J2') ...
        && ~strcmp(tag, 'F3J3'))

    if phase == 1
    UpdateUI(x, y, ax, K, phase)

    end


    if (phase < 11) && (phase > 1)
        UpdateUI(x, y, ax, K, phase)

        if phase == 2
            [p1x, p1y] = grabData('P1', ax);
            if isempty(p1x) || isempty(p1y)
                return
            end

        elseif phase == 3
            [p2x, p2y] = grabData('P2', ax);
            if isempty(p2x) || isempty(p2y)
                return
            end

        elseif phase == 8
            [p3x, p3y] = grabData('P3', ax);
            if isempty(p3x) || isempty(p3y)
                return
            end

        end 

        phase = phase + 1; goToPhase(phase, ax);

    elseif phase > 13
        UpdateUI(x, y, ax, K, phase)
        if phase == 15
            [j1x, j1y] = grabData('F1J1', ax);
            if ~isempty(j1x) && ~isempty(j1y)
                r11 = ll_data(1,1);
                drawCircle(ax, r11, j1x, j1y,'crc11', 1)
            end
        end

        if phase == 17
            [j1x, j1y] = grabData('F2J1', ax);
            if ~isempty(j1x) && ~isempty(j1y)
                r21 = ll_data(2,1);
                drawCircle(ax, r21, j1x, j1y,'crc21', 1)
            end
        end

        if phase == 20
            [j1x, j1y] = grabData('F3J1', ax);
            if ~isempty(j1x) && ~isempty(j1y)
                r31 = ll_data(3,1);
                drawCircle(ax, r31, j1x, j1y,'crc31', 1)
            end
        end

        phase = goToPhase(phase + 1, ax);
    end

elseif strcmp(tag, 'P1')
    dragN(1) = 1;

elseif strcmp(tag, 'P2')
    dragN(2) = 1;

elseif strcmp(tag, 'P3')
    dragN(3) = 1;

elseif strcmp(tag, 'N1')
    dragN(4) = 1;

elseif strcmp(tag, 'N2')
    dragN(5) = 1;

elseif strcmp(tag, 'N3')
    dragN(6) = 1;

elseif strcmp(tag, 'N4')
    dragN(7) = 1;

elseif strcmp(tag, 'N5')
    dragN(8) = 1;

elseif strcmp(tag, 'N6')
    dragN(9) = 1;

elseif  strcmp(tag, 'L1')
    dragL(1) = 1;

elseif strcmp(tag, 'L2')
    dragL(2) = 1;

elseif strcmp(tag, 'L3')
    dragL(3) = 1;

elseif strcmp(tag, 'L4')
    dragL(4) = 1;

elseif strcmp(tag, 'L5')
    if phase == 11
        dragL(5) = 1;
    end

elseif strcmp(tag, 'L6')
    dragL(6) = 1;

    %% Finger 1
elseif strcmp(tag, 'F1J1')
    if phase >= 15 && phase <= 17

        phase = goToPhase(15, ax);
    
        %Redraw link length circles 
        [j1x, j1y] = grabData('F1J1', ax);
        [cx, cy] = grabData('P1', ax);
        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        rf1 = norm(ll_data(1,:), 1);
        drawCircle(ax, rf1, cx, cy, 'crcf1', 0)
        r11 = ll_data(1,1);
        drawCircle(ax, r11, j1x, j1y, 'crc11', 1)
        r13 = ll_data(1,3);
        drawCircle(ax, r13, cx, cy, 'crc13', 1)
        dragN(10) = 1;
    end

elseif strcmp(tag, 'F1J2')
    if any(phase == [16, 17])
        dragN(11) = 1;
    end

    if phase == 17
        delete(findobj(ax, 'Tag', 'crcf2'))
        delete(findobj(ax, 'Tag', 'crc23'))

        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        [j1x, j1y] = grabData('F1J1', ax);
        [cx, cy] = grabData('P1', ax);
        r11 = ll_data(1,1);
        drawCircle(ax, r11, j1x, j1y, 'crc11', 1)
        r13 = ll_data(1,3);
        drawCircle(ax, r13, cx, cy, 'crc13', 1)

    end

elseif strcmp(tag, 'F1J3')
    if phase == 17
        dragN(12) = 1;
        delete(findobj(ax, 'Tag', 'crcf2'))
        delete(findobj(ax, 'Tag', 'crc23'))

        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        [j1x, j1y] = grabData('F1J1', ax);
        [cx, cy] = grabData('P1', ax);
        r11 = ll_data(1,1);
        drawCircle(ax, r11, j1x, j1y, 'crc11', 1)
        r13 = ll_data(1,3);
        drawCircle(ax, r13, cx, cy, 'crc13', 1)
    end

%% Finger 2
elseif strcmp(tag, 'F2J1')
    if phase >= 18 && phase <= 20

        phase = goToPhase(18, ax);
    
        %Redraw link length circles 
        [j1x, j1y] = grabData('F2J1', ax);
        [cx, cy] = grabData('P2', ax);
        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        rf2 = norm(ll_data(2,:), 1);
        drawCircle(ax, rf2, cx, cy, 'crcf2', 0)
        r21 = ll_data(2,1);
        drawCircle(ax, r21, j1x, j1y, 'crc21', 1)
        r23 = ll_data(2,3);
        drawCircle(ax, r23, cx, cy, 'crc23', 1)
        dragN(13) = 1;
    end

elseif strcmp(tag, 'F2J2')
    if any(phase == [19, 20])
        dragN(14) = 1;
    end

    if phase == 20
        delete(findobj(ax, 'Tag', 'crcf3'))
        delete(findobj(ax, 'Tag', 'crc33'))

        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        [j1x, j1y] = grabData('F2J1', ax);
        [cx, cy] = grabData('P2', ax);
        r21 = ll_data(2,1);
        drawCircle(ax, r21, j1x, j1y, 'crc21', 1)
        r23 = ll_data(2,3);
        drawCircle(ax, r23, cx, cy, 'crc23', 1)

    end

elseif strcmp(tag, 'F2J3')
    if phase == 20
        dragN(15) = 1;
        delete(findobj(ax, 'Tag', 'crcf3'))
        delete(findobj(ax, 'Tag', 'crc33'))

        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        [j1x, j1y] = grabData('F2J1', ax);
        [cx, cy] = grabData('P2', ax);
        r21 = ll_data(2,1);
        drawCircle(ax, r21, j1x, j1y, 'crc21', 1)
        r13 = ll_data(1,3);
        drawCircle(ax, r13, cx, cy, 'crc23', 1)
    end


%% Finger 3
elseif strcmp(tag, 'F3J1')
    if phase >= 21 && phase <= 23

        phase = goToPhase(21, ax);
    
        %Redraw link length circles 
        [j1x, j1y] = grabData('F3J1', ax);
        [cx, cy] = grabData('P3', ax);
        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        rf3 = norm(ll_data(3,:), 1);
        drawCircle(ax, rf3, cx, cy, 'crcf3', 0)
        r31 = ll_data(3,1);
        drawCircle(ax, r31, j1x, j1y, 'crc31', 1)
        r33 = ll_data(3,3);
        drawCircle(ax, r33, cx, cy, 'crc33', 1)
        dragN(16) = 1;
    end

elseif strcmp(tag, 'F3J2')
    if any(phase == [22, 23])
        dragN(17) = 1;
    end

    if phase == 23

        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        [j1x, j1y] = grabData('F3J1', ax);
        [cx, cy] = grabData('P3', ax);
        r31 = ll_data(3,1);
        drawCircle(ax, r31, j1x, j1y, 'crc31', 1)
        r33 = ll_data(3,3);
        drawCircle(ax, r33, cx, cy, 'crc33', 1)

    end

elseif strcmp(tag, 'F3J3')
    if phase == 23
        dragN(18) = 1;

        ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
        [j1x, j1y] = grabData('F3J1', ax);
        [cx, cy] = grabData('P3', ax);
        r31 = ll_data(3,1);
        drawCircle(ax, r31, j1x, j1y, 'crc31', 1)
        r13 = ll_data(1,3);
        drawCircle(ax, r13, cx, cy, 'crc33', 1)
    end


end

end