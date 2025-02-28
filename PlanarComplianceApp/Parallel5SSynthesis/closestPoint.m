function [x,y] = closestPoint(xi,yi,tag,ax)

h = findobj(ax,'tag',tag);

func = makeFuncFromLine(h);

b1 = func(0);
m = (func(1) - b1)/1;

funp = @(x) (-1/m)*x + (yi + (1/m)*xi); 

net = @(x) func(x) - funp(x);

try
[x,~] = fzero(net,xi);
catch
    x = xi;
end

y = func(x);

end

