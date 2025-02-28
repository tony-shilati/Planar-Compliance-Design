function [ ratio ] = calcRatio(ax)

global K

[t12x,t12y] = grabData('N1',ax);
[t34x,t34y] = grabData('N2',ax);
[t23x,t23y] = grabData('N5',ax);
[t5x,t5y] = grabData('P3',ax);
[cx,cy] = grabData('cpoint',ax);

t12 = createTwistFromPoint(t12x,t12y);
t23 = createTwistFromPoint(t23x,t23y);
t34 = createTwistFromPoint(t34x,t34y);
t5 = createTwistFromPoint(t5x,t5y);
tc = createTwistFromPoint(cx,cy);



w12 = K*t12;
w23 = K*t23;
w34 = K*t34;
w5 = K*t5;

w5 = w5/norm([w5(1),w5(2)]);


gam = (t34'*w12)/((t12'*w5)*(t34'*w5));


ratio = gam*(t23'*w5);


%Create Line for T14 location
L4 = makeFuncFromLine(findobj(ax,'tag','L4'));
L3 = makeFuncFromLine(findobj(ax,'tag','L3'));


x(1) = (ratio*w5(3)-w23(3))/(ratio*w5(2)-w23(2));
y(1) = 0;

x(2) = 0;
y(2) = (ratio*w5(3) - w23(3))/(-ratio*w5(1) + w23(1));



drawLine(x,y,'V1',ax);



end

