function [ XData, YData ] = grabData(tag,ax)

h = findobj(ax,'tag',tag);

XData = get(h,'XData');
YData = get(h,'YData');

end

