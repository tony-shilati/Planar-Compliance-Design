function [x,y] = calcIntersections( ax )
% 
% L1 = makeFuncFromLine(findobj(ax,'tag','L1'));
% L2 = makeFuncFromLine(findobj(ax,'tag','L2'));
% L3 = makeFuncFromLine(findobj(ax,'tag','L3'));
% L4 = makeFuncFromLine(findobj(ax,'tag','L4'));
% 
% J1 = @(x) L3(x) - L1(x);
% J2 = @(x) L4(x) - L1(x);
% J3 = @(x) L4(x) - L2(x);
% zJ4 = @(x) L3(x) - L2(x);
% 
% [x(1),~] = fzero(J1,0);
% y(1) = L1(x(1));
% [x(2),~] = fzero(J2,0);
% y(2) = L1(x(2));
% [x(3),~] = fzero(J3,0);
% y(3) = L2(x(3));
% [x(4),~] = fzero(J4,0);
% y(4) = L2(x(4));



[x(1),y(1)] = grabData('N1',ax);
[x(2),y(2)] = grabData('N2',ax);
[x(3),y(3)] = grabData('P3',ax);
[x(4),y(4)] = grabData('N5',ax);


% drawPoint(x(1),y(1),'P1',ax);
% drawPoint(x(2),y(2),'P2',ax); 
% drawPoint(x(3),y(3),'P3',ax);
% drawPoint(x(4),y(4),'P4',ax);

drawLine([x(1),x(3)],[y(1),y(3)],'W4',ax);
drawLine([x(1),x(4)],[y(1),y(4)],'W1',ax);
drawLine([x(2),x(3)],[y(2),y(3)],'W2',ax);
drawLine([x(2),x(4)],[y(2),y(4)],'W3',ax);


txt = text(x(1),y(1),'  P1','tag','J1','PickableParts','none');
txt = text(x(2),y(2),'  P2','tag','J2','PickableParts','none');
txt = text(x(3),y(3),'  P3','tag','J3','PickableParts','none');
txt = text(x(4),y(4),'  P4','tag','J4','PickableParts','none');


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

