function [] = UICallback3J_3Finger(obj, ~,ax, str)

global phase K V3J_3F linklengths Ps Ss
%% Gets the necceasry objects
fig = get(ax, 'Parent');
pt1x = findobj(fig, 'Tag', 'pt1x');
pt1y = findobj(fig, 'Tag', 'pt1y');
pt2x = findobj(fig, 'Tag', 'pt2x');
pt2y = findobj(fig, 'Tag', 'pt2y');

pt1X = str2double(get(pt1x, 'String'));
pt1Y = str2double(get(pt1y, 'String'));
pt2X = str2double(get(pt2x, 'String'));
pt2Y = str2double(get(pt2y, 'String'));

if strcmp(str, 'reset')
    %% Resets the UI

    if phase > 12
    ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
    end

    if phase == 2
        delete(get(ax, 'Children'))
    
        phase = goToPhase(1, ax);
    
        scatter(0,0,'+','markerfacecolor',[0 0 0],'sizedata',120,'markeredgecolor',[0 0 0]);
    
        stiffnessCenter(K, ax);


    elseif phase > 2 && phase <= 11
        phase = goToPhase(2, ax);
        

    elseif phase == 13
        phase = goToPhase(11, ax);

        delete(findobj(fig, 'Tag', 'legend'))
        set(findobj(fig, 'Tag', 'legend'), 'String', {})
        for i = 1:3
            delete(findobj(ax, 'Tag', ['Finger ' num2str(i)]))
        end

        for i = 1:6
        delete(findobj(ax, 'Tag', ['M' num2str(i)]))
        end

        %Creates a legend for the colors of the joints associated with each
        %finger
        p1 = plot([0, 0], [0.0001, 0], 'Color', [0 0.4470 0.7410], 'LineWidth', 2, 'DisplayName', 'L1', 'Tag', 'M1');
        p2 = plot([0, 0], [0.0001, 0], 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 2, 'DisplayName', 'L2', 'Tag', 'M2');
        p3 = plot([0, 0], [0.0001, 0], 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 2, 'DisplayName', 'L3', 'Tag', 'M3');
        p4 = plot([0, 0], [0.0001, 0], 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 2, 'DisplayName', 'L4', 'Tag', 'M4');
        p5 = plot([0, 0], [0.0001, 0], 'Color', [0.4660 0.6740 0.1880], 'LineWidth', 2, 'DisplayName', 'L5', 'Tag', 'M5');
        p6 = plot([0, 0], [0.0001, 0], 'Color', [0.3010 0.7450 0.9330], 'LineWidth', 2, 'DisplayName', 'L6', 'Tag', 'M6');
        
        leg = legend;
        Ls = leg.String;
        Lss = size(Ls);
        for i = 1:Lss(2)
            if ~strcmp(Ls(1, i), 'L1') && ~strcmp(Ls(1, i), 'L2') && ~strcmp(Ls(1, i), 'L3') && ...
            ~strcmp(Ls(1, i), 'L4') && ~strcmp(Ls(1, i), 'L5') && ~strcmp(Ls(1, i), 'L6')
                Ls(1, i) = {''};
            end
        end
        legend(Ls)
        leg.AutoUpdate = "off";

        set(findobj(fig, 'Tag', 'J1C'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'J2C'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'J3C'), 'Visible', 'off')

        % replot the six spring mechanism

        stiffnessCenter(K, ax);

        Px = Ss.Px;
        Py = Ss.Py;
        Nx = Ss.Nx;
        Ny = Ss.Ny;

        drawPoint(Px(1), Py(1), 'P1', ax)
        drawPoint(Px(2), Py(2), 'P2', ax)
        drawPoint(Px(3), Py(3), 'P3', ax)

        drawPoint(Nx(1), Ny(1), 'N1', ax)
        drawPoint(Nx(2), Ny(2), 'N2', ax)
        drawPoint(Nx(3), Ny(3), 'N3', ax)
        drawPoint(Nx(4), Ny(4), 'N4', ax)
        drawPoint(Nx(5), Ny(5), 'N5', ax)
        drawPoint(Nx(6), Ny(6), 'N6', ax)

        drawLine([Px(1), Nx(1)], [Py(1), Ny(1)], 'L1', ax)
        drawLine([Px(1), Nx(2)], [Py(1), Ny(2)], 'L2', ax)
        drawLine([Px(2), Nx(3)], [Py(2), Ny(3)], 'L3', ax)
        drawLine([Px(2), Nx(4)], [Py(2), Ny(4)], 'L4', ax)
        drawLine([Px(3), Nx(5)], [Py(3), Ny(5)], 'L5', ax)
        drawLine([Px(3), Nx(6)], [Py(3), Ny(6)], 'L6', ax)

        Outputs(ax, K);

    elseif phase == 14
        phase = goToPhase(13, ax);

    elseif phase > 14 && phase <= 17
        phase = goToPhase(14, ax);

        %delete condition Lines
        delete(findobj(ax, 'Tag', 'l'))
        delete(findobj(ax, 'Tag', 'rho'))

        %Display the circle surrounding contact two to prepare for the
        %synthesis of finger 2
        [c1x, c1y] = grabData('P1', ax);
        rf1 = norm(ll_data(1,:),1);
        drawCircle(ax, rf1, c1x, c1y, 'crcf1', 0)
    
        %draws a circle around the second contact which has a radius that is the
        %same as the thrid link length
        r13 = ll_data(1,3);
        drawCircle(ax, r13, c1x, c1y, 'crc13', 1)

        compData = get(findobj(fig, 'tag', 'cout1'), 'Data');
        set(findobj(fig, 'tag', 'cout1'), 'Data', compData)


    elseif phase > 17 && phase <= 20
        phase = goToPhase(17, ax);

        %delete condition Lines
        delete(findobj(ax, 'Tag', 'l'))
        delete(findobj(ax, 'Tag', 'rho'))

        %Display the circle surrounding contact two to prepare for the
        %synthesis of finger 2
        [c2x, c2y] = grabData('P2', ax);
        rf2 = norm(ll_data(2,:),1);
        drawCircle(ax, rf2, c2x, c2y, 'crcf2', 0)
    
        %draws a circle around the second contact which has a radius that is the
        %same as the thrid link length
        r23 = ll_data(2,3);
        drawCircle(ax, r23, c2x, c2y, 'crc23', 1)

        compData = get(findobj(fig, 'tag', 'cout1'), 'Data');
        compData(:,2) = [0; 0; 0];
        set(findobj(fig, 'tag', 'cout1'), 'Data', compData)

    elseif phase > 20
        phase = goToPhase(20, ax);

        %delete condition Lines
        delete(findobj(ax, 'Tag', 'l'))
        delete(findobj(ax, 'Tag', 'rho'))

        %Display the circle surrounding contact two to prepare for the
        %synthesis of finger 2
        [c3x, c3y] = grabData('P3', ax);
        rf3 = norm(ll_data(3,:),1);
        drawCircle(ax, rf3, c3x, c3y, 'crcf3', 0)
    
        %draws a circle around the second contact which has a radius that is the
        %same as the thrid link length
        r33 = ll_data(3,3);
        drawCircle(ax, r33, c3x, c3y, 'crc33', 1)

        compData = get(findobj(fig, 'tag', 'cout1'), 'Data');
        compData(:,3) = [0; 0; 0];
        set(findobj(fig, 'tag', 'cout1'), 'Data', compData)

        Clear_string(ax, 1, 1, 1, 1, 1, 1, 0)

    end
       
