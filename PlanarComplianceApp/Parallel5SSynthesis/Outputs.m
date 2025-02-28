function [str] = Outputs(ax, tag)
%This function calculates the line of action for each spring, the wrench of
%each spring (trasnpose), the stiffness of each spring, and the stiffness
%matrix based on the previous three. Then it updates the output panel to show 
% this information

%If the value of the tag is 'l' this stands for long. This means that the
%long block of code will run. If the value of tag is 's' this stands for short. In
%this case only m and b will be calculated for the specific phase so the
%line of action eqaution can be output in the guide box

global K phase
fig = get(ax, 'Parent');

%gets neccesary information
[t23x,t23y] = grabData('N5',ax);
[t12x,t12y] = grabData('N1',ax);
[t34x,t34y] = grabData('N2',ax);
[t14x,t14y] = grabData('N6',ax);

[t5x,t5y] = grabData('N3',ax);
[t5x2,t5y2] = grabData('N4',ax);

mtest = (t23y - t5y) / (t23x - t5x);



if strcmp(tag, 'l') 
    %Calulates the slope and y-intercept

    [w1, m1, b1] = calcInfo(t12x, t12y, t14x, t14y);
    [w2, m2, b2] = calcInfo(t12x, t12y, t23x, t23y);
    [w3, m3, b3] = calcInfo(t23x, t23y, t34x, t34y);
    [w4, m4, b4] = calcInfo(t14x, t14y, t34x, t34y);
    [w5, m5, b5] = calcInfo(t5x, t5y, t5x2, t5y2);

    t45x = 0; t45y = 0; t35x = 0; t35y = 0;
    if mtest == m2
        t45x = t5x; t45y = t5y;
        t35x = t5x2; t35y = t5y2;
    elseif mtest == m3
        t45x = t5x2; t45y = t5y2;
        t35x = t5x2; t35y = t5y2;
    end



    %calculates twists
    t23 = cross(w2, w3);
    t12 = cross(w1, w2);
    t34 = cross(w3, w4);
    t14 = cross(w1, w4);
    t35 = cross(w3, w5);
    t45 = cross(w4, w5);

    

    %Calculates individual spring stiffness
    k1 = (transpose(t23)*K*t45) / ((transpose(t23)*w1) * (transpose(t45)*w1));

    k2 = (transpose(t14)*K*t35) / ((transpose(t14)*w2) * (transpose(t35)*w2));

    k3 = (transpose(t12)*K*t45) / ((transpose(t12)*w3) * (transpose(t45)*w3));

    k4 = (transpose(t12)*K*t35) / ((transpose(t12)*w4) * (transpose(t35)*w4));

    k5 = (transpose(t12)*K*t34) / ((transpose(t12)*w5) * (transpose(t34)*w5));

    %Claculates the stiffness matrix

    Kmat = k1*w1*transpose(w1) + k2*w2*transpose(w2) + ...
        k3*w3*transpose(w3) + k4*w4*transpose(w4) + k5*w5*transpose(w5);

    
    %Outputs information to the user
    str = '';
    str1 = ['y = ' sprintf('%0.3f', m1) 'x + (' sprintf('%0.3f', b1) ')'];
    str2 = ['y = ' sprintf('%0.3f', m2) 'x + (' sprintf('%0.3f', b2) ')'];
    str3 = ['y = ' sprintf('%0.3f', m3) 'x + (' sprintf('%0.3f', b3) ')'];
    str4 = ['y = ' sprintf('%0.3f', m4) 'x + (' sprintf('%0.3f', b4) ')'];
    str5 = ['y = ' sprintf('%0.3f', m5) 'x + (' sprintf('%0.3f', b5) ')'];

    stiff1 = findobj(fig, 'Tag', 'stiff1');
    stiff2 = findobj(fig, 'Tag', 'stiff2');
    stiff3 = findobj(fig, 'Tag', 'stiff3');
    stiff4 = findobj(fig, 'Tag', 'stiff4');
    stiff5 = findobj(fig, 'Tag', 'stiff5');

    stiff1.String = sprintf('%0.4f', k1);
    stiff2.String = sprintf('%0.4f', k2);
    stiff3.String = sprintf('%0.4f', k3);
    stiff4.String = sprintf('%0.4f', k4);
    stiff5.String = sprintf('%0.4f', k5);

    lin1 = findobj(fig, 'Tag', 'lin1');
    lin2 = findobj(fig, 'Tag', 'lin2');
    lin3 = findobj(fig, 'Tag', 'lin3');
    lin4 = findobj(fig, 'Tag', 'lin4');
    lin5 = findobj(fig, 'Tag', 'lin5');

    lin1.String = str1;
    lin2.String = str2;
    lin3.String = str3;
    lin4.String = str4;
    lin5.String = str5;

    wrench1 = findobj(fig, 'Tag', 'wrench1');
    wrench2 = findobj(fig, 'Tag', 'wrench2');
    wrench3 = findobj(fig, 'Tag', 'wrench3');
    wrench4 = findobj(fig, 'Tag', 'wrench4');
    wrench5 = findobj(fig, 'Tag', 'wrench5');

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

    wrench5.String = ['[  ' sprintf('%0.3f', w5(1)) '  ' ...
                            sprintf('%0.3f', w5(2)) '  '...
                            sprintf('%0.3f', w5(3)) '  ]'];

    Kout = findobj(fig, 'Tag', 'Kout');
    set(Kout, 'Data', Kmat)
    
end

end