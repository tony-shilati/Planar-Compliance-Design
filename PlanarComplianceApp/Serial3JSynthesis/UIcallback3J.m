function [ ] = UIcallback3J( obj, ~, ax, str )

global phase C x1 y1 gdeData3J

%Acceses the object for each of the figures
fig = get(ax, 'Parent');
gde = findobj(0, 'Tag', 'fig2');
msg = findobj(gde, 'Tag', 'msg');



%% Resets the interface
if strcmp(str,'reset')
    phase = 0;
    
    %Resets the plot
    delete(get(ax,'Children'));
    scatter(ax, 0,0,'+','markerfacecolor',[0 0 0],'sizedata',120,'markeredgecolor',[0 0 0]);
    
    try
    [x,y] = compliantCenter(C, ax);
    scatter(ax, x,y,'*','markerfacecolor','red','sizedata',100,'markeredgecolor','red','tag','cpoint');
    catch
    end

    %Ressets the input pannel
    set(obj,'value',0);
    mnulx = findobj(fig, 'tag', 'Jx');
    mnuly = findobj(fig, 'tag', 'Jy');
    set(mnulx, 'enable', 'on');
    set(mnuly, 'enable', 'on');

    xlab = findobj(fig, 'tag', 'JX');
    ylab = findobj(fig, 'tag', 'JY');
    xpos = findobj(fig, 'tag', 'xpos');
    ypos = findobj(fig, 'tag', 'ypos');

    set(xlab, 'String', 'Joint 1 X-Coordinate');
    set(ylab, 'String', 'Joint 1 Y-Coordinate');
    set(xpos, 'String', '');
    set(ypos, 'String', '');

    Xx = findobj(fig, 'tag', 'Jx');
    Yy = findobj(fig, 'tag', 'Jy');
    set(Xx, 'String', '');
    set(Yy, 'String', '');

    %Resets the guide message pannel 
    set(msg, 'string', gdeData3J.msg1);
    set(msg, 'FontSize', 0.0275)


    %Resets the output panel
    comp1 = findobj(fig, 'Tag', 'comp1');
    comp2 = findobj(fig, 'Tag', 'comp2');
    comp3 = findobj(fig, 'Tag', 'comp3');

    set(comp1, 'String', '');
    set(comp2, 'String', '');
    set(comp3, 'String', '');


    jdata = findobj(fig, 'tag', 'jout');

    try
    [cx,cy] = compliantCenter(C, ax);
    Jout = {sprintf('%0.2f', cx),'','','';
            sprintf('%0.2f', cy),'','',''};
    set(jdata, 'Data', Jout);
    catch
    end


    Cout = findobj(fig, 'Tag', 'Cout');
    set(Cout, 'Data', {'', '', ''; '', '', ''; '', '', ''})

    
elseif strcmp(str, 'open_gde')
    %% opens the guide window
    guide3J()
    gde = findobj(0, 'Tag', 'fig2');
    msg = findobj(gde, 'Tag', 'msg');

    if phase == 1
        set(msg, 'String', gdeData3J.msg2)
        set(msg, 'FontSize', 0.04)

    elseif phase == 2
        set(msg, 'String', gdeData3J.msg3)
        set(msg, 'FontSize', 0.04)

    end



elseif strcmp(str,'dim')
%% Updates the axes 
    
    val = str2double(get(obj,'string'));
    
    set(ax,'xlim',[-val, val]);
    set(ax,'ylim',[-val, val]);

    %Extends line to new axis bouds
    compliantCenter(C, ax);

    [j1x, j1y] = grabData('point1', ax);
    if ~isempty(j1x) && ~isempty(j1y)
        drawLine(j1x, j1y, ax)
    end

   
elseif strcmp(str,'c')
%% Updates the Compliance matrix
    C = get(obj,'Data');
    
    ch = findobj('tag','cpoint');
    if ~isempty(ch)
       delete(ch); 
    end
    
    try
    [x,y,C] = compliantCenter(C, ax);
    scatter(ax, x,y,'*','markerfacecolor', ...
        'red','sizedata',100,'markeredgecolor', ...
        'red','tag','cpoint');
    catch
    end


    ch = findobj('tag','line');
    if ~isempty(ch)
       delete(ch); 
       drawLine(x1,y1,ax);
    end
elseif strcmp(str,'Home')
%% Reopens the home page
    framework()
elseif strcmp(str, 'Submit')
%% Updates teh interface when submit is pressed
    Xx = findobj(fig, 'tag', 'Jx');
    X = str2double(Xx.String);
    Yy = findobj(fig, 'tag', 'Jy');
    Y = str2double(Yy.String);
    cordBox(X, Y, ax);

    set(Xx, 'String', '');
    set(Yy, 'String', '');

    Xtext = findobj(fig, 'tag', 'JX');
    Ytext = findobj(fig, 'tag', 'JY');

    set(Xtext, 'String', 'Joint 2 X-Coordinate');
    set(Ytext, 'String', 'Joint 2 Y-Coordinate');

    



end
        
end



