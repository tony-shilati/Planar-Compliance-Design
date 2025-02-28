function [ ] = drawPoint( x, y, tag, ax)

pt = findobj(ax,'tag',tag);

if ~isempty(pt)
    delete(pt);
end

size = 60;
coli = [0.95 0.95 0.95];
colie = [0.1 0.1 0.1];
pick = 'all';

if strcmp(tag(1),'P')
    ind = str2num(tag(2));
    col = zeros(3,3);
    col(1,:) = [0 0 0];
    col(2,:) = [0 0 0];
    col(3,:) = [0 0 0];

    if strcmp(tag(2), '1')
        delete(findobj(ax, 'Tag', 'text1'))
        text(x, y, '   T12', 'FontSize', 10, 'Tag', 'text1')
    elseif strcmp(tag(2), '2')
        delete(findobj(ax, 'Tag', 'text2'))
        text(x, y, '   T34', 'FontSize', 10, 'Tag', 'text2')
    elseif strcmp(tag(2), '3')
        delete(findobj(ax, 'Tag', 'text3'))
        text(x, y, '   T56', 'FontSize', 10, 'Tag', 'text3')
    end


    size = 60;
    coli = col(ind,:);
    pick = 'all';
end



if strcmp(tag(1),'N')
   coli = [0.9 0.9 0.9];
   pick = 'all';
end

if strcmp(tag(1),'t')
    size = 60;
    coli = [0 0 0];
    colie = coli;
    pick = 'none';
end

if strcmp(tag(1),'J')
    size = 60;
    coli = "#4a708b";
    colie = coli;
    pick = 'none';
end


pt = scatter(ax,x,y,'filled','markerfacecolor',coli,'markeredgecolor',colie...
    ,'tag',tag,'sizedata',size,'PickableParts',pick);
set(pt,'ButtonDownFcn',{@MouseClick,ax});
set(pt,'linewidth',1.2);

end

