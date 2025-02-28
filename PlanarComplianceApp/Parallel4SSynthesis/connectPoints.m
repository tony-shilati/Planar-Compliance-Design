function [ ] = connectPoints(tag1, tag2, ax)

[x1,y1] = grabData(tag1,ax);
[x2,y2] = grabData(tag2,ax);

pt = findall(ax,'tag','V1');

if ~isempty(pt)
    delete(pt);
end

%drawLine([x1,x2],[y1,y2],'V1',ax);

tag = 'V1';
color = [0.3,0.3,0.3];

h = plot([x1,x2],[y1,y2],'--','tag',tag,'linewidth',1.5,'color',color);
uistack(h,'bottom');

end

