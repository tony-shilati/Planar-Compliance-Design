function [] = UpdateUI(x, y, ax, K, phase)
fig = get(ax, 'parent');

global V3J_3F Ps

if phase > 12
    ll_data = str2double(get(findobj(fig, 'Tag', 'LenTable'), 'Data'));
end


%%
if phase == 1
    V3J_3F.x = [V3J_3F.x, x]; vert_x = V3J_3F.x;
    V3J_3F.y = [V3J_3F.y, y]; vert_y = V3J_3F.y;

    l = length(V3J_3F.x);

    drawPoint(x, y, ['V' num2str(l)], ax)

    if l > 1
        pl = plot([vert_x(l-1), x], [vert_y(l-1), y], 'LineWidth', 1.5, 'Color', [.7 .7 .7], 'Tag', ['VL' num2str(l-1)]);
        set(pl, 'ButtonDownFcn', {@MouseClick, ax})

    end

    pt1x = findobj(fig, 'Tag', 'pt1x');
    pt1y = findobj(fig, 'Tag', 'pt1y');
    set(pt1x, 'String', '')
    set(pt1y, 'String', '')
    
elseif phase == 2
    [X, Y] = pointToLine(x,y);
    if isempty(X) || isempty(Y)
        return
    end
    drawPoint(X, Y, 'P1', ax) %P1 == T12

elseif phase == 3
    [X, Y] = pointToLine(x,y);
    if any(isempty([X, Y]))
        return
    end
    drawPoint(X, Y, 'P2', ax) %P2 == T34

elseif phase == 4
    drawPoint(x, y, 'N1', ax) %N1 is a handle for w1
    [p1x, p1y] = grabData('P1', ax);
    drawLine([p1x, x], [p1y, y], 'L1', ax) %L1 == w1

elseif phase == 5
    drawPoint(x, y, 'N2', ax) %N2 is a handle for w2
    [p1x, p1y] = grabData('P1', ax);
    drawLine([p1x, x], [p1y, y], 'L2', ax) %L2 == w2

elseif phase == 6 
    drawPoint(x, y, 'N3', ax) %N3 is a handle for w3
    [p2x, p2y] = grabData('P2', ax);
    drawLine([p2x, x], [p2y, y], 'L3', ax) %L3 == w3

elseif phase == 7
    drawPoint(x, y, 'N4', ax) %N4 is a handel for w4
    [p2x, p2y] = grabData('P2', ax);
    drawLine([p2x, x], [p2y, y], 'L4', ax) %L4 == w4
    drawQuadCurve(ax, K, 1);

elseif phase == 8 
    [X, Y] = pointToLine(x,y);
    if isempty(X) || isempty(Y)
        return
    end
    drawPoint(X, Y, 'P3', ax) %P3 == T56

elseif phase == 9
    drawPoint(x, y, 'N5', ax) %N5 is a handle for w5
    [p3x, p3y] = grabData('P3', ax);
    drawLine([p3x, x], [p3y, y], 'L5', ax) %L5 == w5

elseif phase == 10
    drawPoint(x, y, 'N6', ax) %N6 is a handle for w6
    [p3x, p3y] = grabData('P3', ax);
    drawLine([p3x, x], [p3y, y], 'L6', ax) %L6 == w6

    %Check if the condition in step 4 of the syntheis is satisfied
    Outputs(ax, K)
    [ec1, ec2, ec3] = checkConditons(K, ax);

    if ec1 == 1
        warndlg(['At least one wrench line must intersect the circle surrounding the stiffness center, ' ...
            'and at least one wrench line must not intersect the same circle.'], '')
    end
    
    if ec2 == 1
        warndlg(['The perpendicular vectors from the stiffness center to the wrench lines' ...
            'must be distributed between the regions defined by the red lines passing through' ...
            ' the stiffness center.'])
    end
    
    if ec3 == 1
        warndlg(['For wrench 5 and wrench 6: one of the wrenches must intersect ' ...
            'the red quadratic curve, and the other wrench must not intersect the ' ...
            'quadratic curve.'])
    end

    set(findobj(fig, 'Tag', 'ent1lab'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'ent2lab'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'ent1'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'ent2'), 'Visible', 'on')
    set(findobj(fig, 'Tag', 'cvt'), 'Visible', 'on')

