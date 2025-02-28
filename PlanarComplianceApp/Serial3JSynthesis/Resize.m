function [] = Resize( obj, ~, ax )
    
    set(ax,'units','normalized');
    
    set(ax,'Position',[0.1, 0.18, 0.8, 0.8])
    
    
    set(ax,'units','pixels');
    axpos = get(ax,'position');
    set(obj,'units','pixels');
    fpos = get(obj,'position');
    
    w = min(axpos(3:4))/2;
    hfw = fpos(3)/2 - w;
    hfh = fpos(4)/2 - w - 50;
    
    hp = findobj('tag','panel');
    
    set(hp,'Position',[hfw hfh 2*w 60]);

end