elseif strcmp(str, 'open_gde')
    %% Opens the guide message
    guide3J_3Finger()
    gde = findobj(0, 'Tag', 'fig2');
    msg = findobj(gde, 'Tag', 'msg');

    if phase == 1
        set(msg, 'String', gdeData3J_3Finger.msg1)

    elseif phase == 2
        set(msg, 'String', gdeData3J_3Finger.msg2)

    elseif phase == 3
        set(msg, 'String', gdeData3J_3Finger.msg3)

    elseif phase == 4
        set(msg, 'String', gdeData3J_3Finger.msg4)

    elseif phase == 5
        set(msg, 'String', gdeData3J_3Finger.msg5)

    elseif phase == 6
        set(msg, 'String', gdeData3J_3Finger.msg6)

    elseif phase == 7
        set(msg, 'String', gdeData3J_3Finger.msg7)

    elseif phase == 8
        set(msg, 'String', gdeData3J_3Finger.msg8)

    elseif phase == 9
        set(msg, 'String', gdeData3J_3Finger.msg9)

    elseif phase == 10
        set(msg, 'String', gdeData3J_3Finger.msg10)

    elseif phase == 11
        set(msg, 'String', gdeData3J_3Finger.msg11)


    end

elseif strcmp(str, 'Finish')
    if length(V3J_3F.x) < 3
        warndlg('You must define at least three points to define an object.', '', 'modal')
        return
    end

    vert_x = V3J_3F.x;
    vert_y = V3J_3F.y;

    l = length(V3J_3F.x);
    plot([vert_x(l), vert_x(1)], [vert_y(l), vert_y(1)], 'LineWidth', 1.5, 'Color', [.7 .7 .7], 'Tag', ['VL' num2str(l-1)])


    phase = goToPhase(2, ax);
    fin = findobj(fig, 'Tag', 'Finish');
    set(fin, 'Visible', 'off')

    for i = 1:l
        delete(findobj(ax, 'Tag', ['V' num2str(i)]))
    end

    gray = fill(vert_x, vert_y, [.7 .7 .7], 'FaceAlpha', 0.5, 'Tag', 'Fill', 'PickableParts', 'all', 'ButtonDownFcn', {@MouseClick, ax});
    uistack(gray, 'bottom')


