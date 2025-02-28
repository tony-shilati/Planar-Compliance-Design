function [] = UICallback5J(obj, ~, ax, str)

global phase C

%% Gets the neccesary objects
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
    %% Rests the UI
    delete(get(ax, 'Children'))

    phase = goToPhase(1, ax);
    
    scatter(0,0,'+','markerfacecolor',[0 0 0],'sizedata',120,'markeredgecolor',[0 0 0]);

    [x, y, C] = compliantCenter(C, ax);
    scatter(x,y,'*','markerfacecolor','red','sizedata',100,'markeredgecolor','red','tag','cpoint');

    set(obj,'value',0);

elseif strcmp(str, 'open_gde')
    %% Opens the guide window
    guide5J()
    gde = findobj(0, 'Tag', 'fig2');
    msg = findobj(gde, 'Tag', 'msg');

    if phase == 1
        set(msg, 'String', gdeData5J.msg1)

    elseif phase == 2
        set(msg, 'String', gdeData5J.msg2)

    elseif phase == 3
        set(msg, 'String', gdeData5J.msg3)

    elseif phase == 4
        set(msg, 'String', gdeData5J.msg4)

    elseif phase == 5
        set(msg, 'String', gdeData5J.msg5)

    elseif phase == 6
        set(msg, 'String', gdeData5J.msg6)

    elseif phase == 7
        set(msg, 'String', gdeData5J.msg7)

    elseif phase == 8
        set(msg, 'String', gdeData5J.msg8)


    end

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
    %% Updates the UI when the user presses submit

    if phase == 1           
        if ~isnan(pt1X) && ~isnan(pt1Y) && ~isnan(pt2X) && ~isnan(pt2Y)
        updateUI(pt1X, pt1Y, ax, C, phase)
        phase = goToPhase(2, ax);
        updateUI(pt2X, pt2Y, ax, C, phase)
        phase = goToPhase(3, ax);
         

        elseif ~isnan(pt1X) && ~isnan(pt1Y) && (isnan(pt2X) || isnan(pt2Y))
            updateUI(pt1X, pt1Y, ax, C, phase)
            phase = goToPhase(2, ax);
        else
            warndlg('Enter Valid Coordinates', '', 'modal')
        end

    elseif phase == 2
        updateUI(pt2X, pt2Y, ax, C, phase)
        phase = goToPhase(3, ax);

    elseif phase == 3
        if ~isnan(pt1X) && ~isnan(pt1Y) && ~isnan(pt2X) && ~isnan(pt2Y)
        updateUI(pt1X, pt1Y, ax, C, phase)
        phase = goToPhase(4, ax);
        updateUI(pt2X, pt2Y, ax, C, phase)
        phase = goToPhase(5, ax);
         

        elseif ~isnan(pt1X) && ~isnan(pt1Y) && (isnan(pt2X) || isnan(pt2Y))
            updateUI(pt1X, pt1Y, ax, C, phase)
            phase = goToPhase(4, ax);

        else
            warndlg('Enter Valid Coordinates', '', 'modal')
        end


    elseif phase == 4
        updateUI(pt1X, pt1Y, ax, C, phase)
        phase = goToPhase(4, ax);

    elseif phase == 5
        updateUI(pt1X, pt1Y, ax, C, phase)
        phase = goToPhase(6, ax);
        checkCondintions(ax, C);

    elseif phase == 6 
        if ~isnan(pt1X) && ~isnan(pt1Y) && ~isnan(pt2X) && ~isnan(pt2Y)
        updateUI(pt1X, pt1Y, ax, C, phase)
        phase = goToPhase(7, ax);
        updateUI(pt2X, pt2Y, ax, C, phase)
        phase = goToPhase(8, ax);

        elseif ~isnan(pt1X) && ~isnan(pt1Y) && (isnan(pt2X) || isnan(pt2Y))
            updateUI(pt1X, pt1Y, ax, C, phase)
            phase = goToPhase(7, ax);

        else
            warndlg('Enter Valid Coordinates', '', 'modal')
        end

    elseif phase == 7
        updateUI(pt2X, pt2Y, ax, C, phase)
        phase = goToPhase(8, ax);

    elseif phase == 8

        updateUI(pt2X, pt2Y, ax, C, phase)
        phase = goToPhase(9, ax);
        checkCondintions(ax, C);

    end


elseif strcmp(str,'Home')
    %% returns the user to the home screen
    framework()

end


end