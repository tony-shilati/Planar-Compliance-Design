function [ ] = drawLine( x, y, tag, ax)

pt = findall(ax,'tag',tag);

if ~isempty(pt)
    delete(pt);
end

if x(1) == x(2)
   x(1) = x(1) + 1e-20; 
end

m = (y(2)-y(1))/(x(2)-x(1)); % Calculate Slope
b = (y(1) - (m*x(1))); % Calculate Y-intercept

yfun = @(x) m*x + b;

xlim = get(ax,'xlim');

yval = yfun(xlim);

if isinf(m)
    yval = get(ax,'ylim');
    xlim = x;
end

pick = 'all';
fmt = '-';
width = 2;

if strcmp(tag(1), 'L')
    ind = str2num(tag(2));
    col = zeros(4,3);
    col(1,:) = [0.2 0.6 1];
    col(2,:) = [0.3 0.9 0.3];
    col(3,:) = [0.9 0.3 0.3];
    col(4,:) = [0.9290 0.6940 0.1250];
    col(5,:) = [0.6 0.6 0.6];
    color = col(ind,:);
    width = 2;
end


if strcmp(tag(1),'V')
   fmt = '--';
   color = [0,0,0];
end

if strcmp(tag(1),'W')
   width = 2;
   color = [0,0,0]; 
end

if strcmp(tag, 'PL')
    color = [0.5 0.5 0.5];
    fmt = '--';
    width = 2;
end


if strcmp(tag, 'cone1') || strcmp(tag, 'cone2')
    color = 'r';
    width = 0.05;
end

if strcmp(tag(1), 'l')
    fmt = '-';
    width = 3;
    color = [0 0 0];
    pick = 'none';
    xlim = x;
    yval = y;

end


pl = plot(ax,xlim,yval,fmt,'tag',tag,'linewidth',width,'color',color, 'PickableParts', pick);
set(pl,'ButtonDownFcn',{@MouseClick,ax});
if strcmp(tag(1), 'l')
    uistack(pl, 'top')
else
    uistack(pl, 'bottom')
end


end

