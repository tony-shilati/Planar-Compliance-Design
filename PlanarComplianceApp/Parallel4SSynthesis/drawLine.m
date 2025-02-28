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

ind = str2num(tag(2));
col = zeros(4,3);
col(1,:) = [0.2 0.6 1];
col(2,:) = [0.3 0.9 0.3];
col(3,:) = [0.9 0.3 0.3];
col(4,:) = [0.9 0.9 0.3];

color = col(ind,:);
fmt = '-';

l = 2;

if strcmp(tag(1),'V')
   fmt = '--';
   color = [0,0,0];
end

if strcmp(tag(1),'W')
    fmt = '-';
    ind = str2num(tag(2));
    wcol = zeros(4,3);
    wcol(1,:) = [0.3010 0.7450 0.9330];
    wcol(2,:) = [0.9290 0.6940 0.1250];
    wcol(3,:) = [0.6350 0.0780 0.1840];
    wcol(4,:) = [0.4940 0.1840 0.5560];

    color = wcol(ind,:);
end

pl = plot(ax, xlim,yval,fmt,'tag',tag,'linewidth',l,'color',color);
%plthin = plot(xlim,yval,'-','tag',tag,'linewidth',1,'color',[0.9 0.9 0.3]);
set(pl,'ButtonDownFcn',{@MouseClick,ax});
uistack(pl,'bottom');


end

