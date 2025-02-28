function [] = UIcallback3S(obj, ~, ax, str)

global K phase gdeData3S drag1

%% gets all nessecary objects
fig = get(ax, 'Parent');

gde = findobj(0, 'Tag', 'fig2');
msg = findobj(gde, 'Tag', 'msg');

point1x = findobj(fig, 'Tag', 'pt1x');
point1y = findobj(fig, 'Tag', 'pt1y');
point2x = findobj(fig, 'Tag', 'pt2x');
point2y = findobj(fig, 'Tag', 'pt2y');

point1X = str2double(get(point1x, 'String'));
point1Y = str2double(get(point1y, 'String'));
point2X = str2double(get(point2x, 'String'));
point2Y = str2double(get(point2y, 'String'));


if strcmp(str, 'reset')
%% if the user clicks reset    
    phase = 0;

    %Remove everything from the axes and replace the origin marker
    delete(findobj(fig, 'Tag', 'leg'))
    delete(get(ax, 'Children'))
    scatter(0,0,'+','markerfacecolor',[0 0 0],'sizedata', ...
        120,'markeredgecolor',[0 0 0]);

    %Replace the Compliant Center
    try
        [x,y] = stiffnessCenter(K, ax);
        scatter(x,y,'*','markerfacecolor','red','sizedata',100, ...
            'markeredgecolor','red','tag','cpoint');
    catch
    end

    set(obj,'value',0);


    %sets the x and y coordinate box to be blank
    xpos = findobj(fig, 'Tag', 'xpos');
    ypos = findobj(fig, 'Tag', 'ypos');
    set(xpos, 'String', '');
    set(ypos, 'String', '');

    %set the input box for the point coordinates to be balnk 
    set(point1x, 'String', '')
    set(point1y, 'String', '')
    set(point2x, 'String', '')
    set(point2y, 'String', '')
    set(point1x, 'Enable', 'on')
    set(point1y, 'Enable', 'on')
    set(point2x, 'Enable', 'on')
    set(point2y, 'Enable', 'on')

    %Sets the output panel to be blank
    l = 1;
    while l < 4
        set(findobj(fig, 'Tag', ['lin' num2str(l)]), 'String', '')
        set(findobj(fig, 'Tag', ['wrench' num2str(l)]), 'String', '')
        set(findobj(fig, 'Tag', ['stiff' num2str(l)]), 'String', '')

        l = l+1;
    end

    %Reset the guide message
    set(msg, 'String', gdeData3S.msg1)
    set(msg, 'FontSize', 0.026)

    %Resets the calculated matrix output
    Kout = findobj(fig, 'Tag', 'Kout');
    set(Kout, 'Data', {'', '', ''; '', '', ''; '', '', ''})

elseif strcmp(str, 'dim')
    %% Resizes the axes
    val = str2double(get(obj,'string'));
    
    set(ax,'xlim',[-val, val]);
    set(ax,'ylim',[-val, val]);

    [x, y, K] = stiffnessCenter(K, ax);


    %Updates lines to fit new axes
    [l1x, l1y] = grabData('line1', ax);
    [l2x, l2y] = grabData('line2', ax);
    [l3x, l3y] = grabData('line3', ax);

    %line 1
    if ~isempty(l1x) && ~isempty(l1y)
        m1 = (l1y(2) - l1y(1)) / (l1x(2) - l1x(1));
        plotLine(ax, 'line1', m1, l1x(1), l1y(1))

    end
    
    %line 2
    if ~isempty(l2x) && ~isempty(l2y)
        m2 = (l2y(2) - l2y(1)) / (l2x(2) - l2x(1));
        plotLine(ax, 'line2', m2, l2x(1), l2y(1))

    end

    %line 3
    if ~isempty(l3x) && ~isempty(l3y)
        m3 = (l3y(2) - l3y(1)) / (l3x(2) - l3x(1));
        plotLine(ax, 'line3', m3, l3x(1), l3y(1))

    end



elseif strcmp(str, 'open_gde')
    %%
    guide3S()
    gde = findobj(0, 'Tag', 'fig2');
    msg = findobj(gde, 'Tag', 'msg');

    if phase == 0
        set(msg, 'String', gdeData3S.msg1)
        set(msg, 'FontSize', 0.026)

    elseif phase == 0.5
        set(msg, 'String', gdeData3S.msg2)
        set(msg, 'FontSize', 0.04)

    elseif phase == 1
        set(msg, 'String', gdeData3S.msg3)
        set(msg, 'FontSize', 0.04)

    elseif phase == 2
        set(msg, 'String', gdeData3S.msg4)
        set(msg, 'FontSize', 0.04)

    end


