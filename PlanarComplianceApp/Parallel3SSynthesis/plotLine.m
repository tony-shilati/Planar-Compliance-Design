function [] = plotLine(ax, tag, m, x1, y1)

old = findobj(ax, 'Tag', tag);
if ~isempty(old)
    delete(old)
end

if strcmp(tag, 'line1')
    color = '#5DB5F8';
    lw = 2;
elseif strcmp(tag, 'line2')
    color = '#77AC30';
    lw = 2;
elseif strcmp(tag, 'line3')
    color = '#A2142F';
    lw = 2;
elseif strcmp(tag, 'cone1') || strcmp(tag, 'cone2')
    color = 'r';
    lw = 0.1;
end 


X = get(ax, 'xlim');

line = m*(X-x1) + y1;

if isinf(m)
    X = [x1, x1];
    line = get(ax, 'ylim');
end

plt = plot(X, line, 'Color', color, 'Tag', tag, 'LineWidth', lw);
set(plt, 'ButtonDownFcn', {@MouseClick, ax})
uistack(plt, 'bottom')


end