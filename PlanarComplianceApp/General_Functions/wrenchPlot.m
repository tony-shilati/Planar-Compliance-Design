function w = wrenchPlot(w, c, sz, tag, parent)

% f = @(x,y) [y, -x, 1]*w;
% 
% fimplicit(f, 'Tag', 'wplot', 'Color', c)

f = @(x) (w(2)*x - w(3)) / w(1);

LineWidth = sz;

if isinf(w(2)/w(1))
    w = w/norm([w(1), w(2)]);
    xv = sign(w(2))*w(3);
    X = [xv, xv];
    Y = [-100, 100];

    hold on
    w = plot(parent, X, Y, 'Tag', 'wplot', 'Color', c, "LineWidth", LineWidth, "Tag", tag);
else
    hold on
    w = fplot(parent, f, 'Tag', 'wplot', 'Color', c, "LineWidth", LineWidth, "Tag", tag);
end

end
