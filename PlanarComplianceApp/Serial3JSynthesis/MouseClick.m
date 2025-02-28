function [] = MouseClick( obj, ~, ax)

global phase drag1 drag2 func C gdeData3J   %Sets global vars

%Gets the Figure objects
fig = get(ax, 'Parent'); 
gde = findobj(0, 'Tag', 'fig2');

%Gets the text box object that displays the guide message
msg = findobj(gde, 'Tag', 'msg');


[x,y] = getCurrentXY(ax);               %finds the x and y of the cursor             
Xx = findobj(fig, 'tag', 'Jx');      %Finds the x input box 
Yy = findobj(fig, 'tag', 'Jy');      %Finds the y input box

if strcmp(get(obj,'type'),'figure')
    %% Updates the UI when the user clicks on the axes
    
    ylim = get(ax,'ylim');      %gets the y limit of the axes
    xlim = get(ax,'xlim');      %gets the x limit of the axes
    

    %Makes sure that the cursor is within the axes
    if phase == 0 && y < ylim(2) && y > ylim(1) && x < xlim(2) && x > xlim(1)
        hold on;
        drawPoint(x,y,'point1',ax);        %Draws joint 1 where the user clicked
        phase = 1;                         %Updates the phase
        
        
        set(Xx, 'String', '');             %Sets x input box to be blank
        set(Yy, 'String', '');             %Sets y input box to be blank

        Xtext = findobj(fig, 'tag', 'JX'); %Finds the label of the x input
        Ytext = findobj(fig, 'tag', 'JY'); %Finds the label of the y input

        set(Xtext, 'String', 'Joint 2 X-Coordinate'); %Updates the x label
        set(Ytext, 'String', 'Joint 2 Y-Coordinate'); %Updates the y label

        
        %Updates the prompt message
        set(msg, 'String', gdeData3J.msg2);
        set(msg, 'FontSize', 0.04)
    end

%Checks to see if the user clicked on point 1
elseif strcmp(get(obj,'tag'),'point1')
    %% Updates the UI when the user clicks on joint 1
    if phase == 1
        drag1 = 1;      %If phase is 1 this allows point 1 to be dragged
        %drawPoint(x,y,'point1',ax);
        phase = 1;
    elseif phase == 2
        
        drag1 = 1;      %If phase is 2 this allows point 1 to be dragged


        jh = findobj(fig,'tag','jout');      %Finds the output table 
        Jout = get(jh,'Data');                %Gets the data from the table

        %Updates data from the output table 
        Jout{1,2} = '';
        Jout{1,3} = '';
        Jout{1,4} = '';

        Jout{2,2} = '';
        Jout{2,3} = '';
        Jout{2,4} = '';
        set(jh,'Data',Jout);        %Sets the updated data

        drawPoint([],[],'point2',ax);
        drawPoint([],[],'point3',ax);
        gg = findobj('tag','link');
        delete(gg);
        delete(findobj(ax, 'Tag', 'J2'))
        delete(findobj(ax, 'Tag', 'J3'))

        Cout = findobj(fig, 'Tag', 'Cout');
        set(Cout, 'Data', {'', '', ''; '', '', ''; '', '', ''})

        j1 = findobj(fig, 'Tag', 'comp1');
        j2 = findobj(fig, 'Tag', 'comp2');
        j3 = findobj(fig, 'Tag', 'comp3');
        j1.String = '';
        j2.String = '';
        j3.String = '';
        
        %drawPoint(x,y,'point1',ax);
        phase = 1;
        
    end
    
%Checks to see if the user clicked on the line
elseif strcmp(get(obj,'tag'),'line')
    %% Updates the UI when the user clicks on the line
    if phase == 1
        %If the phase is 1 this draws point two on line where user clicked
        y = func(x);
        drawPoint(x,y,'point2',ax);         
        
        [x2,y2] = generateJ3(x,y,C,func);     %calculates x and y of pt 3
        drawPoint(x2,y2,'point3',ax);     %draws pt 3 on axes
        
        phase = 2;                        %Sets phase to 2

        set(msg, 'String', gdeData3J.msg3)
        set(msg, 'FontSize', 0.04)


    elseif phase == 2
        drag2 = 1;                        %allows point 2 to be dragged
        y = func(x);
        drawPoint(x,y,'point2',ax);       %Draws point 2 where the user clicked
        
        [x2,y2] = generateJ3(x,y,C,func);     %Calculates the location of pt 3
        drawPoint(x2,y2,'point3',ax);     %plots pt 3
        phase = 2;

        
    end
    
elseif strcmp(get(obj,'tag'),'point2')
    %% Updates the UI when the user clicks on point 2. 
    if phase == 1
        
    elseif phase == 2
        drag2 = 1;
    end
end

end
