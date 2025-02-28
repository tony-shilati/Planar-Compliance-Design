function [] = drawCircle(ax, r, x, y, tag)

circ = findobj(ax, 'Tag', tag);
if ~isempty(circ)
    delete(circ)
end

theta = 0:0.01:2*pi;
xp = r*cos(theta);
yp = r*sin(theta);

if strcmp(tag(4), '1')
    color = 'b';
else
    color = [0 0 0];
end


circ = plot(ax, x+xp, y+yp, 'LineWidth', 0.05, 'Color', color, 'Tag', tag);
set(circ, 'ButtonDownFcn', {@MouseClick, ax})
uistack(circ, 'bottom')


end