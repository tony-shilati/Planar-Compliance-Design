function [] = UICallback6J(obj, ~, ax, str)

global phase C 

%% Gets neccesary objects
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

    [x, y, C] = compliantCenter(C, ax);
    scatter(x,y,'*','markerfacecolor','red','sizedata',100,'markeredgecolor','red','tag','cpoint');

    set(obj,'value',0);

    drawPoint(ax, 'N1', 0, 0)

    X = sprintf('%0.3f', x); Y = sprintf('%0.3f', y);
    jout1 = findobj(fig, 'Tag', 'jout');
    jout2 = findobj(fig, 'Tag', 'jout2');
    set(jout1, 'Data', {X, '', ''; Y, '', ''})
    set(jout2, 'Data', {'', '', '', ''; '', '', '', ''})

elseif strcmp(str, 'open_gde')
    %% Opens the guide window
    guide6J()

elseif strcmp(str, 'dim')
    %% Resizes the axes

    val = str2double(get(obj,'string'));
    
    set(ax,'xlim',[-val, val]);
    set(ax,'ylim',[-val, val]);

    [x, y, C] = compliantCenter(C, ax);

elseif strcmp(str, 'c')
    %% Updates the compliance matrix

    phase = goToPhase(1,ax);
    C = get(obj,'Data');
    
    ch = findobj('tag','cpoint');
    if ~isempty(ch)
       delete(ch); 
    end

    try
        [x, y, C] = compliantCenter(C, ax);
        scatter(x,y,'*','markerfacecolor','red','sizedata',100,'markeredgecolor','red','tag','cpoint');
    

        tb = findobj(fig,'tag','jout');
        out = get(tb,'Data');
        out{1,1} = x;
        out{2,1} = y;
        set(tb,'Data',out);
    catch 
    end

elseif strcmp(str, 'Submit')
    %% Updates the UI when the user clicks submit

    if phase == 1
        if isnan(pt2X) || isnan(pt2Y)
            warndlg('Enter Valid Coordinates', '', 'modal')
        else
            UpdateUI(ax, C, pt2X, pt2Y, phase)
            phase = goToPhase(2, ax);
        end

    elseif phase == 2
            if isnan(pt1X) || isnan(pt1Y)
            warndlg('Enter valid coordinates', '', 'modal')
        elseif (~isnan(pt1X) && ~isnan(pt1Y)) && (isnan(pt2X) || isnan(pt2Y))
            UpdateUI(ax, C, pt1X, pt1Y, phase)
            phase = goToPhase(3, ax);
        elseif ~isnan(pt1X) && ~isnan(pt1Y) && ~isnan(pt2X) && ~isnan(pt2Y)
            UpdateUI(ax, C, pt1X, pt1Y, phase)
            phase = goToPhase(3, ax);
            UpdateUI(ax, C, pt2X, pt2Y, phase)
            phase = goToPhase(4, ax);
            end

    elseif phase == 3
        if isnan(pt2X) || isnan(pt2Y)
            warndlg('Enter Valid Coordinates', '', 'modal')
        else
            UpdateUI(ax, C, pt2X, pt2Y, phase)
            ec1 = checkConditions(ax, C, phase);
            if ec1 == 1 
                phase = goToPhase(phase-1, ax);
                return
            end
            phase = goToPhase(4, ax);
        end

    elseif phase == 4
        if isnan(pt1X) || isnan(pt1Y)
            warndlg('Enter valid coordinates', '', 'modal')
            return
        end
        UpdateUI(ax, C, pt1X, pt1Y, phase)
        phase = goToPhase(5, ax);

    elseif phase == 5
        if isnan(pt1X) || isnan(pt1Y)
            warndlg('Enter valid coordinates', '', 'modal')
            return
        end
        UpdateUI(ax, C, pt1X, pt1Y, phase)
        phase = goToPhase(6, ax);

    elseif phase == 6
        if isnan(pt1X) || isnan(pt1Y)
            warndlg('Enter valid coordinates', '', 'modal')
            return
        end
        UpdateUI(ax, C, pt1X, pt1Y, phase)

        
        [~, ec2, ~, ~, ~] = checkConditions(ax, C, phase);
        if ec2 == 1
            phase = goToPhase(phase-3, ax);
            return
        end
       

        phase = goToPhase(7, ax);

    elseif phase == 7
        if isnan(pt1X) || isnan(pt1Y)
            warndlg('Enter valid coordinates', '', 'modal')
            return
        end
        UpdateUI(ax, C, pt1X, pt1Y, phase)
        phase = goToPhase(8, ax);
        
    elseif phase == 8
        if isnan(pt1X) || isnan(pt1Y)
            warndlg('Enter valid coordinates', '', 'modal')
            return
        end
        UpdateUI(ax, C, pt1X, pt1Y, phase)

        
        [~, ~, ec3, ec4, ec5] = checkConditions(ax, C, phase);
        if any([ec3, ec4, ec5] == 1)
            phase = goToPhase(phase - 1, ax);
            return
        end
        
        phase = goToPhase(9, ax);

    elseif phase == 9
        

    end

elseif strcmp(str,'Home')
    %% returns the user to the home screen
    framework()
end


end


