function [] = UICallback3J_2Arm(obj, ~,ax, str)

global phase K
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
    delete(get(ax, 'Children'))

    phase = goToPhase(1, ax);

    scatter(0,0,'+','markerfacecolor',[0 0 0],'sizedata',120,'markeredgecolor',[0 0 0]);

    [x, y, K] = stiffnessCenter(K, ax);
    scatter(x,y,'*','markerfacecolor','red','sizedata',100,'markeredgecolor','red','Tag','cpoint');

    set(obj,'value',0);

     %Turn on the neccesary labels in the outputs box
    set(findobj(fig, 'Tag', 'linLab'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'wrenchLab'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'stiffLab'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'Klab'), 'Visible', 'on')

    %Turn off the neccesary labels and output boxes
    set(findobj(fig, 'Tag', 'compLab'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'jout'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'jout2'), 'Visible', 'off')
    set(findobj(fig, 'Tag', 'jlab'), 'Visible', 'off')
   
    l=1;
    while l < 7
    %Turn on the neccesary output boxes and their labels
    set(findobj(fig, 'Tag', ['lin' num2str(l) 'Lab']), 'Visible', 'on')
    set(findobj(fig, 'Tag', ['lin' num2str(l)]), 'Visible', 'on')

    set(findobj(fig, 'Tag', ['stiff' num2str(l)]), 'Visible', 'on')
    set(findobj(fig, 'Tag', ['stiff' num2str(l) 'Lab']), 'Visible', 'on')

    set(findobj(fig, 'Tag', ['wrench' num2str(l)]), 'Visible', 'on')
    set(findobj(fig, 'Tag', ['wrench' num2str(l) 'Lab']), 'Visible', 'on')

    %Turn off the neccesary output boxes and their labels
    set(findobj(fig, 'Tag', ['comp' num2str(l)]), 'Visible', 'off')
    set(findobj(fig, 'Tag', ['comp' num2str(l) 'Lab']), 'Visible', 'off')

    %Clear the joint compliance boxes
    set(findobj(fig, 'Tag', ['comp' num2str(l)]), 'String', '')

    l = l + 1;
    end
       
elseif strcmp(str, 'open_gde')
    %% Opens the guide message
    guide3J_2Arm()
    gde = findobj(0, 'Tag', 'fig2');
    msg = findobj(gde, 'Tag', 'msg');

    if phase == 1
        set(msg, 'String', gdeData3J_2Arm.msg1)

    elseif phase == 2
        set(msg, 'String', gdeData3J_2Arm.msg2)

    elseif phase == 3
        set(msg, 'String', gdeData3J_2Arm.msg3)

    elseif phase == 4
        set(msg, 'String', gdeData3J_2Arm.msg4)

    elseif phase == 5
        set(msg, 'String', gdeData3J_2Arm.msg5)

    elseif phase == 6
        set(msg, 'String', gdeData3J_2Arm.msg6)

    elseif phase == 7
        set(msg, 'String', gdeData3J_2Arm.msg7)

    elseif phase == 8
        set(msg, 'String', gdeData3J_2Arm.msg8)

    elseif phase == 9
        set(msg, 'String', gdeData3J_2Arm.msg9)

    elseif phase == 10
        set(msg, 'String', gdeData3J_2Arm.msg10)

    elseif phase == 11
        set(msg, 'String', gdeData3J_2Arm.msg11)


    end

elseif strcmp(str, 'dim')
    %% Resizes the axes
    val = str2double(get(obj,'string'));
    
    set(ax,'xlim',[-val, val]);
    set(ax,'ylim',[-val, val]);

    [x, y, K] = stiffnessCenter(K, ax);


elseif strcmp(str, 'c')
    %% Updates the compliance matrix
    phase = goToPhase(1,ax);
    K = get(obj,'Data');
    
    ch = findobj(ax, 'Tag','cpoint');
    if ~isempty(ch)
       delete(ch); 
    end

    try
        [x, y, K] = stiffnessCenter(K, ax);
        scatter(x,y,'*','markerfacecolor','red','sizedata',100,'markeredgecolor','red', 'Tag', 'cpoint');
    
    
        tb = findobj(fig,'str','jout');
        out = get(tb,'Data');
        out{1,1} = x;
        out{2,1} = y;
        set(tb,'Data',out);
    catch 
    end


elseif strcmp(str, 'Submit')
    %% Updates the UI when the user presses submit
    if phase == 1
        if ~isnan(pt1X) && ~isnan(pt1Y) && ~isnan(pt2X) && ~isnan(pt2Y)
            UpdateUI(pt1X, pt1Y, ax, K, phase)
            phase = goToPhase(2,ax);
            UpdateUI(pt2X, pt2Y, ax, K, phase)
            phase = goToPhase(3, ax);

        elseif ~isnan(pt1X) && ~isnan(pt1Y) && (isnan(pt2X) || isnan(pt2Y))
            UpdateUI(pt1X, pt1Y, ax, K, phase)
            phase = goToPhase(2, ax);

        else
            warndlg('Enter Valid Coordinates', '', 'modal')
        end

    elseif phase == 2
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(3, ax);

    elseif phase == 3
        UpdateUI(pt2X, pt2Y, ax, K, phase)
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
        phase = goToPhase(9, ax);

    elseif phase == 9
        UpdateUI(pt2X, pt2Y, ax, K, phase)
        phase = goToPhase(10, ax);

    elseif phase == 10
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

    elseif phase == 11
        g11 = str2double(get(findobj(fig, 'Tag', 'g11'), 'String'));
        g12 = str2double(get(findobj(fig, 'Tag', 'g12'), 'String'));
        g13 = str2double(get(findobj(fig, 'Tag', 'g13'), 'String'));
        g21 = str2double(get(findobj(fig, 'Tag', 'g21'), 'String'));
        g22 = str2double(get(findobj(fig, 'Tag', 'g22'), 'String'));
        g23 = str2double(get(findobj(fig, 'Tag', 'g23'), 'String'));

        G = [g11, g12, g13, g21, g22, g23];
        unq = [1, 2, 3, 4, 5, 6];

        if length(unique(G)) == length(unq)
            if all(unique(G) == unq)
                convertDual(ax)
                phase = goToPhase(11, ax);
            else
                warndlg('Every wrench must be used exactly once.', '', 'modal')
                return
            end
        else 
            warndlg('Every wrench must be used exactly once.', '', 'modal')
            return
        end

        convertDual(ax, K)

        %Delete all wrenches and twists used to construct the multiserial
        %mechanism

        l = 1;
        while l < 7
        delete(findobj(ax, 'Tag', ['N' num2str(l)]))
        delete(findobj(ax, 'Tag', ['L' num2str(l)]))
        l = l + 1;
        end

        l=1;
        while l < 4
        delete(findobj(ax, 'Tag', ['P' num2str(l)]))
        delete(findobj(ax, 'Tag', ['text' num2str(l)]))
        l = l + 1;
        end

        phase = goToPhase(11, ax);

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
        phase = 11;
        UpdateUI(0, 0, ax, K, phase)
        set(findobj(fig, 'Tag', 'ent1lab'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'ent2lab'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'ent1'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'ent2'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'cvt'), 'Visible', 'off')
    end

    phase = 11;
        UpdateUI(0, 0, ax, K, phase)
        set(findobj(fig, 'Tag', 'ent1lab'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'ent2lab'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'ent1'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'ent2'), 'Visible', 'off')
        set(findobj(fig, 'Tag', 'cvt'), 'Visible', 'off')



elseif strcmp(str,'Home')
    %% returns the user to the home screen
    framework()
end

end