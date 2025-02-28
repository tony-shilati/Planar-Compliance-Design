function [ ] = drawPoint( x, y, tag, ax)
%for 4 Spring synthesis
pt = findobj(ax,'tag',tag);

if ~isempty(pt)
    delete(pt);
end

size = 60;
coli = [0.95 0.95 0.95];
colie = [0.3 0.3 0.3];

if strcmp(tag,'N1')
  coli = [0.2 0.6 1];
elseif strcmp(tag,'N2')
  coli = [0.3 0.9 0.3];
elseif strcmp(tag,'N3') || strcmp(tag,'N4')
    coli = [0.95 0.95 0.95];    
elseif strcmp(tag,'N5')
    coli = [0.9 0.9 0.3];
end


if strcmp(tag(1),'P')
    ind = str2num(tag(2));
    col = zeros(4,3);
    col(1,:) = [0.2 0.6 1];
    col(2,:) = [0.3 0.9 0.3];
    col(3,:) = [0.9 0.3 0.3];
    col(4,:) = [0.9 0.9 0.3];
    size = 60;
    coli = col(ind,:);
end

pt = scatter(ax, x,y,'filled','markerfacecolor',coli,'markeredgecolor',colie,'tag',tag,'sizedata',size);
set(pt,'ButtonDownFcn',{@MouseClick,ax});
set(pt,'linewidth',1.2);

end

