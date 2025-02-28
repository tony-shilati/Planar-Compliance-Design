function [errCode1, errCode2, errCode3] = checkCondintions(ax, C)

global phase


%% first conditon
if phase == 6 
    %Get the neccesary information to be used
    [t12x, t12y] = grabData('P1', ax);
    [j5x, j5y] = grabData('P3', ax);
    [l2x, l2y] = grabData('L2', ax);
    
    %Check if the conditons are satisfied
    
    ml2 = (l2y(1) - l2y(2)) / (l2x(1) - l2x(2));
    
    [I1x, I1y] = perpIntersect(l2x(1), l2y(1), ml2, t12x, t12y);
    [I2x, I2y] = perpIntersect(l2x(1), l2y(1), ml2, j5x, j5y);
    
    check1x = I1x - t12x; check1y = I1y - t12y;
    check2x = I2x - j5x; check2y = I2y - j5y;
    
    if sign(check1x) == sign(check2x) && sign(check1y) == sign(check2y)
        errCode1 = 0;
    else
        errCode1 = 1;
        warndlg(['The position of the fifth joint must be on the same side of the' ...
            ' second wrench as the first twist'], '', 'modal')
        uiwait
        phase = goToPhase(5, ax);


    end
    errCode2 = 0; errCode3 = 0;

    %return errCodes and error Messages if the conditions are not satisfied

end


%% Second and Third Condition

