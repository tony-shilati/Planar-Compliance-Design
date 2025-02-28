function [] = connectJoints(ax, finger)
%This function connects the joints in each finger with lines
n = num2str(finger);
%% gather neccesary information
[j1x, j1y] = grabData(['F' n 'J1'], ax);
[j2x, j2y] = grabData(['F' n 'J2'], ax);
[j3x, j3y] = grabData(['F' n 'J3'], ax);
[cx, cy] = grabData(['P' n], ax);

%% plot the connections
if finger == 1
    color = [0 0.4470 0.7410];

elseif finger == 2
    color = [0.9290 0.6940 0.1250];

elseif finger == 3
    color = [0.8500 0.3250 0.0980];

end

if ~isempty(findobj(ax, 'Tag', ['F' n 'L1']))
    delete(findobj(ax, 'Tag', ['F' n 'L1']))
    delete(findobj(ax, 'Tag', ['F' n 'L2']))
    delete(findobj(ax, 'Tag', ['F' n 'L3']))
end
    
p1 = plot(ax, [j1x j2x], [j1y j2y], 'LineWidth', 2.5, 'Tag', ['F' n 'L1'], 'Color', color);
p2 = plot(ax, [j2x j3x], [j2y j3y], 'LineWidth', 2.5, 'Tag', ['F' n 'L2'], 'Color', color);
p3 = plot(ax, [j3x cx], [j3y cy], 'LineWidth', 2.5, 'Tag', ['F' n 'L3'], 'Color', color);

uistack(p1, "bottom")
uistack(p2, "bottom")
uistack(p3, "bottom")
end