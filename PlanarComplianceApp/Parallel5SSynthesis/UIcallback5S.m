function [ ] = UIcallback5S( obj, ~, ax, str )

global phase K x1 y1 tmpCoor gdeData5S

%% Gets neccesary objects
fig = get(ax, 'Parent');

jx = findobj(fig, 'Tag', 'Jx');
jy = findobj(fig, 'Tag', 'Jy');
Jx = str2double(get(jx, 'String'));
Jy = str2double(get(jy, 'String'));


if strcmp(str,'reset')
    %% resets the UI
    ch = get(ax,'Children');
    
    delete(ch);
    scatter(0,0,'+','markerfacecolor',[0 0 0],'sizedata',120,'markeredgecolor',[0 0 0]);
    
    [x,y, K] = stiffnessCenter(K, ax);
    scatter(x,y,'*','markerfacecolor','red','sizedata',100,'markeredgecolor','red','tag','cpoint');
    
    phase = goToPhase(1,ax);
    
    set(obj,'value',0);

elseif strcmp(str, 'open_gde')
    %% Opens the guide window
    guide5S()
    gde = findobj(0, 'Tag', 'fig2');
    msg = findobj(gde, 'Tag', 'msg');

    if phase == 1
        set(msg, 'String', gdeData5S.msg1)

    elseif phase == 2
        set(msg, 'String', gdeData5S.msg2)

    elseif phase == 3
        set(msg, 'String', gdeData5S.msg3)

    elseif phase == 4
        set(msg, 'String', gdeData5S.msg4)

    elseif phase == 5
        set(msg, 'String', gdeData5S.msg5)

    elseif phase == 6
        set(msg, 'String', gdeData5S.msg6)

    elseif phase == 7
        set(msg, 'String', gdeData5S.msg7)

    end
        
elseif strcmp(str,'dim')
    %% Changes the axis length 
    
    val = str2double(get(obj,'string'));
    
    set(ax,'xlim',[-val, val]);
    set(ax,'ylim',[-val, val]);

    [x,y, K] = stiffnessCenter(K, ax);
   
elseif strcmp(str,'c')
    %% Updantes the Stiffness Matrix
    phase = goToPhase(1,ax);
    K = get(obj,'Data');
    
    ch = findobj('tag','cpoint');
    if ~isempty(ch)
       delete(ch); 
    end
    
    try
        [x,y, K] = stiffnessCenter(K, ax);
        scatter(x,y,'*','markerfacecolor','red','sizedata',100,'markeredgecolor','red','tag','cpoint');
        
        figh = get(ax,'parent');
        tb = findobj(figh,'tag','jout');
        out = get(tb,'Data');
        out{1,1} = x;
        out{2,1} = y;
        set(tb,'Data',out);
    catch
    end
    
    
    
    ch = findobj('tag','line');
    if ~isempty(ch)
       delete(ch); 
       drawLine(x1,y1,ax);
    end

elseif strcmp(str, 'Submit')
    %% Updates the UI when the user presse submit
    if isnan(Jx) || isnan(Jy)
        warndlg('Enter valid x and y coordinates', '', 'modal')
        return
    end

    if phase == 1
        updateUI(Jx, Jy, ax, K, phase)
        phase = goToPhase(2, ax);
    elseif phase == 2
        updateUI(Jx, Jy, ax, K, phase)
        phase = goToPhase(3, ax);

    elseif phase == 3
        updateUI(Jx, Jy, ax, K, phase)
        phase = goToPhase(4, ax);

    elseif phase == 4
        updateUI(Jx, Jy, ax, K, phase)
        phase = goToPhase(5, ax);
        [ec1, ~] = checkConditions(ax);
        if ec1 == 1
            phase = goToPhase(3, ax);
        end

    elseif phase == 5
        updateUI(Jx, Jy, ax, K, phase)
        phase = goToPhase(6, ax);

        [~, ec2] = checkConditions(ax);
        if ec2 == 1
            phase = goToPhase(5, ax);
        end

    elseif phase == 6
        phase = 7;
        updateUI(Jx, Jy, ax, K, phase)
        tmpCoor = [Jx,Jy];
        goToPhase(7, ax);

    end
        
elseif strcmp(str,'Home')
    %% returns the user to the home screen
    framework()
    
    
end




end

