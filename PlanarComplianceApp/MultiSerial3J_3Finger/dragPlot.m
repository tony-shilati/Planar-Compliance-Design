function [] = dragPlot(ax, tag, m, x1, y1)

global phase

old = findobj(ax, 'Tag', tag);
if ~isempty(old)
    delete(old)
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

ind = str2num(tag(2));
col = zeros(4,3);
col(1,:) = [0 0.4470 0.7410];
col(3,:) = [0.8500 0.3250 0.0980];
col(2,:) = [0.9290 0.6940 0.1250];
col(4,:) = [0.4940 0.1840 0.5560];
col(5,:) = [0.4660 0.6740 0.1880];
col(6,:) = [0.3010 0.7450 0.9330];

color = col(ind,:);
fmt = '-';
width = 2;

plt = plot(ax,X, line, 'Color', color, 'Tag', tag, 'LineWidth', 2, 'PickableParts','all');
set(plt, 'ButtonDownFcn', {@MouseClick, ax})
uistack(plt, 'bottom')
uistack(plt,'up', 1)
if phase > 7
    uistack(plt,'up', 4)
end


end