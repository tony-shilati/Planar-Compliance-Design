function [] = drawLine(ax, tag, x, y)

lin = findobj(ax, 'Tag', tag);
if ~isempty(lin)
    delete(lin)
end

m = (y(1) - y(2)) / (x(1) - x(2));
b = y(1) - m*x(1);

func = @(x) m*x + b;
xlim = get(ax, 'xlim');
yval = func(xlim);

if isinf(m)
    xlim = x;
    yval = get(ax, 'ylim');
end

if strcmp(tag(1), 'L')
    col = zeros(3,3);
    col(1,:) = [0 0.4470 0.7410];
    col(2,:) = [0.9290 0.6940 0.1250];
    col(3,:) = [0.4940 0.1840 0.5560];

    ind = str2double(tag(2));

    color = col(ind,:);

    width = 2;
end

if strcmp(tag(1), 'C')
    yval = y;
    xlim = x;

    color = [0 0 0];
    width = 3;
end


pl = plot(ax, xlim, yval, 'LineWidth', width, 'Color', color, 'PickableParts', 'all', 'Tag', tag);
set(pl, 'ButtonDownFcn', {@MouseClick, ax})
uistack(pl, 'bottom')

if strcmp(tag(1), 'C')
    uistack(pl, 'top')
end


end