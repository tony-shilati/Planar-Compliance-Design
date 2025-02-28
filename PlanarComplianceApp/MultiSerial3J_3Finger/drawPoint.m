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
        text(x, y, '   C1', 'FontSize', 10, 'Tag', 'text1')
    elseif strcmp(tag(2), '2')
        delete(findobj(ax, 'Tag', 'text2'))
        text(x, y, '   C2', 'FontSize', 10, 'Tag', 'text2')
    elseif strcmp(tag(2), '3')
        delete(findobj(ax, 'Tag', 'text3'))
        text(x, y, '   C3', 'FontSize', 10, 'Tag', 'text3')
    end


    size = 60;
    coli = col(ind,:);
    pick = 'all';
end


if strcmp(tag(1), 'V')
    size = 60;
    coli = [0 0 0];
    colie = coli;
    pick = 'all';
end

if strcmp(tag(1),'t')
    size = 60;
    coli = [0 0 0];
    colie = coli;
    pick = 'none';
end

if strcmp(tag(1:2),'F1')
    if strcmp(tag(4), '1')
        delete(findobj(ax, 'Tag', 'F1J1'))

    elseif strcmp(tag(4), '2')
        delete(findobj(ax, 'Tag', 'F1J2'))

    elseif strcmp(tag(4), '3')
        delete(findobj(ax, 'Tag', 'F1J3'))

    end
    size = 60;
    coli = [0 0.4470 0.7410];
    colie = coli;
    pick = 'all';
end

if strcmp(tag(1:2),'F2')
    if strcmp(tag(4), '1')
        delete(findobj(ax, 'Tag', 'F2J1'))

    elseif strcmp(tag(4), '2')
        delete(findobj(ax, 'Tag', 'F2J2'))

    elseif strcmp(tag(4), '3')
        delete(findobj(ax, 'Tag', 'F2J3'))

    end
    size = 60;
    coli = [0.9290 0.6940 0.1250];
    colie = coli;
    pick = 'all';
end

if strcmp(tag(1:2),'F3')
    if strcmp(tag(4), '1')
        delete(findobj(ax, 'Tag', 'F3J1'))

    elseif strcmp(tag(4), '2')
        delete(findobj(ax, 'Tag', 'F3J2'))

    elseif strcmp(tag(4), '3')
        delete(findobj(ax, 'Tag', 'F3J3'))

    end
    size = 60;
    coli = [0.8500 0.3250 0.0980];
    colie = coli;
    pick = 'all';
end

if length(tag) == 5
    size = 60;
    coli = 'r';
    colie = coli;
    pick = 'all';
end




pt = scatter(ax,x,y,'filled','markerfacecolor',coli,'markeredgecolor',colie...
    ,'tag',tag,'sizedata',size,'PickableParts',pick);
if strcmp(tag(1), 'F')
    uistack(pt, 'top')
end
set(pt,'ButtonDownFcn',{@MouseClick,ax});
set(pt,'linewidth',1.2);

end

