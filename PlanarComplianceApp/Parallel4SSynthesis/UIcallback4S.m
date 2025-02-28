function [ ] = UIcallback4S( obj, ~, ax, str )

global phase K x1 y1 gdeData4S

%% Gets the neccesarry objects 
fig = get(ax, 'Parent');
jx = findobj(fig, 'Tag', 'Jx');
jy = findobj(fig, 'Tag', 'Jy');
Jx = str2double(get(jx, 'String'));
Jy = str2double(get(jy, 'String'));

if strcmp(str,'reset')
    %% resets the UI
    ch = get(ax,'Children');
    phase = 0;
    
    delete(ch);
    scatter(0,0,'+','markerfacecolor',[0 0 0],'sizedata',120,'markeredgecolor',[0 0 0]);
    
    stiffnessCenter(K, ax);
    
    phase = goToPhase(1,ax);
    
    set(obj,'value',0);


elseif strcmp(str, 'open_gde')
    %% opens the guide window
    guide4S()
    gde = findobj(0, 'Tag', 'fig2');
    msg = findobj(gde, 'Tag', 'msg');

    if phase == 1
        set(msg, 'String', gdeData4S.msg1)

    elseif phase == 2
        set(msg, 'String', gdeData4S.msg2)

    elseif phase == 3
        set(msg, 'String', gdeData4S.msg3)

    elseif phase == 4
        set(msg, 'String', gdeData4S.msg3)

    elseif phase == 5
        set(msg, 'String', gdeData4S.msg4)

    elseif phase == 6
        set(msg, 'String', gdeData4S.msg5)

    end
    
elseif strcmp(str,'dim')
    %% resizes the axes
    
    val = str2double(get(obj,'string'));
    
    set(ax,'xlim',[-val, val]);
    set(ax,'ylim',[-val, val]);

    [x,y,K] = stiffnessCenter(K, ax);


    % updates lines to extend to the edges of the plot
    [l1x, l1y] = grabData('L1', ax);
    [l2x, l2y] = grabData('L2', ax);
    [l3x, l3y] = grabData('L3', ax);

    [w1x, w1y] = grabData('W1', ax);
    [w2x, w2y] = grabData('W2', ax);
    [w3x, w3y] = grabData('W3', ax);
    [w4x, w4y] = grabData('W4', ax);

    if ~isempty(l1x) && ~isempty(l1y)
        drawLine(l1x, l1y, 'L1', ax)
    end

    if ~isempty(l2x) && ~isempty(l2y)
        drawLine(l2x, l2y, 'L2', ax)
    end

    if ~isempty(l3x) && ~isempty(l3y)
        drawLine(l3x, l3y, 'L3', ax)
    end


    if ~isempty(w1x) && ~isempty(w1y)
        drawLine(w1x, w1y, 'W1', ax)
    end

    if ~isempty(w2x) && ~isempty(w2y)
        drawLine(w2x, w2y, 'W2', ax)
    end

    if ~isempty(w3x) && ~isempty(w3y)
        drawLine(w3x, w3y, 'W3', ax)
    end

    if ~isempty(w4x) && ~isempty(w4y)
        drawLine(w4x, w4y, 'W4', ax)
    end
   
elseif strcmp(str,'c')
    %% updates the compliance matrix
    phase = goToPhase(1,ax);
    K = get(obj,'Data');
    [x,y,K] = stiffnessCenter(K, ax);
    
    figh = get(ax,'parent');
    tb = findobj(figh,'tag','jout');
    out = get(tb,'Data');
    out{1,1} = x;
    out{2,1} = y;
    set(tb,'Data',out);
    
    ch = findobj('tag','line');
    if ~isempty(ch)
       delete(ch); 
       drawLine(x1,y1,ax);
    end

elseif strcmp(str, 'Submit')
    %% Updates the UI when the user clicks submit
    if phase == 1
        if isnan(Jx) || isnan(Jy)
            warndlg('Enter valid x and y coordinates', '', 'modal')
        else

            drawPoint(Jx,Jy,'N1',ax);
            [X1,Y1,~] = generateLine(Jx,Jy,K, ax);
            drawLine(X1,Y1,'L1',ax);
            phase = 2;

            goToPhase(2, ax);
        end 


    elseif phase == 2
        if isnan(Jx) || isnan(Jy)
            warndlg('Enter valid x and y coordinates', '', 'modal')
        else
            [x,y] = closestPoint(Jx,Jy,'L1',ax);
            drawPoint(x,y,'N2',ax);
            [x2,y2,~] = generateLine(x,y,K, ax);
            drawLine(x2,y2,'L2',ax);
            connectPoints('N1','N2',ax);
            phase = 3;
            goToPhase(3, ax);
            
        end 

    elseif phase == 3
        if isnan(Jx) || isnan(Jy)
            warndlg('Enter valid x and y coordinates', '', 'modal')
        else
            drawPoint(Jx,Jy,'N3',ax);
            phase = 4;
            goToPhase(4, ax);
        end
    elseif phase == 4
        if isnan(Jx) || isnan(Jy)
            warndlg('Enter valid x and y coordinates', '', 'modal')
        else
            drawPoint(Jx,Jy,'N4',ax);
            [x3,y3] = grabData('N3',ax);
            drawLine([Jx,x3],[Jy,y3],'L3',ax);
            [x,y] = calcP3(ax);
            drawPoint(x,y,'P3',ax);
            [ec1, ec2] = checkConditions(ax, K);

            if ec1 == 1 || ec2 == 1
                phase = goToPhase(3, ax);
                return
            end
            
            phase = 5;
            goToPhase(5, ax);

        end
    elseif phase == 5 
        if isnan(Jx) || isnan(Jy)
            warndlg('Enter valid x and y coordinates', '', 'modal')
        else
            [xmin,xmax] = getP4Limits(ax);
            [x,y] = closestPoint(Jx,Jy,'L3',ax);
            
            if Jx > xmin && Jx < xmax && phase == 5
                drawPoint(x,y,'N5',ax);
                calcIntersections(ax);
                phase = goToPhase(6, ax);
                Outputs(ax, 'l');
            end 
        end
    end
    
elseif strcmp(str,'Home')
    %% returns the user to the home screen
    framework()
end



end