elseif strcmp(str, 'dim')
    %% Resizes the axes
    val = str2double(get(obj,'string'));
    
    set(ax,'xlim',[-val, val]);
    set(ax,'ylim',[-val, val]);

    %Updates the lines to reach the axis edges
    stiffnessCenter(K, ax);
    [l1x, l1y] = grabData('L1', ax);
    [l2x, l2y] = grabData('L2', ax);
    [l3x, l3y] = grabData('L3', ax);
    [l4x, l4y] = grabData('L4', ax);
    [l5x, l5y] = grabData('L5', ax);
    [l6x, l6y] = grabData('L6', ax);

    [lx1, ly1] = grabData('l1', ax);
    [lx2, ly2] = grabData('l2', ax);
    [lx3, ly3] = grabData('l3', ax);

    [rx1, ry1] = grabData('rho1', ax);
    [rx2, ry2] = grabData('rho2', ax);
    [rx3, ry3] = grabData('rho3', ax);

    if ~isempty(l1x) && ~isempty(l1y)
        drawLine(l1x, l1y, 'L1', ax)
    end

    if ~isempty(l2x) && ~isempty(l2y)
        drawLine(l2x, l2y, 'L2', ax)
    end

    if ~isempty(l3x) && ~isempty(l3y)
        drawLine(l3x, l3y, 'L3', ax)
    end

    if ~isempty(l4x) && ~isempty(l4y)
        drawLine(l4x, l4y, 'L4', ax)
    end

    if ~isempty(l5x) && ~isempty(l5y)
        drawLine(l5x, l5y, 'L5', ax)
    end

    if ~isempty(l6x) && ~isempty(l6y)
        drawLine(l6x, l6y, 'L6', ax)
    end

    if ~isempty(lx1) && ~isempty(ly1)
        drawLine(lx1, ly1, 'l1', ax)
    end

    if ~isempty(lx2) && ~isempty(ly2)
        drawLine(lx2, ly2, 'l2', ax)
    end

    if ~isempty(lx3) && ~isempty(ly3)
        drawLine(lx3, ly3, 'l3', ax)
    end

    if ~isempty(rx1) && ~isempty(ry1)
        drawLine(rx1, ry1, 'rho1', ax)
    end

    if ~isempty(rx2) && ~isempty(ry2)
        drawLine(rx2, ry2, 'rho2', ax)
    end

    if ~isempty(rx3) && ~isempty(ry3)
        drawLine(rx3, ry3, 'rho3', ax)
    end


elseif strcmp(str, 'c')
    %% Updates the compliance matrix
    K = get(obj,'Data');
    phase = goToPhase(1,ax);
    [x, y, K] = stiffnessCenter(K, ax);
    Visibility(ax, 2, 2, 2, 2, 0, 0)

    tb = findobj(fig,'str','jout');
    out = get(tb,'Data');
    if isempty(x)
        out{1,1} = '';
        out{2,1} = '';
        set(tb,'Data',out);
        return
    else
        out{1,1} = x;
        out{2,1} = y;
        set(tb,'Data',out);
    end


