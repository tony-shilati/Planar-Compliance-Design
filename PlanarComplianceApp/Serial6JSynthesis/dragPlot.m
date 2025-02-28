function [] = dragPlot(ax, tag, m, x1, y1)

old = findobj(ax, 'Tag', tag);
if ~isempty(old)
    delete(old)
end

if strcmp(tag, 'L1')
    color = [0 0.4470 0.7410];
elseif strcmp(tag, 'L2')
    color = [0.9290 0.6940 0.1250];
elseif strcmp(tag, 'L3')
    color = [0.8500 0.3250 0.0980];
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