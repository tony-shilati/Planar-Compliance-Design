function [] = drawPoint(x, y, str, ax)

pt = findobj(ax, 'Tag', str);


if ~isempty(pt)
    delete(pt)
end

pick = 'all';

if strcmp(str(1), 'N')
    fcolor = [0.95 0.95 0.95];
end 

if strcmp(str(1), 'P')
    ind = str2double(str(2));
    fcolor1 = zeros(6,3);
    fcolor1(1,:) = [0.2 0.6 1];
    fcolor1(2,:) = [0.3 0.9 0.3];
    fcolor1(3,:) = [0 0 0];
    fcolor1(4,:) = [0.9 0.3 0.3];    
    fcolor1(5,:) = [0.4 0.4 0.4];
    fcolor1(6,:) = [0.2 0.2 0.2];

    fcolor = fcolor1(ind, :);

end

size = 60;

if strcmp(str(1), 'J')
    fcolor = [0 0 0];
    size = 70;
    pick = 'none';
    text(x, y, ['  ' str], 'FontSize', 10, 'Tag', 'text')
end


if strcmp(str, 'P6P')
    size = 30;
end



pt = scatter(ax, x, y, 'filled', 'markerfacecolor', fcolor , ...
    'markeredgecolor', [0, 0, 0], 'tag',str,'sizedata',size,'PickableParts',pick);
uistack(pt, 'top')
set(pt,'ButtonDownFcn',{@MouseClick, ax});
set(pt,'linewidth',1.2);

end

