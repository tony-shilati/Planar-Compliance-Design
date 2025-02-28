function [] = Outputs(ax, K)
format long
fig = get(ax, 'Parent');
[x, y, K] = stiffnessCenter(K, ax);

%Get the informantion that is needed for the calculations
[p1x, p1y] = grabData('P1', ax);
[p2x, p2y] = grabData('P2', ax);
[p3x, p3y] = grabData('P3', ax);

[n1x, n1y] = grabData('N1', ax);
[n2x, n2y] = grabData('N2', ax);
[n3x, n3y] = grabData('N3', ax);
[n4x, n4y] = grabData('N4', ax);
[n5x, n5y] = grabData('N5', ax);
[n6x, n6y] = grabData('N6', ax);

%Calculate the outputs

    %lines of action
    %Wrenches

    [w1, m1, b1] = wrenchFromLine(p1x, p1y, n1x, n1y);
    [w2, m2, b2] = wrenchFromLine(p1x, p1y, n2x, n2y);
    [w3, m3, b3] = wrenchFromLine(p2x, p2y, n3x, n3y);
    [w4, m4, b4] = wrenchFromLine(p2x, p2y, n4x, n4y);
    [w5, m5, b5] = wrenchFromLine(p3x, p3y, n5x, n5y);
    [w6, m6, b6] = wrenchFromLine(p3x, p3y, n6x, n6y);


    %Individual stiffness
    W1 = w1*w1'; w1tilde = [W1(1,1); W1(1,2); W1(1,3); W1(2,2); W1(2,3); W1(3,3)];
    W2 = w2*w2'; w2tilde = [W2(1,1); W2(1,2); W2(1,3); W2(2,2); W2(2,3); W2(3,3)];
    W3 = w3*w3'; w3tilde = [W3(1,1); W3(1,2); W3(1,3); W3(2,2); W3(2,3); W3(3,3)];
    W4 = w4*w4'; w4tilde = [W4(1,1); W4(1,2); W4(1,3); W4(2,2); W4(2,3); W4(3,3)];
    W5 = w5*w5'; w5tilde = [W5(1,1); W5(1,2); W5(1,3); W5(2,2); W5(2,3); W5(3,3)];
    W6 = w6*w6'; w6tilde = [W6(1,1); W6(1,2); W6(1,3); W6(2,2); W6(2,3); W6(3,3)];

    Wtilde = [w1tilde, w2tilde, w3tilde, w4tilde, w5tilde, w6tilde];
    Ktilde = [K(1,1); K(1,2); K(1,3); K(2,2); K(2,3); K(3,3)];

    k = Wtilde\Ktilde;

    Kmat = k(1)*W1 + k(2)*W2 + k(3)*W3 + k(4)*W4 + k(5)*W5 + k(6)*W6;
    %Stiffness matrix

%Format the outputs

    %lines of action
    l1 = ['y = (' sprintf('%0.3f', m1) ')x +(' sprintf('%0.3f', b1) ')'];
    l2 = ['y = (' sprintf('%0.3f', m2) ')x +(' sprintf('%0.3f', b2) ')'];
    l3 = ['y = (' sprintf('%0.3f', m3) ')x +(' sprintf('%0.3f', b3) ')'];
    l4 = ['y = (' sprintf('%0.3f', m4) ')x +(' sprintf('%0.3f', b4) ')'];
    l5 = ['y = (' sprintf('%0.3f', m5) ')x +(' sprintf('%0.3f', b5) ')'];
    l6 = ['y = (' sprintf('%0.3f', m6) ')x +(' sprintf('%0.3f', b6) ')'];

    %Wrenches
    w1t = ['[  ' sprintf('%0.3f', w1(1)) '  ' sprintf('%0.3f', w1(2)) '  ' sprintf('%0.3f', w1(3)) '  ]'];
    w2t = ['[  ' sprintf('%0.3f', w2(1)) '  ' sprintf('%0.3f', w2(2)) '  ' sprintf('%0.3f', w2(3)) '  ]'];
    w3t = ['[  ' sprintf('%0.3f', w3(1)) '  ' sprintf('%0.3f', w3(2)) '  ' sprintf('%0.3f', w3(3)) '  ]'];
    w4t = ['[  ' sprintf('%0.3f', w4(1)) '  ' sprintf('%0.3f', w4(2)) '  ' sprintf('%0.3f', w4(3)) '  ]'];
    w5t = ['[  ' sprintf('%0.3f', w5(1)) '  ' sprintf('%0.3f', w5(2)) '  ' sprintf('%0.3f', w5(3)) '  ]'];
    w6t = ['[  ' sprintf('%0.3f', w6(1)) '  ' sprintf('%0.3f', w6(2)) '  ' sprintf('%0.3f', w6(3)) '  ]'];

    %Individual stiffness
    k1 = sprintf('%0.4f', k(1));
    k2 = sprintf('%0.4f', k(2));
    k3 = sprintf('%0.4f', k(3));
    k4 = sprintf('%0.4f', k(4));
    k5 = sprintf('%0.4f', k(5));
    k6 = sprintf('%0.4f', k(6));


    %Stiffness matrix

%Display the outputs on the UI
    format short
    %lines of action
    %Wrenches
    %Individual stiffness
    %Stiffness matrix

    set(findobj(fig, 'Tag', 'lin1'), 'String', l1);
    set(findobj(fig, 'Tag', 'lin2'), 'String', l2);
    set(findobj(fig, 'Tag', 'lin3'), 'String', l3);
    set(findobj(fig, 'Tag', 'lin4'), 'String', l4);
    set(findobj(fig, 'Tag', 'lin5'), 'String', l5);
    set(findobj(fig, 'Tag', 'lin6'), 'String', l6);

    set(findobj(fig, 'Tag', 'wrench1'), 'String', w1t);
    set(findobj(fig, 'Tag', 'wrench2'), 'String', w2t);
    set(findobj(fig, 'Tag', 'wrench3'), 'String', w3t);
    set(findobj(fig, 'Tag', 'wrench4'), 'String', w4t);
    set(findobj(fig, 'Tag', 'wrench5'), 'String', w5t);
    set(findobj(fig, 'Tag', 'wrench6'), 'String', w6t);

    set(findobj(fig, 'Tag', 'stiff1'), 'String', k1);
    set(findobj(fig, 'Tag', 'stiff2'), 'String', k2);
    set(findobj(fig, 'Tag', 'stiff3'), 'String', k3);
    set(findobj(fig, 'Tag', 'stiff4'), 'String', k4);
    set(findobj(fig, 'Tag', 'stiff5'), 'String', k5);
    set(findobj(fig, 'Tag', 'stiff6'), 'String', k6);

    km11 = sprintf('%0.4f', Kmat(1,1));
    km12 = sprintf('%0.4f', Kmat(1,2));
    km13 = sprintf('%0.4f', Kmat(1,3));
    km21 = sprintf('%0.4f', Kmat(2,1));
    km22 = sprintf('%0.4f', Kmat(2,2));
    km23 = sprintf('%0.4f', Kmat(2,3));
    km31 = sprintf('%0.4f', Kmat(3,1));
    km32 = sprintf('%0.4f', Kmat(3,2));
    km33 = sprintf('%0.4f', Kmat(3,3));

    km = {km11, km12, km13; km21, km22, km23; km31, km32, km33};

    set(findobj(fig, 'Tag', 'Kout'), 'Data', km);


end