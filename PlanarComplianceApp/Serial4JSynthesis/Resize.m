function [] = Resize( obj, ~, ax )
    
    set(ax,'units','normalized');
    
    set(ax,'Position',[0.1, 0.28, 0.8, 0.7])
    
    
    set(ax,'units','pixels');
    axpos = get(ax,'position');
    set(obj,'units','pixels');
    fpos = get(obj,'position');
    
    w = min(axpos(3:4))/2;
    hfw = fpos(3)/2 - w;
    hfh = fpos(4)/2 - w - 10;
    
    hp = findobj('tag','panel');
    
    set(hp,'Position',[hfw hfh 2*w 75]);

    hp = findobj('tag','panelout');
    
    set(hp,'Position',[hfw hfh-80 2*w 75]);
    
end

