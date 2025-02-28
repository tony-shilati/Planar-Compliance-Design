function [] = drawCircle(ax, r, x, y, tag, c)

circ = findobj(ax, 'Tag', tag);
if ~isempty(circ)
    delete(circ)
end

theta = 0:0.01:2*pi;
xp = r*cos(theta);
yp = r*sin(theta);

if c == 0
    color = 'b';
elseif c == 1
    color = [0 0 0];
end


circ = plot(ax, x+xp, y+yp, 'LineWidth', 0.05, 'Color', color, 'Tag', tag);
set(circ, 'ButtonDownFcn', {@MouseClick, ax})
uistack(circ, 'bottom')


end