elseif strcmp(str, 'Submit')
    %% Updates the UI when the user presses submit
    if phase > 12
    ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
    end
    
    if phase == 1
        if isnan(pt1X) || isnan(pt1Y)
            return
        end
        
        UpdateUI(pt1X, pt1Y, ax, K, phase)


    elseif phase == 2
        if ~isnan(pt1X) && ~isnan(pt1Y) && ~isnan(pt2X) && ~isnan(pt2Y)
            UpdateUI(pt1X, pt1Y, ax, K, phase)

            %Checks that P1 was placed
            [p1x, p1y] = grabData('P1', ax);
            if isempty(p1x) || isempty(p1y)
                return
            end

            phase = goToPhase(3,ax);
            UpdateUI(pt2X, pt2Y, ax, K, phase)

            % Checks that P2 was placed
            [p2x, p2y] = grabData('P2', ax);
            if isempty(p2x) || isempty(p2y)
                return
            end

            phase = goToPhase(4, ax);

        elseif ~isnan(pt1X) && ~isnan(pt1Y) && (isnan(pt2X) || isnan(pt2Y))
            UpdateUI(pt1X, pt1Y, ax, K, phase)
            phase = goToPhase(3, ax);

        else
            warndlg('Enter Valid Coordinates', '', 'modal')
        end

    elseif phase == 3
        UpdateUI(pt2X, pt2Y, ax, K, phase)

        % Checks that P2 was placed
            [p2x, p2y] = grabData('P2', ax);
            if isempty(p2x) || isempty(p2y)
                return
            end
        
        phase = goToPhase(4, ax);

    elseif phase == 4
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(5, ax);

    elseif phase == 5
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(6, ax);

    elseif phase == 6
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(7, ax);

    elseif phase == 7
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(8, ax);

    elseif phase == 8
        UpdateUI(pt2X, pt2Y, ax, K, phase)

        % Checks that P2 was placed
            [p3x, p3y] = grabData('P3', ax);
            if isempty(p3x) || isempty(p3y)
                return
            end

        phase = goToPhase(9, ax);

    elseif phase == 9
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(10, ax);

    elseif phase == 10
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(11, ax);

    elseif phase == 11
        s1 = str2double(get(findobj(fig, 'Tag', 'ent1'), 'String'));
        s2 = str2double(get(findobj(fig, 'Tag', 'ent2'), 'String'));


        if isnan(s1) && isnan(s2)
            warndlg(['Enter valid Wrench numbers to see the quadratic curve ' ...
                'formed by the other wrenches'], '', 'modal')
            return

        elseif (isnan(s1) && ~isnan(s2)) || (~isnan(s1) && isnan(s2))

            if s1 == 1 || s2 == 1
                delete(findobj(ax, 'Tag', 'QuadCurve'))
                drawQuadCurve(ax, K, 4);

            elseif s1 == 2 || s2 == 2
                delete(findobj(ax, 'Tag', 'QuadCurve'))
                drawQuadCurve(ax, K, 5);

            elseif s1 == 3 || s2 == 3
                delete(findobj(ax, 'Tag', 'QuadCurve'))
                drawQuadCurve(ax, K, 6);

            elseif s1 == 4 || s2 == 4
                delete(findobj(ax, 'Tag', 'QuadCurve'))
                drawQuadCurve(ax, K, 7);

            elseif s1 == 5 || s2 == 5
                delete(findobj(ax, 'Tag', 'QuadCurve'))
                drawQuadCurve(ax, K, 8);

            elseif s1 == 6 || s2 == 6
                delete(findobj(ax, 'Tag', 'QuadCurve'))
                drawQuadCurve(ax, K, 9);

            end
        else
            [l1x, l1y] = grabData('L1', ax);
            [l2x, l2y] = grabData('L2', ax);
            [l3x, l3y] = grabData('L3', ax);
            [l4x, l4y] = grabData('L4', ax);
            [l5x, l5y] = grabData('L5', ax);
            [l6x, l6y] = grabData('L6', ax);
            
            w1 = wrenchFromLine(l1x(1), l1y(1), l1x(2), l1y(2));
            w2 = wrenchFromLine(l2x(1), l2y(1), l2x(2), l2y(2));
            w3 = wrenchFromLine(l3x(1), l3y(1), l3x(2), l3y(2));
            w4 = wrenchFromLine(l4x(1), l4y(1), l4x(2), l4y(2));
            w5 = wrenchFromLine(l5x(1), l5y(1), l5x(2), l5y(2));
            w6 = wrenchFromLine(l6x(1), l6y(1), l6x(2), l6y(2));

            t35 = cross(w3, w5);
            t45 = cross(w4, w5);
            t12 = cross(w1, w2);
            t13 = cross(w1, w3);
            t15 = cross(w1, w5);
            t46 = cross(w4, w6);
            t56 = cross(w5, w6); 
            t26 = cross(w2, w6);
            t23 = cross(w2, w3);
            t25 = cross(w2, w5);
            t36 = cross(w3, w6);
            t14 = cross(w1, w4);
            t24 = cross(w2, w4);
            t34 = cross(w3, w4);

            if s2 < s1 
                if s2 == 1 && s1 == 2
                    drawQuadCurve2(ax, t34, t56, t35, t46)

                elseif s2 == 1 && s1 == 3
                    drawQuadCurve2(ax, t24, t56, t25, t46)
                    
                elseif s2 == 1 && s1 == 4
                    drawQuadCurve2(ax, t23, t56, t25, t36)

                elseif s2 == 1 && s1 == 5
                    drawQuadCurve2(ax, t23, t46, t24, t36)

                elseif s2 == 1 && s1 == 6
                    drawQuadCurve2(ax, t23, t45, t24, t35)

                elseif s2 == 2 && s1 == 3
                    drawQuadCurve2(ax, t14, t56, t15, t46)

                elseif s2 == 2 && s1 == 4
                    drawQuadCurve2(ax, t13, t56, t15, t36)

                elseif s2 == 2 && s1 == 5
                    drawQuadCurve2(ax, t13, t46, t14, t36)

                elseif s2 == 2 && s1 == 6
                    drawQuadCurve2(ax, t13, t45, t14, t35)

                elseif s2 == 3 && s1 == 4
                    drawQuadCurve2(ax, t12, t56, t15, t26)

                elseif s2 == 3 && s1 == 5
                    drawQuadCurve2(ax, t12, t46, t14, t26)

                elseif s2 == 3 && s1 == 6
                    drawQuadCurve2(ax, t12, t46, t14, t24)

                elseif s2 == 4 && s1 == 5
                    drawQuadCurve2(ax, t12, t36, t13, t26)

                elseif s2 == 4 && s1 == 6
                    drawQuadCurve2(ax, t12, t35, t13, t25)

                elseif s2 == 5 && s1 == 6
                    drawQuadCurve2(ax, t12, t34, t13, t24)

                end

            else
                if (s1 == 1) && (s2 == 2)
                    drawQuadCurve2(ax, t34, t56, t35, t46)

                elseif s1 == 1 && s2 == 3
                    drawQuadCurve2(ax, t24, t56, t25, t46)
                    
                elseif s1 == 1 && s2 == 4
                    drawQuadCurve2(ax, t23, t56, t25, t36)

                elseif s1 == 1 && s2 == 5
                    drawQuadCurve2(ax, t23, t46, t24, t36)

                elseif s1 == 1 && s2 == 6
                    drawQuadCurve2(ax, t23, t45, t24, t35)

                elseif s1 == 2 && s2 == 3
                    drawQuadCurve2(ax, t14, t56, t15, t46)

                elseif s1 == 2 && s2 == 4
                    drawQuadCurve2(ax, t13, t56, t15, t36)

                elseif s1 == 2 && s2 == 5
                    drawQuadCurve2(ax, t13, t46, t14, t36)

                elseif s1 == 2 && s2 == 6
                    drawQuadCurve2(ax, t13, t45, t14, t35)

                elseif s1 == 3 && s2 == 4
                    drawQuadCurve2(ax, t12, t56, t15, t26)

                elseif s1 == 3 && s2 == 5
                    drawQuadCurve2(ax, t12, t46, t14, t26)

                elseif s1 == 3 && s2 == 6
                    drawQuadCurve2(ax, t12, t46, t14, t24)

                elseif s1 == 4 && s2 == 5
                    drawQuadCurve2(ax, t12, t36, t13, t26)

                elseif s1 == 4 && s2 == 6
                    drawQuadCurve2(ax, t12, t35, t13, t25)

                elseif s1 == 5 && s2 == 6
                    drawQuadCurve2(ax, t12, t34, t13, t24)

                end

            end

        end

    elseif phase == 13
        Len_Table = findobj(fig, 'Tag', 'LenTable');
        Lengths = str2double(get(Len_Table, 'Data'));

        if any(any(isnan(Lengths)))
            warndlg('Enter a value for every link length', '', 'modal')
            return
        end

        linklengths = Lengths;

        UpdateUI(0, 0, ax, K, phase)

        phase = 14;

    elseif phase == 14
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(15, ax);

    elseif phase == 15
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(16, ax);
        if phase == 15
            [j1x, j1y] = grabData('F1J1', ax);
            if ~isempty(j1x) && ~isempty(j1y)
                r11 = ll_data(1,1);
                drawCircle(ax, r11, j1x, j1y,'crc11', 1)
            end
        end

    elseif phase == 16
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(17, ax);

    elseif phase == 17
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(18, ax);

    elseif phase == 18
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(19, ax);
        if phase == 18
            [j1x, j1y] = grabData('F2J1', ax);
            if ~isempty(j1x) && ~isempty(j1y)
                r21 = ll_data(2,1);
                drawCircle(ax, r21, j1x, j1y,'crc21', 1)
            end
        end

    elseif phase == 19
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(20, ax);

    elseif phase == 20
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(21, ax);

    elseif phase == 21
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(22, ax);
        if phase == 21
            [j1x, j1y] = grabData('F3J1', ax);
            if ~isempty(j1x) && ~isempty(j1y)
                r31 = ll_data(3,1);
                drawCircle(ax, r31, j1x, j1y,'crc31', 1)
            end
        end
        

    elseif phase == 22
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(23, ax);

    end

