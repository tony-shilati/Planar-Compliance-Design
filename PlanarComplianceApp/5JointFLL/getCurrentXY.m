function [x, y] = getCurrentXY(ax)

pos = get(ax, 'currentpoint');
x = pos(1,1);
y = pos(1,2);

end