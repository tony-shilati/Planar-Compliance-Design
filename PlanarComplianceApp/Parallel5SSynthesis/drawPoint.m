function [ ] = drawPoint( x, y, tag, ax)

pt = findobj(ax,'tag',tag);

if ~isempty(pt)
    delete(pt);
end

size = 60;
coli = [0.95 0.95 0.95];
colie = [0.1 0.1 0.1];
pick = 'all';

if strcmp(tag(1),'P')
    ind = str2num(tag(2));
    col = zeros(4,3);
    col(1,:) = [0.2 0.6 1];
    col(2,:) = [0.9 0.3 0.3];
    col(3,:) = [0.3 0.9 0.3];
    col(4,:) = [0.9 0.3 0.9];    
    col(5,:) = [0.4 0.4 0.4];

    size = 60;
    coli = col(ind,:);
end

% N5 exception to being a standard node, will apply J5 at the end
if strcmp(tag(1:2),'P1')
   coli = [0.3 0.9 0.3];
end

if strcmp(tag(1:2),'N1')
   coli = [0.2 0.6 1];
end

if strcmp(tag(1:2),'N2')
   coli = [0.9 0.3 0.3];
end

if strcmp(tag(1:2),'N5')
    coli = [0.9 0.6 0.3];
end

if strcmp(tag(1:2),'N6')
    coli = [0.6 0.6 0.6];
end

if strcmp(tag(1),'t')
    ind = str2num(tag(2));
    size = 60;
    coli = [0 0 0];
    colie = coli;
    pick = 'none';
end

pt = scatter(ax,x,y,'filled','markerfacecolor',coli,'markeredgecolor',colie...
    ,'tag',tag,'sizedata',size,'PickableParts',pick);
set(pt,'ButtonDownFcn',{@MouseClick,ax});
set(pt,'linewidth',1.2);

end

