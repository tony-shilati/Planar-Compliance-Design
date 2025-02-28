function [ ] = UIcallback4J( obj, ~, ax, str )

global phase C x1 y1 gdeData4J

%% finds the Neccesary Objects
fig = get(ax, 'Parent');


pt1x = findobj(fig, 'Tag', 'pt1x');
pt1y = findobj(fig, 'Tag', 'pt1y');
pt2x = findobj(fig, 'Tag', 'pt2x');
pt2y = findobj(fig, 'Tag', 'pt2y');

pt1X = str2double(get(pt1x, 'String'));
pt1Y = str2double(get(pt1y, 'String'));
pt2X = str2double(get(pt2x, 'String'));
pt2Y = str2double(get(pt2y, 'String'));



if strcmp(str,'reset')
%% if the user presses reset
    ch = get(ax,'Children');
    
    delete(ch);
    scatter(0,0,'+','markerfacecolor',[0 0 0],'sizedata',120,'markeredgecolor',[0 0 0]);
    
    compliantCenter(C, ax);
    
    phase = goToPhase(1,ax);
    
    set(obj,'value',0);

    
elseif strcmp(str, 'open_gde')
    %%
    guide4J()
    gde = findobj(0, 'Tag', 'fig2');
    msg = findobj(gde, 'Tag', 'msg');

    if phase == 1
        set(msg, 'String', gdeData4J.msg1)
        set(msg, 'FontSize', 0.026)

    elseif phase == 2
        set(msg, 'String', gdeData4J.msg2)
        set(msg, 'FontSize', 0.04)

    elseif phase == 3
        set(msg, 'String', gdeData4J.msg3)
        set(msg, 'FontSize', 0.04)

    elseif phase == 4
        set(msg, 'String', gdeData4J.msg4)
        set(msg, 'FontSize', 0.04)

    elseif phase == 5
        set(msg, 'String', gdeData4J.msg5)
        set(msg, 'FontSize', 0.04)

    elseif phase == 6
        set(msg, 'String', gdeData4J.msg6)
        set(msg, 'FontSize', 0.04)

    elseif phase == 7
        set(msg, 'String', gdeData4J.msg7)
        set(msg, 'FontSize', 0.04)

    end

    
elseif strcmp(str,'dim')
%% if the user enters a new axis length
    
    %Sets the axes limits to be the nuber entered in the scalar box
    val = str2num(get(obj,'string'));
    
    set(ax,'xlim',[-val, val]);
    set(ax,'ylim',[-val, val]);

    %Updates lines to fit the axes
    compliantCenter(C, ax);

    [l1x, l1y] = grabData('L1', ax);
    [l2x, l2y] = grabData('L2', ax);
    [l3x, l3y] = grabData('L3', ax);
    [l4x, l4y] = grabData('L4', ax);

    %line 1
    if ~isempty(l1x) && ~isempty(l1y)
        drawLine(l1x, l1y, 'L1', ax)
    end

    %line 2
    if ~isempty(l2x) && ~isempty(l2y)
        drawLine(l2x, l2y, 'L2', ax)
    end

    %line 3
    if ~isempty(l3x) && ~isempty(l3y)
        drawLine(l3x, l3y, 'L3', ax)
    end

    %line 4
    if ~isempty(l4x) && ~isempty(l4y)
        drawLine(l4x, l4y, 'L4', ax)
    end
   
