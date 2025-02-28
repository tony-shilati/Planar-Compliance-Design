function [] = compOutputs(ax, Kp33, finger)

global Ps
fig = get(ax, 'Parent');
num = num2str(finger);
format long


%% get neccesary information to calculate/ouput
    %includes access to gui elements and joint locations
[j1x, j1y] = grabData(['F' num 'J1'], ax);
[j2x, j2y] = grabData(['F' num 'J2'], ax);
[j3x, j3y] = grabData(['F' num 'J3'], ax);

Kp22 = [Kp33(1,1:2); Kp33(2,1:2)];
Cp = inv(Kp22);


omega = [0, -1; 
        1, 0];



%% Updates the GUI to show calculations

if finger == 1
    %%
    % complinace calculations
    [px, py] = grabData('P1', ax);

    p = [px; py];

    r1 = [j1x; j1y] - p;
    r2 = [j2x; j2y] - p;
    r3 = [j3x; j3y] - p;
    
    v1 = omega'*r1;
    v2 = omega'*r2;
    v3 = omega'*r3;
    
    %compliances
    c1 = ((r2'*Cp)*r3) / ((r2'*v1)*(r3'*v1));
    c2 = ((r3'*Cp)*r1) / ((r3'*v2)*(r1'*v2));
    c3 = ((r1'*Cp)*r2) / ((r1'*v3)*(r2'*v3));
    
    % shows the joint locations in the finger 1 table
    [kx, ky] = grabData('cpoint', ax);
    jointTable = [kx, j1x, j2x, j3x;
                  ky, j1y, j2y, j3y];

    set(findobj(fig, 'Tag', 'jout1'), 'Data', jointTable)

    %Shows the joint compliances
    compData= [c1, 0, 0; c2, 0, 0; c3, 0, 0];
    set(findobj(fig, 'tag', 'cout1'), 'Data', compData)

    C1 = c1*(v1*v1') + c2*(v2*v2') + c3*(v3*v3');
    K22 = inv(C1);
    Kp = [K22(1,1), K22(1,2), 0;
          K22(2,1), K22(2,2), 0;
          0, 0, 0];

    %transformation matrix
    [c1x, c1y] = grabData('P1', ax);
    T1 = [1, 0, -c1y;
          0, 1, c1x;
          0, 0, 1];
    K = (T1'*Kp)*T1;

    Ps.Kout1 = K;

elseif finger == 2
    %%
    % complinace calculations
    [px, py] = grabData('P2', ax);

    p = [px; py];

    r1 = [j1x; j1y] - p;
    r2 = [j2x; j2y] - p;
    r3 = [j3x; j3y] - p;
    
    v1 = omega'*r1;
    v2 = omega'*r2;
    v3 = omega'*r3;
    
    %compliances
    c1 = ((r2'*Cp)*r3) / ((r2'*v1)*(r3'*v1));
    c2 = ((r3'*Cp)*r1) / ((r3'*v2)*(r1'*v2));
    c3 = ((r1'*Cp)*r2) / ((r1'*v3)*(r2'*v3));


    % shows the joint locations in the finger 2 table
    jointTable = [j1x, j2x, j3x;
                  j1y, j2y, j3y];

    set(findobj(fig, 'Tag', 'jout2'), 'Data', jointTable)

    %Shows the joint compliances
    
    compData = get(findobj(fig, 'tag', 'cout1'), 'Data');
    compData(:,2) = [c1; c2; c3];
    set(findobj(fig, 'tag', 'cout1'), 'Data', compData)

    C2 = c1*(v1*v1') + c2*(v2*v2') + c3*(v3*v3');
    K22 = inv(C2);
    Kp = [K22(1,1), K22(1,2), 0;
          K22(2,1), K22(2,2), 0;
          0, 0, 0];

    %transformation matrix
    [c2x, c2y] = grabData('P2', ax);
    T2 = [1, 0, -c2y;
          0, 1, c2x;
          0, 0, 1];

    K = (T2'*Kp)*T2;

    Ps.Kout2 = K;


elseif finger == 3
    %%
    % complinace calculations
    [px, py] = grabData('P3', ax);

    p = [px; py];

    r1 = [j1x; j1y] - p;
    r2 = [j2x; j2y] - p;
    r3 = [j3x; j3y] - p;
    
    v1 = omega'*r1;
    v2 = omega'*r2;
    v3 = omega'*r3;
    
    %compliances
    c1 = ((r2'*Cp)*r3) / ((r2'*v1)*(r3'*v1));
    c2 = ((r3'*Cp)*r1) / ((r3'*v2)*(r1'*v2));
    c3 = ((r1'*Cp)*r2) / ((r1'*v3)*(r2'*v3));

    % shows the joint locations in the finger 2 table
    jointTable = [j1x, j2x, j3x;
                  j1y, j2y, j3y];

    set(findobj(fig, 'Tag', 'jout3'), 'Data', jointTable)

    %Shows the joint compliances
    compData = get(findobj(fig, 'tag', 'cout1'), 'Data');
    compData(:,3) = [c1; c2; c3];
    set(findobj(fig, 'tag', 'cout1'), 'Data', compData)

    C3 = c1*(v1*v1') + c2*(v2*v2') + c3*(v3*v3');
    K22 = inv(C3);
    Kp = [K22(1,1), K22(1,2), 0;
          K22(2,1), K22(2,2), 0;
          0, 0, 0];

    %transformation matrix
    [c3x, c3y] = grabData('P3', ax);
    T3 = [1, 0, -c3y;
          0, 1, c3x;
          0, 0, 1];
    K = (T3'*Kp)*T3;

    Ps.Kout3 = K;

    K3 = Ps.Kout1 + Ps.Kout2 + Ps.Kout3;

    Kout = findobj(fig, 'Tag', 'Kout');
    km11 = sprintf('%0.4f', K3(1,1));
    km12 = sprintf('%0.4f', K3(1,2));
    km13 = sprintf('%0.4f', K3(1,3));
    km21 = sprintf('%0.4f', K3(2,1));
    km22 = sprintf('%0.4f', K3(2,2));
    km23 = sprintf('%0.4f', K3(2,3));
    km31 = sprintf('%0.4f', K3(3,1));
    km32 = sprintf('%0.4f', K3(3,2));
    km33 = sprintf('%0.4f', K3(3,3));

    km = {km11, km12, km13; km21, km22, km23; km31, km32, km33};
    set(Kout, 'Data', km)

end



end