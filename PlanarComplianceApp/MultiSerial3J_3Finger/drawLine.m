function [ ] = drawLine( x, y, tag, ax)

global phase

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

if phase < 12
    ind = str2num(tag(2));
    col = zeros(4,3);
    col(1,:) = [0 0.4470 0.7410];
    col(2,:) = [0.9290 0.6940 0.1250];
    col(3,:) = [0.8500 0.3250 0.0980];
    col(4,:) = [0.4940 0.1840 0.5560];
    col(5,:) = [0.4660 0.6740 0.1880];
    col(6,:) = [0.3010 0.7450 0.9330];

    color = col(ind,:);

end
width = 2;



if strcmp(tag(1), 'r')
    color = 'g';
end

if strcmp(tag(1), 'l')
    color = 'r';
end




if strcmp(tag, 'cone1') || strcmp(tag, 'cone2')
    color = 'r';
    width = 0.05;
end


pl = plot(ax,xlim,yval,'tag',tag,'linewidth',width,'color',color, 'PickableParts', 'all');
set(pl,'ButtonDownFcn',{@MouseClick,ax});
uistack(pl,'bottom');
uistack(pl, "up", 1)

if phase > 7
    uistack(pl,'up', 4)
end



end