elseif phase == 12
    %Calculates and stores the point stiffnesses at the fingertips in
    %and object
    storePointStiff(ax)

    %changes the appearance of the interface
    Visibility(ax, 0, 1, 0, 1, 0, 2)
    Clear_string(ax, 0, 0, 1, 0, 1, 0, 0)

    

    %Deletes lines and points from the stiffness synthesis. 

    delete(findobj(fig, 'Tag', 'L1'))
    delete(findobj(fig, 'Tag', 'N1'))
    delete(findobj(fig, 'Tag', 'L2'))
    delete(findobj(fig, 'Tag', 'N2'))
    delete(findobj(fig, 'Tag', 'L3'))
    delete(findobj(fig, 'Tag', 'N3'))
    delete(findobj(fig, 'Tag', 'L4'))
    delete(findobj(fig, 'Tag', 'N4'))
    delete(findobj(fig, 'Tag', 'L5'))
    delete(findobj(fig, 'Tag', 'N5'))
    delete(findobj(fig, 'Tag', 'L6'))
    delete(findobj(fig, 'Tag', 'N6'))
    delete(findobj(fig, 'Tag', 'cone1'))
    delete(findobj(fig, 'Tag', 'cone2'))
    delete(findobj(fig, 'Tag', 'ccplot'))
    delete(findobj(fig, 'Tag', 'QuadCurve'))
    

    
    

    empt_data = {'', '', ''; '', '', ''; '', '', ''};
    set(findobj(fig, 'Tag', 'Kout'), 'Data', empt_data)


    %% Finger Synthesis Begins
elseif phase == 13

    %changes the appearance of the interface
    Visibility(ax, 1, 0, 2, 2, 2, 2)


    %Draws a circle around the first contact where all joints for the first
    %finger need to be placed
    [c1x, c1y] = grabData('P1', ax);
    rf1 = norm(ll_data(1,:),1);
    drawCircle(ax, rf1, c1x, c1y, 'crcf1', 0)

    %draws a circle around the first contact which has a radius that is the
    %same as the thrid link length
    r13 = ll_data(1,3);
    drawCircle(ax, r13, c1x, c1y, 'crc13', 1)


elseif phase == 14

    %plots the first finger base joint
    drawPoint(x, y, 'F1J1', ax)
    [c1x, c1y] = grabData('P1', ax);

    %Plots the circle around the base joint that is the length of link 1
    r11 = ll_data(1,1);
    drawCircle(ax, r11, x, y, 'crc11', 1)

    %calculates and plots the lines passing through the base joint (rho and l)
    fingerSynth(ax, x, y, c1x, c1y, Ps.K1, 'J1', 1, 0, 0, 0);


elseif phase == 15

    %finds the point on the first circle that is closest to the location
    %selected
    %plots Joint 2 of the first finger
    %plots red points at the intersections of the second and third circles
    [c1x, c1y] = grabData('P1', ax);
    fingerSynth(ax, x, y, c1x, c1y, Ps.K1, 'J2', 1, ll_data(1,1), ll_data(1,2), ll_data(1,3))

    %plots the circle surrounding the second joint
    [j2x, j2y] = grabData('F1J2', ax);
    r12 = ll_data(1,2);
    if ~isempty(j2x) && ~isempty(j2y)
        drawCircle(ax, r12, j2x, j2y,'crc12', 1)
    else
        return
    end


elseif phase == 16 

    %Finds which possible location of joint 3 is closer to the selected
    %point
    %Plots the third joint 
    %connects the Joints with link lines
    [c1x, c1y] = grabData('P1', ax);
    fingerSynth(ax, x, y, c1x, c1y, 0, 'J3', 1, 0, 0, 0)

    %deletes the circles surrounding the joints
    delete(findobj(fig, 'Tag', 'crc11'))
    delete(findobj(fig, 'Tag', 'crc12'))
    delete(findobj(fig, 'Tag', 'crc13'))
    delete(findobj(fig, 'Tag', 'crcf1'))
    delete(findobj(fig, 'Tag', 'rho1'))
    delete(findobj(fig, 'Tag', 'l1'))

    %Calculate the joint compliances, confirm that they realize the point
    %compliance, and ouput the compliances and joint locations
    compOutputs(ax, Ps.K1, 1);

    %Display the circle surrounding contact two to prepare for the
    %synthesis of finger 2
    [c2x, c2y] = grabData('P2', ax);
    rf2 = norm(ll_data(2,:),1);
    drawCircle(ax, rf2, c2x, c2y, 'crcf2', 0)

    %draws a circle around the second contact which has a radius that is the
    %same as the thrid link length
    r23 = ll_data(2,3);
    drawCircle(ax, r23, c2x, c2y, 'crc23', 1)