if phase == 9
    %Get the neccesary infromation to be used
    [j1x, j1y] = grabData('J1', ax);
    [j2x, j2y] = grabData('J2', ax);
    [j3x, j3y] = grabData('J3', ax);
    [j4x, j4y] = grabData('J4', ax);
    [j5x, j5y] = grabData('J5', ax);

    %Check if the conditions are staisfied
    %Part 1 - check if the wrench line through two joints passes through
        %the triangle created by the other three joints

    m23 = (j3y - j2y) / (j3x - j2x);        %line to be checked
    b23 = j3y - m23*j3x;

    m14 = (j4y - j1y) / (j4x - j1x);        %line to be checked
    b14 = j4y - m14*j4x;

        %Slopes of lines defining the triangles 
        %Triangle 1:
    m45 = (j5y - j4y) / (j5x - j4x);
    b45 = j5y - m45*j5x;

    m51 = (j1y - j5y) / (j1x - j5x);
    b51 = j1y - m51*j1x;
    %Use m14
        %Triangle 2:
    m35 = (j5y - j3y) / (j5x - j3x);
    b35 = j5y - m35*j5x;

    m52 = (j2y - j5y) / (j2x - j5x);
    b52 = j2y - m52*j2x;
    %Use m23

        %Intersections:
        %first Triangle:
    [Int11x, Int11y] = calcInt(-m23, 1, -m45, 1, b23, b45);
    [Int12x, Int12y] = calcInt(-m23, 1, -m51, 1, b23, b51);
    [Int13x, Int13y] = calcInt(-m23, 1, -m14, 1, b23, b14);

        %Second triangle:
    [Int21x, Int21y] = calcInt(-m14, 1, -m35, 1, b14, b35);
    [Int22x, Int22y] = calcInt(-m14, 1, -m52, 1, b14, b52);
    [Int23x, Int23y] = calcInt(-m14, 1, -m23, 1, b14, b23);

        %Verticies matricies
    v23 = [j2x, j2y; j3x, j3y];
    v14 = [j1x, j1y; j4x, j4y];
    v45 = [j4x, j4y; j5x, j5y];
    v51 = [j5x, j5y; j1x, j1y];
    v35 = [j3x, j3y; j5x, j5y];
    v52 = [j5x, j5y; j2x, j2y];

        %Check if each line intersects the triangle 
        % If IO == 1 then the line intersects, else it doesn't
        i45 = 0; i51 = 0; i14 = 0; IO11 = 0;
    if Int11x >= min(v45(:,1)) && Int11x <= max(v45(:,1)) && Int11y >= min(v45(:,2)) && Int11y <= max(v45(:,2))
        IO11 = 1;
        i45 = 1;
    end

    if Int12x >= min(v51(:,1)) && Int12x <= max(v51(:,1)) && Int12y >= min(v51(:,2)) && Int12y <= max(v51(:,2))
        IO11 = 1;
        i51 = 1;
    end
    
    if Int13x >= min(v14(:,1)) && Int13x <= max(v14(:,1)) && Int13y >= min(v14(:,2)) && Int13y <= max(v14(:,2))
        IO11 = 1;
        i14 = 1;
    end



    i35 = 0;i52 = 0;i23 = 0; IO21 = 0;
    if Int21x >= min(v35(:,1)) && Int21x <= max(v35(:,1)) && Int21y >= min(v35(:,2)) && Int21y <= max(v35(:,2))
        IO21 = 1;
        i35 = 1;
    end
    
    if Int22x >= min(v52(:,1)) && Int22x <= max(v52(:,1)) && Int22y >= min(v52(:,2)) && Int22y <= max(v52(:,2))
        IO21 = 1;
        i52 = 1;

    end

    if Int23x >= min(v23(:,1)) && Int23x <= max(v23(:,1)) && Int23y >= min(v23(:,2)) && Int23y <= max(v23(:,2))
        IO21 = 1;
        i23 = 1;
    end
        

    %Part 2 - check if the twist associated with the wrench line is in
     %the correct region

        %If IO12 = 1, the point is in the region, else it out
     if IO11 == 1
         w23 = wrenchFromLine(j2x, j2y, j3x, j3y);
         w14 = wrenchFromLine(j1x, j1y, j4x, j4y);
         w45 = wrenchFromLine(j4x, j4y, j5x, j5y);
         w51 = wrenchFromLine(j5x, j5y, j1x, j1y);

         t1 = cross(w14, w51); t1 = t1/t1(3);
         t4 = cross(w14, w45); t4 = t4/t4(3);
         t5 = cross(w45, w51); t5 = t5/t5(3);
         t23 = C*w23; t23 = t23/t23(3);

         if i45 == 1 && i51 == 1
             T1 = [t1, t4, t5]; T1(3,1) = -1;
             T2 = -T1; T2(:,1) = t1;

             if all(T1\t23 > 0) || all(T2\t23 > 0)
                 IO12 = 1;
             else
                 IO12 = 0;
             end

             T1 = [t1, t4, t5];
             if all(T1\t23 > 0)
                 IO12 = 0;
             end


         elseif i45 == 1 && i14 == 1
             T1 = [t4, t1, t5]; T1(3,1) = -1;
             T2 = -T1; T2(:,1) = t1;

             if all(T1\t23 > 0) || all(T2\t23 > 0)
                 IO12 = 1;
             else
                 IO12 = 0;
             end

             T1 = [t4, t1, t5];
             if all(T1\t23 > 0)
                 IO12 = 0;
             end

         elseif i51 == 1 && i14 == 1
             T1 = [t5, t1, t4]; T1(3,1) = -1;
             T2 = -T1; T2(:,1) = t1;

             if all(T1\t23 > 0) || all(T2\t23 > 0)
                 IO12 = 1;
             else
                 IO12 = 0;
             end

             T1 = [t5, t1, t4];
             if all(T1\t23 > 0)
                 IO12 = 0;
             end

         end


     elseif IO11 == 0
         w23 = wrenchFromLine(j2x, j2y, j3x, j3y);
         w14 = wrenchFromLine(j1x, j1y, j4x, j4y);
         w45 = wrenchFromLine(j4x, j4y, j5x, j5y);
         w51 = wrenchFromLine(j5x, j5y, j1x, j1y);

         t1 = cross(w14, w51); t1 = t1/t1(3);
         t4 = cross(w14, w45); t4 = t4/t4(3);
         t5 = cross(w45, w51); t5 = t5/t5(3);
         t23 = C*w23; t23 = t23/t23(3);

         

         T = [t1, t4, t5];
         X = T\t23;

         if any(X <= 0)
             IO12 = 0;
         else
             IO12 = 1;
         end
    


     end

     

     %If IO22 = 1, the point is in the region, else it out
     if IO21 == 1
         w14 = wrenchFromLine(j1x, j1y, j4x, j4y);
         w23 = wrenchFromLine(j2x, j2y, j3x, j3y);
         w35 = wrenchFromLine(j3x, j3y, j5x, j5y);
         w52 = wrenchFromLine(j5x, j5y, j2x, j2y);

         t2 = cross(w23, w52); t2 = t2/t2(3);
         t3 = cross(w23, w35); t3 = t3/t3(3);
         t5 = cross(w35, w52); t5 = t5/t5(3);
         t14 = C*w14; t14 = t14/t14(3);

         if i35 == 1 && i52 == 1
             T1 = [t5, t2, t3]; T1(3,1) = -1;
             T2 = -T1; T2(:,1) = t1;

             if all(T1\t14 > 0) || all(T2\t14 > 0)
                 IO22 = 1;
             else
                 IO22 = 0;
             end

             T1 = [t5, t2, t3];
             if all(T1\t14 > 0)
                 IO22 = 0;
             end


         elseif i35 == 1 && i23 == 1
             T1 = [t3, t2, t5]; T1(3,1) = -1;
             T2 = -T1; T2(:,1) = t1;

             if all(T1\t14 > 0) || all(T2\t14 > 0)
                 IO22 = 1;
             else
                 IO22 = 0;
             end

             T1 = [t3, t2, t5];
             if all(T1\t14 > 0)
                 IO22 = 0;
             end

         elseif i52 == 1 && i23 == 1
             T1 = [t2, t3, t5]; T1(3,1) = -1;
             T2 = -T1; T2(:,1) = t1;

             if all(T1\t14 > 0) || all(T2\t14 > 0)
                 IO22 = 1;
             else
                 IO22 = 0;
             end

             T1 = [t2, t3, t5];
             if all(T1\t14 > 0)
                 IO22 = 0;
             end

         end


     elseif IO21 == 0
         w14 = wrenchFromLine(j1x, j1y, j4x, j4y);
         w23 = wrenchFromLine(j2x, j2y, j3x, j3y);
         w35 = wrenchFromLine(j3x, j3y, j5x, j5y);
         w52 = wrenchFromLine(j5x, j5y, j2x, j2y);

         t2 = cross(w23, w52); t2 = t2/t2(3);
         t3 = cross(w23, w35); t3 = t3/t3(3);
         t5 = cross(w35, w52); t5 = t5/t5(3);
         t14 = C*w14; t14 = t14/t14(3);

         

         T = [t2, t3, t5];
         X = T\t14;

         if any(X <= 0)
             IO22 = 0;
         else
             IO22 = 1;
         end
    
     end

     if IO12 == 1
         errCode2 = 0;
     elseif IO12 == 0
         errCode2 = 1;
         warndlg(['The twist associated with wrench three does not fall in its' ...
             ' designated region. Reposition the wrench to satify this condition'], '', 'modal')
         uiwait
         phase = goToPhase(8,ax);
     end

     if IO22 == 1
         errCode3 = 0;
     elseif IO22 == 0
         errCode3 = 1;
         warndlg(['The twist associated with wrench three does not fall in its' ...
             ' designated region. Reposition the wrench to satify this condition'], '', 'modal')
         uiwait
         phase = goToPhase(8, ax);
     end

     errCode1 = 0;



    %return err codes and err messages if the conditions are not satisfied

end

end