elseif strcmp(str, 'cvt')
    %% Converts to the dual mechanism when the user presses the convert mechanism
    K1 = str2double((get(findobj(fig, 'Tag', 'stiff1'), 'String')));
    K2 = str2double((get(findobj(fig, 'Tag', 'stiff2'), 'String')));
    K3 = str2double((get(findobj(fig, 'Tag', 'stiff3'), 'String')));
    K4 = str2double((get(findobj(fig, 'Tag', 'stiff4'), 'String')));
    K5 = str2double((get(findobj(fig, 'Tag', 'stiff5'), 'String')));
    K6 = str2double((get(findobj(fig, 'Tag', 'stiff6'), 'String')));


    if any([K1, K2, K3, K4, K5, K6] < 0)
    warndlg(['This stiffness has not been realized yet. All spring stiffnesses ' ...
        'must be positive before converting the mechanism.'], '', 'modal')
    return
    else
        phase = 12;
        UpdateUI(0, 0, ax, K, phase)
    
        phase = 13;
    
        set(findobj(fig, 'Tag', 'J1C'), 'Visible', 'on')
        set(findobj(fig, 'Tag', 'J2C'), 'Visible', 'on')
        set(findobj(fig, 'Tag', 'J3C'), 'Visible', 'on')
    
    
    
        delete(findobj(fig, 'Tag', 'legend'))
        for i = 1:6
            delete(findobj(ax, 'Tag', ['M' num2str(i)]))
        end
    
        delete(findobj(fig, 'Tag', 'legend'))
        for i = 1:3
            delete(findall(ax, 'Tag', ['Finger' num2str(i)]))
        end
    
        %Creates a legend for the colors of the joints associated with each
        %finger
        p1 = plot([0, 0], [0.0001, 0], 'Color', [0 0.4470 0.7410], 'LineWidth', 2, 'DisplayName', 'Finger 1', 'Tag', 'Finger1');
        p2 = plot([0, 0], [0.0001, 0], 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 2, 'DisplayName', 'Finger 2', 'Tag', 'Finger2');
        p3 = plot([0, 0], [0.0001, 0], 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 2, 'DisplayName', 'Finger 3', 'Tag', 'Finger3');
        
        leg = legend;
        leg.AutoUpdate = "off";
        Ls = leg.String;
        Lss = size(Ls);
        for i = 1:Lss(2)
            if ~strcmp(Ls(1, i), 'Finger 1') && ~strcmp(Ls(1, i), 'Finger 2') && ~strcmp(Ls(1, i), 'Finger 3')
                Ls(1, i) = {''};
            end
        end
        legend(Ls)
        
    end


