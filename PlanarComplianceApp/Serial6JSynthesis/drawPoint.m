function [] = drawPoint(ax, str, x, y)

pt = findobj(ax, 'Tag', str);
if ~isempty(pt)
    delete(pt)
end

if strcmp(str(1), 'N')
    color = [0.95, 0.95, 0.95];
    size = 60;

    if strcmp(str(2), '1')
        size = 30;
    end
end 

if strcmp(str(1), 'P')
    col = zeros([2 3]);
    col(1,:) = [0 0.4470 0.7410];
    col(2,:) = [0.9290 0.6940 0.1250];
    ind = str2double(str(2));
    color = col(ind,:);
    size = 60;
end

if strcmp(str(1), 'J')
    color = [0 0 0];
    size  = 75;
end

sc = scatter(ax, x, y, size, 'filled', 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor', color, 'Tag', str, 'PickableParts', 'all');
uistack(sc, 'top')
set(sc, 'ButtonDownFcn', {@MouseClick, ax})


end