elseif strcmp(str,'c')
%% if the user updates the Complisnce matrix

    %Update the compliant center if the user edits it on the ui
    phase = goToPhase(1,ax);
    C = get(obj,'Data');
    
    ch = findobj('tag','cpoint');
    if ~isempty(ch)
       delete(ch); 
    end
    
    [x, y, C] = compliantCenter(C, ax);
    
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
%% If the user presses Submit
    %Updates the axes if the user enters coordinates and presses enter
    if phase == 1 
        %if the point 1 coordinates arent a number this reads an error
        %message
        if isnan(pt1X) || isnan(pt1Y)
            warndlg('Enter valid X and Y coordinates before pressing submit', '', 'modal')

        %if there are valid coordinates for point 1 but not for point two
        %this will plot point 1 only and set the phase to 2
        elseif isnan(pt2X) || isnan(pt2Y)
            drawPoint(pt1X,pt1Y,'N1',ax);
            phase = goToPhase(2, ax);



        %If all the coordinates entered are valid this will plot point 1
        %and two and the line that passes through them. this will also plot
        %the first twist center T1
        elseif ~isnan(pt1X) && ~isnan(pt1Y) && ~isnan(pt2X) && ~isnan(pt2Y)
            if pt1X == pt2X && pt1Y == pt2Y
                warndlg('Point 1 and Point 2 must have different coordinates', '', 'modal')
            else
                drawPoint(pt1X, pt1Y, 'N1', ax)
                drawPoint(pt2X, pt2Y, 'N2', ax)
                drawLine([pt1X,pt2X], [pt1Y,pt2Y], 'L1', ax)
                [t1x,t1y] = calcTwist(ax, 'TwistOne');
                drawPoint(t1x, t1y, 'P1', ax);
                phase = goToPhase(4, ax);
                

            end      
        end 

    elseif phase == 2
        if isnan(pt2X) || isnan(pt2Y)
            warndlg('Enter valid coordinates for Point 2', '', 'modal')
        elseif pt2X == pt1X || pt2Y == pt1Y
            warndlg('Point 1 and Point 2 cannot have the same coordinates', '', 'modal')
        else
            drawPoint(pt2X, pt2Y, 'N2', ax)
            drawLine([pt1X,pt2X], [pt1Y,pt2Y], 'L1', ax)
            [t1x, t1y] = calcTwist(ax, 'TwistOne');
            drawPoint(t1x, t1y, 'P1', ax)
            phase = goToPhase(3, ax);
        end

    elseif phase == 3
        drawPoint(pt2X, pt2Y, 'N3', ax)
        [t1x, t1y] = grabData('P1', ax);
        drawLine([t1x, pt2X],[t1y, pt2Y], 'L2', ax)
        [p2x, p2y] = calcTwist(ax, 'TwistTwo');
        drawPoint(p2x, p2y, 'P2', ax)
        connectPoints('P1', 'P2', ax)
        phase = 4;

        %Update interface
        goToPhase(4, ax);


    elseif phase == 4
        %If the either of the coordinates in the point 1 spot aren't valid
        %then this displays an error message
        if isnan(pt1X) || isnan(pt1Y)
            warndlg('Enter valid X and Y coordinates before pressing submit', '', 'modal')

        %If either of the coordinates in the point 2 spot arent valid then
        %this plots the first handle of line l3 and sets the phase to 5
        elseif isnan(pt2X) || isnan(pt2Y)
            drawPoint(pt1X,pt1Y,'N5',ax)
            phase = 5;

            %Update interface
            goToPhase(5, ax);

        elseif ~isnan(pt1X) && ~isnan(pt1Y) && ~isnan(pt2X) && ~isnan(pt2Y)
            if pt1X == pt2X || pt1Y == pt2Y
                warndlg('Point 1 and Point 2 must have different coordinates', '', 'modal')
            else

                
                drawPoint(pt1X, pt1Y, 'N5', ax)
                drawPoint(pt2X, pt2Y, 'N6', ax)
                drawLine([pt1X,pt2X], [pt1Y,pt2Y], 'L3', ax)
                [t3x,t3y] = calcTwist(ax, 'TwistThree');
                drawPoint(t3x, t3y, 'P3', ax)
                phase = 6;

                [ec1, ec2, ~] = checkConditions(ax, C);

                if ec1 == 1 || ec2 == 1
                    phase = goToPhase(4, ax);
                    return
                end

                %Update interface
                goToPhase(6, ax);
            end
        end

    elseif phase == 5
        [n5x,n5y] = grabData('N5', ax);
        if n5x == pt2X && n5y == pt2Y
            warndlg('Point 1 and Point 2 must have different coordinates', '', 'modal')
        else
            drawPoint(pt2X,pt2Y, 'N6', ax)
            drawLine([n5x, pt2X],[n5y, pt2Y], 'L3', ax)
            [t3x,t3y] = calcTwist(ax, 'TwistThree');
            drawPoint(t3x, t3y, 'P3', ax)
            phase = 6;

            [ec1, ec2, ~] = checkConditions(ax, C);

            if ec1 == 1 || ec2 == 1
                phase = goToPhase(4, ax);
                return
            end

            %Update interface
            goToPhase(6, ax);

        end

    elseif phase == 6 
        drawPoint(pt2X, pt2Y, 'N7', ax)
        [t3x,t3y] = grabData('P3',ax);
        drawLine([t3x, pt2X], [t3y, pt2Y], 'L4', ax)
        [t4x, t4y] = calcTwist(ax, 'TwistFour');
        drawPoint(t4x, t4y, 'P4', ax)
        [X, Y] = calcIntersections(ax);

        [~, ~, ec3] = checkConditions(ax, C);

        if ec3 == 1
            phase = goToPhase(6, ax);
            return
        end



        %Update interface
        set(pt1x, 'String', '')
        set(pt1y, 'String', '')
        set(pt2x, 'String', '')
        set(pt2y, 'String', '')
        set(pt1x, 'Enable', 'off')
        set(pt1y, 'Enable', 'off')
        set(pt2x, 'Enable', 'off')
        set(pt2y, 'Enable', 'off')
        [c1, c2, c3, c4, Cmat] = calcCompliance(X(1,1), Y(1,1), X(1,2), Y(1,2), X(1,3), Y(1,3), X(1,4), Y(1,4));

        Cout = findobj(fig, 'Tag', 'Cout');
        set(Cout, 'Data', Cmat)
        comp1 = findobj(fig, 'Tag', 'comp1');
        comp2 = findobj(fig, 'Tag', 'comp2');
        comp3 = findobj(fig, 'Tag', 'comp3');
        comp4 = findobj(fig, 'Tag', 'comp4');

        C1 = sprintf('%0.4f', c1);
        C2 = sprintf('%0.4f', c2);
        C3 = sprintf('%0.4f', c3);
        C4 = sprintf('%0.4f', c4);

        set(comp1, 'String', C1)
        set(comp2, 'String', C2)
        set(comp3, 'String', C3)
        set(comp4, 'String', C4)

        phase = goToPhase(7, ax);

        

    end 

elseif strcmp(str,'Home')
%% if the user presses Home
    %returns the user to the home screen
    framework()
    
end




end