elseif strcmp(str, 'J1C')
    %% displays the seperation condition Based on joint 1
    if any(phase == [15 16 17])
        omega = [0, -1; 1, 0];

        [x1, y1] = grabData('F1J1', ax);
        [c1x, c1y] = grabData('P1', ax);
        r = [(x1-c1x); (y1-c1y)];
        Kp33 = Ps.K1;
        Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
       
        % calculates line l slope
        v = omega'*r;
        f = Kp22*v;
        m_l = f(2)/f(1);
    
        %function of line l
        bl1 = c1y - m_l*c1x;
        ly1 = @(x) m_l*x + bl1;
    
        %Values used to plot the line of action of the force
        lx = c1x+1;
        ly = ly1(lx);
        %plots the lines passing through the contact point
        drawLine([c1x, x1], [c1y, y1], 'rho', ax)
        drawLine([lx, c1x], [ly, c1y], 'l', ax)


    elseif any(phase == [18 19 20])
        omega = [0, -1; 1, 0];

        [x1, y1] = grabData('F2J1', ax);
        [c2x, c2y] = grabData('P2', ax);
        r = [(x1-c2x); (y1-c2y)];
        Kp33 = Ps.K2;
        Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
       
        % calculates line l slope
        v = omega'*r;
        f = Kp22*v;
        m_l = f(2)/f(1);
    
        %function of line l
        bl1 = c2y - m_l*c2x;
        ly1 = @(x) m_l*x + bl1;
    
        %Values used to plot the line of action of the force
        lx = c2x+1;
        ly = ly1(lx);
        %plots the lines passing through the contact point
        drawLine([c2x, x1], [c2y, y1], 'rho', ax)
        drawLine([lx, c2x], [ly, c2y], 'l', ax)


    elseif any(phase == [21 22 23])
        omega = [0, -1; 1, 0];

        [x1, y1] = grabData('F3J1', ax);
        [c3x, c3y] = grabData('P3', ax);
        r = [(x1-c3x); (y1-c3y)];
        Kp33 = Ps.K3;
        Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
       
        % calculates line l slope
        v = omega'*r;
        f = Kp22*v;
        m_l = f(2)/f(1);
    
        %function of line l
        bl1 = c3y - m_l*c3x;
        ly1 = @(x) m_l*x + bl1;
    
        %Values used to plot the line of action of the force
        lx = c3x+1;
        ly = ly1(lx);
        %plots the lines passing through the contact point
        drawLine([c3x, x1], [c3y, y1], 'rho', ax)
        drawLine([lx, c3x], [ly, c3y], 'l', ax)

    end



