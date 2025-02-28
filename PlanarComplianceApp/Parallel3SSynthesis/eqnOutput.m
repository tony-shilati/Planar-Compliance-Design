function [] = eqnOutput(ax, str, m, b)

fig = get(ax, 'Parent');

%format m and b
M = sprintf('%0.2f', m);
B = sprintf('%0.2f', b);

if isnan(M)
    M = 'Nan';
elseif isinf(M)
    M = 'Inf';
end

if isnan(B)
    B = 'Nan';
elseif isinf(B)
    B = 'Inf';
end


if strcmp(str, 'line1')
    lin1 = findobj(fig, 'Tag', 'lin1');
    lin1.String = ['   y = (' M ')x + ' B];
elseif strcmp(str, 'line2')
    lin1 = findobj(fig, 'Tag', 'lin2');
    lin1.String = ['   y = (' M ')x + ' B];
elseif strcmp(str, 'line3')
    lin1 = findobj(fig, 'Tag', 'lin3');
    lin1.String = ['   y = (' M ')x + ' B];
end 
end 