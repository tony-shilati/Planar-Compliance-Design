function [str] = Outputs(ax, tag)
%This function calculates the line of action for each spring, the wrench of
%each spring (trasnpose), the stiffness of each spring, and the stiffness
%matrix based on the previous three. Then it updates the output panel to show 
% this information

%If the value of the tag is 'l' this stands for long. This means that the
%long block of code will run. If the value of tag is 's' this stands for short. In
%this case only m and b will be calculated for the specific phase so the
%line of action eqaution can be output in the guide box

global K 
fig = get(ax, 'Parent');

%gets neccesary information
[x1, y1] = grabData('N1', ax);
[x2, y2] = grabData('N2', ax);
[x3, y3] = grabData('P3', ax);
[x4, y4] = grabData('N5', ax);



if strcmp(tag, 'l') 
    %Calulates the slope and y-intercept

    [w1, m1, b1] = calcInfo(x1, y1, x3, y3);
    [w2, m2, b2] = calcInfo(x1, y1, x4, y4);
    [w3, m3, b3] = calcInfo(x4, y4, x2, y2);
    [w4, m4, b4] = calcInfo(x3, y3, x2, y2);

    t12 = cross(w1, w2);
    t34 = cross(w3, w4);
    t14 = cross(w1, w4);
    t23 = cross(w2, w3);
    t24 = cross(w2, w4);
    

    %Calculates individual spring stiffness
    k1 = (transpose(t23)*K*t24) / ((transpose(t23)*w1) * (transpose(t24)*w1));

    k2 = (transpose(t34)*K*t14) / ((transpose(t34)*w2) * (transpose(t14)*w2));

    k3 = (transpose(t14)*K*t12) / ((transpose(t14)*w3) * (transpose(t12)*w3));

    k4 = (transpose(t12)*K*t23) / ((transpose(t12)*w4) * (transpose(t23)*w4));

    %Claculates the stiffness matrix

    Kmat = k1*w1*transpose(w1) + k2*w2*transpose(w2) + ...
        k3*w3*transpose(w3) + k4*w4*transpose(w4);

    
    %Outputs information to the user
    str = '';
    str1 = ['y = ' sprintf('%0.3f', m1) 'x + (' sprintf('%0.3f', b1) ')'];
    str2 = ['y = ' sprintf('%0.3f', m2) 'x + (' sprintf('%0.3f', b2) ')'];
    str3 = ['y = ' sprintf('%0.3f', m3) 'x + (' sprintf('%0.3f', b3) ')'];
    str4 = ['y = ' sprintf('%0.3f', m4) 'x + (' sprintf('%0.3f', b4) ')'];

    stiff1 = findobj(fig, 'Tag', 'stiff1');
    stiff2 = findobj(fig, 'Tag', 'stiff2');
    stiff3 = findobj(fig, 'Tag', 'stiff3');
    stiff4 = findobj(fig, 'Tag', 'stiff4');

    stiff1.String = sprintf('%0.4f', k1);
    stiff2.String = sprintf('%0.4f', k2);
    stiff3.String = sprintf('%0.4f', k3);
    stiff4.String = sprintf('%0.4f', k4);

    lin1 = findobj(fig, 'Tag', 'lin1');
    lin2 = findobj(fig, 'Tag', 'lin2');
    lin3 = findobj(fig, 'Tag', 'lin3');
    lin4 = findobj(fig, 'Tag', 'lin4');

    lin1.String = str1;
    lin2.String = str2;
    lin3.String = str3;
    lin4.String = str4;

    wrench1 = findobj(fig, 'Tag', 'wrench1');
    wrench2 = findobj(fig, 'Tag', 'wrench2');
    wrench3 = findobj(fig, 'Tag', 'wrench3');
    wrench4 = findobj(fig, 'Tag', 'wrench4');

    wrench1.String = ['[  ' sprintf('%0.3f', w1(1)) '  ' ...
                            sprintf('%0.3f', w1(2)) '  '...
                            sprintf('%0.3f', w1(3)) '  ]'];

    wrench2.String = ['[  ' sprintf('%0.3f', w2(1)) '  ' ...
                            sprintf('%0.3f', w2(2)) '  '...
                            sprintf('%0.3f', w2(3)) '  ]'];

    wrench3.String = ['[  ' sprintf('%0.3f', w3(1)) '  ' ...
                            sprintf('%0.3f', w3(2)) '  '...
                            sprintf('%0.3f', w3(3)) '  ]'];

    wrench4.String = ['[  ' sprintf('%0.3f', w4(1)) '  ' ...
                            sprintf('%0.3f', w4(2)) '  '...
                            sprintf('%0.3f', w4(3)) '  ]'];

    Kout = findobj(fig, 'Tag', 'Kout');
    set(Kout, 'Data', Kmat)

end