function [] = drawPoint(x, y, str, ax)

pt = findobj(ax, 'Tag', str);
if ~isempty(pt)
    delete(pt)
end

if strcmp(str(1), 'J')
    color = [0 0 0];
    size = 75;
end

if strcmp(str(1), 'P')
    col = zeros(3,3);
    col(1,:) = [0 0.4470 0.7410];
    col(2,:) = [0.9290 0.6940 0.1250];
    col(3,:) = [0.4940 0.1840 0.5560];
    col(4,:) = [0.4660 0.6740 0.1880];
    
    ind = str2double(str(2));
    color = col(ind,:);
    size = 60;
end

if strcmp(str(1), 'T')
    color = 'r';
    size = 60;
end


sct = scatter(ax, x, y, size, 'filled', 'Tag', str, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor', color, 'PickableParts', 'all');
set(sct, 'ButtonDownFcn', {@MouseClick, ax})
uistack(sct, 'top')

end