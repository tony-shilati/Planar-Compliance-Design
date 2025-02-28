function [] = UICallback6JFLL(obj, ~, ax, str)

global C phase ll

%% Get neccesary objects
fig = get(ax, 'Parent');
if phase > 1
    Jx = findobj(fig, 'Tag', 'Jx');
    Jy = findobj(fig, 'Tag', 'Jy');

    JX = str2double(get(Jx, 'String'));
    JY = str2double(get(Jy, 'String'));
end


if strcmp(str, 'reset')
    %% Resets the UI
    delete(get(ax, 'Children'))

    phase = goToPhase(1, ax);
    
    scatter(0,0,'+','markerfacecolor',[0 0 0],'sizedata',120,'markeredgecolor',[0 0 0]);

    [x, y, C] = compliantCenter(C, ax);
    scatter(x,y,'*','markerfacecolor','red','sizedata',100,'markeredgecolor','red','tag','cpoint');

    set(obj,'value',0);

    X = sprintf('%0.3f', x); Y = sprintf('%0.3f', y);
    jout1 = findobj(fig, 'Tag', 'jout');
    jout2 = findobj(fig, 'Tag', 'jout2');
    set(jout1, 'Data', {X, '', ''; Y, '', ''})
    set(jout2, 'Data', {'', '', '', ''; '', '', '', ''})


elseif strcmp(str, 'open_gde')
    %% Opens the guide window
    guide6J_FLL()
    gde = findobj(0, 'Tag', 'fig2');
    msg = findobj(gde, 'Tag', 'msg');


    if phase == 1
        set(msg, 'String', gdeData6J_FLL.msg1)

    elseif phase == 2
        set(msg, 'String', gdeData6J_FLL.msg2)

    elseif phase == 3
        set(msg, 'String', gdeData6J_FLL.msg3)

    elseif phase == 4
        set(msg, 'String', gdeData6J_FLL.msg4)

    elseif phase == 5
        set(msg, 'String', gdeData6J_FLL.msg5)

    elseif phase == 6
        set(msg, 'String', gdeData6J_FLL.msg6)

    elseif phase == 7
        set(msg, 'String', gdeData6J_FLL.msg7)

    elseif phase == 8
        set(msg, 'String', gdeData6J_FLL.msg8)

    elseif phase == 9
        set(msg, 'String', gdeData6J_FLL.msg9)
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
        l1 = str2double(get(findobj(fig, 'Tag', 'link1'), 'String'));
        l2 = str2double(get(findobj(fig, 'Tag', 'link2'), 'String'));
        l3 = str2double(get(findobj(fig, 'Tag', 'link3'), 'String'));
        l4 = str2double(get(findobj(fig, 'Tag', 'link4'), 'String'));
        l5 = str2double(get(findobj(fig, 'Tag', 'link5'), 'String'));

        if isnan(l1) || isnan(l2) || isnan(l3) || isnan(l4) || isnan(l5)
            warndlg('Enter valid link lengths', '', 'modal')
            phase = 1;
            return 
        end
         
        updateUI(0, 0, ax, C, phase);
        phase = goToPhase(2, ax);

    elseif phase >= 2 && phase < 5 || phase == 6
        updateUI(JX, JY, ax, C, phase);
        phase = goToPhase(phase + 1, ax);

    elseif phase == 5
        [ec1] = checkConditions(ax, C, phase, ll, x, y);
        if ec1 == 1
            return
        end

        updateUI(JX, JY, ax, C, phase);
        phase = goToPhase(phase + 1, ax);

    elseif phase == 7
        [~, ec2] = checkConditions(ax, C, phase, ll, x, y);
        if ec2 == 1
            return
        end
        
        updateUI(JX, JY, ax, C, phase);
        phase = goToPhase(phase + 1, ax);

    elseif phase == 8
        [ec1, ec2] = checkConditions(ax, C, phase, ll, x, y);
        if ec1 == 1 || ec2 == 1
            return
        end
        
        updateUI(JX, JY, ax, C, phase);
        phase = goToPhase(phase + 1, ax);
    end

elseif strcmp(str,'Home')
    %% returns the user to the home screen
    framework()
end


end
