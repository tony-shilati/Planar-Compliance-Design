function [x,y] = calcIntersections( ax )

%% Gets the joint locations
L1 = makeFuncFromLine(findobj(ax,'tag','L1'));
L2 = makeFuncFromLine(findobj(ax,'tag','L2'));
L3 = makeFuncFromLine(findobj(ax,'tag','L3'));
L4 = makeFuncFromLine(findobj(ax,'tag','L4'));

J1 = @(x) L4(x) - L1(x);
J2 = @(x) L3(x) - L1(x);
J3 = @(x) L3(x) - L2(x);
J4 = @(x) L4(x) - L2(x);

[x(1),~] = fzero(J1,0);
y(1) = L1(x(1));
[x(2),~] = fzero(J2,0);
y(2) = L1(x(2));
[x(3),~] = fzero(J3,0);
y(3) = L2(x(3));
[x(4),~] = fzero(J4,0);
y(4) = L2(x(4));

%% draws the joints and labels them 
drawPoint(x(1),y(1),'J1',ax);
drawPoint(x(2),y(2),'J2',ax);
drawPoint(x(3),y(3),'J3',ax);
drawPoint(x(4),y(4),'J4',ax);

text(x(1),y(1),'  J1','tag','J1');
text(x(2),y(2),'  J2','tag','J2');
text(x(3),y(3),'  J3','tag','J3');
text(x(4),y(4),'  J4','tag','J4');


%% Draws the links
delete(findobj(ax, 'Tag', 'link1'))
delete(findobj(ax, 'Tag', 'link1'))
delete(findobj(ax, 'Tag', 'link1'))

l1 = plot(x(1:2), y(1:2), "Color", [0 0 0], 'Tag', 'link1', 'LineWidth', 2.5);
l2 = plot(x(2:3), y(2:3), "Color", [0 0 0], 'Tag', 'link1', 'LineWidth', 2.5);
l3 = plot(x(3:4), y(3:4), "Color", [0 0 0], 'Tag', 'link1', 'LineWidth', 2.5);

uistack(l1, 'top')
uistack(l2, 'top')
uistack(l3, 'top')

%% Outputs joint information
figh = get(ax,'parent');
jh = findobj(figh,'tag','jout');

jout = get(jh,'Data');

%jout{1,2:5} = {x(1),x(2),x(3),x(4)};
jout{1,2} = x(1);
jout{1,3} = x(2);
jout{1,4} = x(3);
jout{1,5} = x(4);
jout{2,2} = y(1);
jout{2,3} = y(2);
jout{2,4} = y(3);
jout{2,5} = y(4);


set(jh,'Data',jout);






end