elseif phase == 17

    %plots the second finger base joint
    drawPoint(x, y, 'F2J1', ax)
    [c2x, c2y] = grabData('P2', ax);

    %Plots the circle around the base joint that is the length of link 1
    r21 = ll_data(2,1);
    drawCircle(ax, r21, x, y, 'crc21', 1)

    %calculates and plots the lines passing through the base joint (rho and l)
    fingerSynth(ax, x, y, c2x, c2y, Ps.K2, 'J1', 2, 0, 0, 0);

elseif phase == 18
    %finds the point on the first circle that is closest to the location
    %selected
    %plots Joint 2 of the second finger
    %plots red points at the intersections of the second and third circles
    [c2x, c2y] = grabData('P2', ax);
    fingerSynth(ax, x, y, c2x, c2y, Ps.K2, 'J2', 2, ll_data(2,1), ll_data(2,2), ll_data(2,3))

    %plots the circle surrounding the second joint
    [j2x, j2y] = grabData('F2J2', ax);
    r22 = ll_data(2,2);
    if ~isempty(j2x) && ~isempty(j2y)
        drawCircle(ax, r22, j2x, j2y,'crc22', 1)
    else
        return
    end


elseif phase == 19
    %Finds which possible location of joint 3 is closer to the selected
    %point
    %Plots the third joint 
    %connects the Joints with link lines
    [c2x, c2y] = grabData('P2', ax);
    fingerSynth(ax, x, y, c2x, c2y, 0, 'J3', 2, 0, 0, 0)

    %deletes the circles surrounding the joints
    delete(findobj(fig, 'Tag', 'crc21'))
    delete(findobj(fig, 'Tag', 'crc22'))
    delete(findobj(fig, 'Tag', 'crc23'))
    delete(findobj(fig, 'Tag', 'crcf2'))
    delete(findobj(fig, 'Tag', 'rho2'))
    delete(findobj(fig, 'Tag', 'l2'))

    %Calculate the joint compliances, cofirm that they realize the point
    %compliance, and ouput the compliances and joint locations
    compOutputs(ax, Ps.K2, 2);

    %Display the circle surrounding contact two to prepare for the
    %synthesis of finger 2
    [c3x, c3y] = grabData('P3', ax);
    rf3 = norm(ll_data(3,:),1);
    drawCircle(ax, rf3, c3x, c3y, 'crcf3', 0)

    %draws a circle around the second contact which has a radius that is the
    %same as the thrid link length
    r33 = ll_data(3,3);
    drawCircle(ax, r33, c3x, c3y, 'crc33', 1)


    elseif phase == 20

    %plots the third finger base joint
    drawPoint(x, y, 'F3J1', ax)
    [c3x, c3y] = grabData('P3', ax);

    %Plots the circle around the base joint that is the length of link 1
    r31 = ll_data(3,1);
    drawCircle(ax, r31, x, y, 'crc31', 1)

    %calculates and plots the lines passing through the base joint (rho and l)
    fingerSynth(ax, x, y, c3x, c3y, Ps.K3, 'J1', 3, 0, 0, 0);

elseif phase == 21
    %finds the point on the first circle that is closest to the location
    %selected
    %plots Joint 2 of the third finger
    %plots red points at the intersections of the second and third circles
    [c3x, c3y] = grabData('P3', ax);
    fingerSynth(ax, x, y, c3x, c3y, Ps.K3, 'J2', 3, ll_data(3,1), ll_data(3,2), ll_data(3,3))

    %plots the circle surrounding the second joint
    [j2x, j2y] = grabData('F3J2', ax);
    r32 = ll_data(3,2);
    if ~isempty(j2x) && ~isempty(j2y)
        drawCircle(ax, r32, j2x, j2y,'crc32', 1)
    else
        return
    end

    


elseif phase == 22
    %Finds which possible location of joint 3 is closer to the selected
    %point
    %Plots the third joint 
    %connects the Joints with link lines
    [c3x, c3y] = grabData('P3', ax);
    fingerSynth(ax, x, y, c3x, c3y, 0, 'J3', 3, 0, 0, 0)

    %deletes the circles surrounding the joints
    delete(findobj(fig, 'Tag', 'crc31'))
    delete(findobj(fig, 'Tag', 'crc32'))
    delete(findobj(fig, 'Tag', 'crc33'))
    delete(findobj(fig, 'Tag', 'crcf3'))
    delete(findobj(fig, 'Tag', 'rho3'))
    delete(findobj(fig, 'Tag', 'l3'))

    %Calculate the joint compliances, cofirm that they realize the point
    %compliance, and ouput the compliances and joint locations
    compOutputs(ax, Ps.K3, 3);
    delete(findobj(ax, 'Tag', 'rho'))
    delete(findobj(ax, 'Tag', 'l'))



end


end