elseif strcmp(str, 'J2C')
    %% displays the seperation condition Based on joint 2
    if any(phase == [16 17])
        omega = [0, -1; 1, 0];

        [x2, y2] = grabData('F1J2', ax);
        [c1x, c1y] = grabData('P1', ax);
        r = [(x2-c1x); (y2-c1y)];
        Kp33 = Ps.K1;
        Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
       
        % calculates line l slope
        v = omega'*r;
        f = Kp22*v;
        m_l = f(2)/f(1);
    
        %function of line l
        bl1 = c1y - m_l*c1x;
        ly1 = @(x) m_l*x + bl1;
    
        %Values used to plot the line of action of the force
        lx = c1x+1;
        ly = ly1(lx);
        %plots the lines passing through the contact point
        drawLine([c1x, x2], [c1y, y2], 'rho', ax)
        drawLine([lx, c1x], [ly, c1y], 'l', ax)

    elseif any(phase == [19 20])
        omega = [0, -1; 1, 0];

        [x2, y2] = grabData('F2J2', ax);
        [c2x, c2y] = grabData('P2', ax);
        r = [(x2-c2x); (y2-c2y)];
        Kp33 = Ps.K2;
        Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
       
        % calculates line l slope
        v = omega'*r;
        f = Kp22*v;
        m_l = f(2)/f(1);
    
        %function of line l
        bl1 = c2y - m_l*c2x;
        ly1 = @(x) m_l*x + bl1;
    
        %Values used to plot the line of action of the force
        lx = c2x+1;
        ly = ly1(lx);
        %plots the lines passing through the contact point
        drawLine([c2x, x2], [c2y, y2], 'rho', ax)
        drawLine([lx, c2x], [ly, c2y], 'l', ax)


    elseif any(phase == [22 23])
        omega = [0, -1; 1, 0];

        [x2, y2] = grabData('F3J2', ax);
        [c3x, c3y] = grabData('P3', ax);
        r = [(x2-c3x); (y2-c3y)];
        Kp33 = Ps.K3;
        Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
       
        % calculates line l slope
        v = omega'*r;
        f = Kp22*v;
        m_l = f(2)/f(1);
    
        %function of line l
        bl1 = c3y - m_l*c3x;
        ly1 = @(x) m_l*x + bl1;
    
        %Values used to plot the line of action of the force
        lx = c3x+1;
        ly = ly1(lx);
        %plots the lines passing through the contact point
        drawLine([c3x, x2], [c3y, y2], 'rho', ax)
        drawLine([lx, c3x], [ly, c3y], 'l', ax)

    end

