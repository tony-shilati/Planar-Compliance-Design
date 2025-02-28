function [] = drawHandle(ax, tag, x, y)

%Deletes any pervious handle of the same type to avoid duplicates
hndl = findobj(ax, 'Tag', tag);
if ~isempty(hndl)
    delete(hndl)
end 

%Plots the handle 
pt = scatter(x,y,'filled','tag',tag,'sizedata',75, 'MarkerEdgeColor', [0 0 0], ...
    'MarkerFaceColor',[0.95 0.95 0.95]);

%Sets the the callback of a mouseclick on the handle to @MouseClick
set(pt,'ButtonDownFcn',{@MouseClick, ax});
%Makes the handles appear over other objects on the axes
uistack(pt, "top")
end