function [ ] = drawLine( x, y, tag, ax)

pt = findall(ax,'tag',tag);

if ~isempty(pt)
    delete(pt);
end

if x(1) == x(2)
   x(1) = x(1) + 1e-20; 
end

m = (y(2)-y(1))/(x(2)-x(1)); % Calculate Slope

if isinf(m)
    yval = get(ax,'ylim');
    xlim = [x(1), x(2)];
else
    b = (y(1) - (m*x(1))); % Calculate Y-intercept
    yfun = @(x) m*x + b;
    xlim = get(ax,'xlim');
    yval = yfun(xlim);
end

if strcmp(tag(1), 'L')
    ind = str2double(tag(2));
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
    pick = 'all';
end

if strcmp(tag(1), 'C')
    fmt = '-';
    width = 3;
    color = [0 0 0];
    pick = 'none';
    xlim = x;
    yval = y;

end

if strcmp(tag(1), 'D')
    fmt = '--';
    width = 1;
    if strcmp(tag(2), '1') || strcmp(tag(2), '2')
        color = [0 0.4470 0.7410];
    elseif strcmp(tag(2), '3') || strcmp(tag(2), '4')
        color = [0.9290 0.6940 0.1250];
    end
    pick = 'all';
    xlim = x;
    yval = y;
end



pl = plot(ax,xlim,yval,fmt,'tag',tag,'linewidth',width,'color',color, 'PickableParts', pick);
set(pl,'ButtonDownFcn',{@MouseClick,ax});
uistack(pl,'bottom');

if strcmp(tag(1), 'C')
    uistack(pl,'top');
end

end

