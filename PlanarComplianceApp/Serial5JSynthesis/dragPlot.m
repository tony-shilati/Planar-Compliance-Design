function [] = dragPlot(ax, tag, m, x1, y1)

old = findobj(ax, 'Tag', tag);
if ~isempty(old)
    delete(old)
end

if strcmp(tag, 'L1')
    color = [0.2 0.6 1];
elseif strcmp(tag, 'L2')
    color = [0.3 0.9 0.3];
elseif strcmp(tag, 'L3')
    color = [0.9 0.3 0.3];
end


fig = get(ax, 'Parent');
scalar = findobj(fig, 'Tag', 'dim');
scalarstr = get(scalar, 'String');
scalarnum = str2double(scalarstr);
X = -scalarnum:scalarnum/5:scalarnum;

line = m*(X-x1) + y1;

if isinf(m)
    X = [x1, x1];
    line = get(ax, 'ylim');
end

plt = plot(ax,X, line, 'Color', color, 'Tag', tag, 'LineWidth', 2, 'PickableParts','all');
set(plt, 'ButtonDownFcn', {@MouseClick, ax})
uistack(plt, 'bottom')


end