elseif strcmp(str, 'J3C')
    %% displays the seperation condition Based on joint 3
    if phase == 17
        omega = [0, -1; 1, 0];

        [x3, y3] = grabData('F1J3', ax);
        [c1x, c1y] = grabData('P1', ax);
        r = [(x3-c1x); (y3-c1y)];
        Kp33 = Ps.K1;
        Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
       
        % calculates line l slope
        v = omega'*r;
        f = Kp22*v;
        m_l = f(2)/f(1);
    
        %function of line l
        bl1 = c1y - m_l*c1x;
        ly1 = @(x) m_l*x + bl1;
    
        %Values used to plot the line of action of the force
        lx = c1x+1;
        ly = ly1(lx);
        %plots the lines passing through the contact point
        drawLine([c1x, x3], [c1y, y3], 'rho', ax)
        drawLine([lx, c1x], [ly, c1y], 'l', ax)

    elseif phase == 20
        omega = [0, -1; 1, 0];

        [x3, y3] = grabData('F2J3', ax);
        [c2x, c2y] = grabData('P2', ax);
        r = [(x3-c2x); (y3-c2y)];
        Kp33 = Ps.K2;
        Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
       
        % calculates line l slope
        v = omega'*r;
        f = Kp22*v;
        m_l = f(2)/f(1);
    
        %function of line l
        bl1 = c2y - m_l*c2x;
        ly1 = @(x) m_l*x + bl1;
    
        %Values used to plot the line of action of the force
        lx = c2x+1;
        ly = ly1(lx);
        %plots the lines passing through the contact point
        drawLine([c2x, x3], [c2y, y3], 'rho', ax)
        drawLine([lx, c2x], [ly, c2y], 'l', ax)

    elseif phase == 23
        omega = [0, -1; 1, 0];

        [x3, y3] = grabData('F3J3', ax);
        [c3x, c3y] = grabData('P3', ax);
        r = [(x3-c3x); (y3-c3y)];
        Kp33 = Ps.K3;
        Kp22 = [Kp33(1,1), Kp33(1,2); Kp33(2,1), Kp33(2,2)];
       
        % calculates line l slope
        v = omega'*r;
        f = Kp22*v;
        m_l = f(2)/f(1);
    
        %function of line l
        bl1 = c3y - m_l*c3x;
        ly1 = @(x) m_l*x + bl1;
    
        %Values used to plot the line of action of the force
        lx = c3x+1;
        ly = ly1(lx);
        %plots the lines passing through the contact point
        drawLine([c3x, x3], [c3y, y3], 'rho', ax)
        drawLine([lx, c3x], [ly, c3y], 'l', ax)

    end


elseif strcmp(str,'Home')
    %% returns the user to the home screen
    framework()
end

end