elseif strcmp(str, 'Submit')
%% If the user clicks submit
    %resizes the axes
    scalar = findobj(fig, 'Tag', 'dim');
    val  = str2double(scalar.String);
    set(ax, 'Xlim', [-val val])
    set(ax, 'Ylim', [-val val])

    if phase == 0
        
        
        if isnan(point1X) || isnan(point1Y)
            warndlg(['Invalid Entry: Enter an X and Y ' ...
                'coordinate for each point'], '', 'modal')
         
        else
            %Plots the first point
            drawHandle(ax, 'handle1', point1X, point1Y)

            try
                drawHandle(ax, 'handle2', point2X, point2Y)
            catch 
            end

            if ~isnan(point2X) && ~isnan(point2Y)
                %plot the first line 
                hndl1 = findobj(ax, 'Tag', 'handle1');
                x1 = hndl1.XData;
                y1 = hndl1.YData;

                hndl2 = findobj(ax, 'Tag', 'handle2');
                x2 = hndl2.XData;
                y2 = hndl2.YData;

                m1 = (y2 - y1)/(x2 - x1);
                b1 = y1 - m1*x1;

                plotLine(ax, 'line1', m1, x1, y1)

                %outputs the line equaation to user 
                eqnOutput(ax, 'line1', m1, b1)
                %Calculates the twist associated with the first wrench and plots
                %the instantaneous center of the twist
                [tx1, ty1] = calcTwist(ax, 'TwistOne');
                drawPoint(tx1, ty1, 'point2', ax)

                set(point1x, 'String', tx1)
                set(point1y, 'String', ty1)
                set(point1x, 'Enable', 'off')
                set(point1y, 'Enable', 'off')
                set(point2x, 'String', '')
                set(point2y, 'String', '')
                set(msg, 'String', gdeData3S.msg3)
                set(msg, 'FontSize', 0.04)

                phase = 1;
            
            %Change the phase and updates the interface
            elseif isnan(point2X) || isnan(point2Y)
                phase = 0.5;
                set(point1x, 'Enable', 'off')
                set(point1y, 'Enable', 'off')
                set(point2x, 'String', '')
                set(point2y, 'String', '')
                set(msg, 'String', gdeData3S.msg2)
                set(msg, 'FontSize', 0.04)

            end
            

        end 

    elseif phase == 0.5
        drawHandle(ax, 'handle2', point2X, point2Y)

        %plot the first line 
        hndl1 = findobj(ax, 'Tag', 'handle1');
        x1 = hndl1.XData;
        y1 = hndl1.YData;

        hndl2 = findobj(ax, 'Tag', 'handle2');
        x2 = hndl2.XData;
        y2 = hndl2.YData;

        m1 = (y2 - y1)/(x2 - x1);
        b1 = y1 - m1*x1;

        plotLine(ax, 'line1', m1, x1, y1)

        %outputs the line equaation to user 
        eqnOutput(ax, 'line1', m1, b1)
        %Calculates the twist associated with the first wrench and plots
        %the instantaneous center of the twist
        [tx1, ty1] = calcTwist(ax, 'TwistOne');
        drawPoint(tx1, ty1, 'point2', ax)

        set(point1x, 'String', tx1)
        set(point1y, 'String', ty1)
        set(point1x, 'Enable', 'off')
        set(point1y, 'Enable', 'off')
        set(point2x, 'String', '')
        set(point2y, 'String', '')
        set(msg, 'String', gdeData3S.msg3)
        set(msg, 'FontSize', 0.04)

        phase = 1;
  
    elseif phase == 1

        %plots the second line 
        drawHandle(ax, 'handle3', point2X, point2Y)
           
        pt2 = findobj(ax, 'Tag', 'point2');
        x2 = get(pt2, 'XData');
        y2 = get(pt2, 'YData');
            
        pt3  = findobj(ax, 'Tag', 'handle3');
        x3 = pt3.XData;
        y3 = pt3.YData;

        vec2X = (x3 - x2);
        vec2Y = (y3 - y2);

        m2 = vec2Y/vec2X;
        b2 = y2 - m2*x2;
    
        plotLine(ax, 'line2', m2, x2, y2)
        eqnOutput(ax, 'line2', m2, b2)
    
    
        %calculates and plots twist two instantaneous center
        [tx2, ty2] = calcTwist(ax, 'TwistTwo');
        drawPoint(tx2, ty2, 'point3', ax)
    
        %calculates and plots third line
        twist1 = findobj(ax, 'Tag', 'point2');
        twist2 = findobj(ax, 'Tag', 'point3');
    
        line3x = [twist1.XData, twist2.XData];
        line3y = [twist1.YData, twist2.YData];
    
        %calculates slope of line 3
        m3 = (line3y(1,2) - line3y(1,1)) / (line3x(1,2) - line3x(1,1));
        b3 = line3y(1,2) - m3*line3x(1,2);
    
    
        plotLine(ax, 'line3', m3, twist2.XData, twist2.YData)
    
        eqnOutput(ax, 'line3', m3, b3)
    
        %Draws point 3
        [twist3x, twist3y] = calcTwist(ax, 'TwistThree');
        drawPoint(twist3x, twist3y, 'point4', ax)
    
           
        %Creates a legend 
        leg = legend( '', '', '', 'Spring Axis 3', 'Spring Axis 2', 'Spring Axis 1');
        set(leg, 'Tag', 'leg')
        set(leg, 'AutoUpdate', 'off')

        
        Kmat = calcStiffness(ax);
        Kout = findobj(fig, 'Tag', 'Kout');
        set(Kout, 'Data', Kmat)

        %updates phase and interface
        phase = 2;


        %updates phase and interface
        set(point1x, 'String', '')
        set(point1y, 'String', '')
        set(point2x, 'String', '')
        set(point2y, 'String', '')
        set(point2x, 'Enable', 'off')
        set(point2y, 'Enable', 'off')

        set(msg, 'String', gdeData3S.msg4)
        set(msg, 'FontSize', 0.04)




    elseif phase == 2
        
    end 


elseif strcmp(str, 'k')
%% If the user updates the Stiffness table
    %Sets the value of K to the data in the table 
    K = get(obj,'Data');

    %looks for the the compliant center on the graph
    ch = findobj('tag','cpoint');
    %if the compliant center is not empty it will be deleted
    if ~isempty(ch)
       delete(ch); 
    end
    %gets the new compliant center and plots it
    try
        [x,y,K] = stiffnessCenter(K, ax);
        scatter(x,y,'*','markerfacecolor', ...
            'red','sizedata',100,'markeredgecolor', ...
            'red','tag','cpoint');
    catch
    end

    phase = 1;

elseif strcmp(str,'Home')
%% If The user clicks the home button
    %returns the user to the home screen
    framework()
end


end
        