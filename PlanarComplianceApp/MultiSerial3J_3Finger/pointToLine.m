function [X, Y] = pointToLine(x, y)
%This function finds the distance between each edge of the object and the
%input point, then compares them to find out which edge the object is
%closest to. Then it continues the location of the point of intersection of 
%the line that perpendicularly intersects the closest edge and the point,
%and the closest edge. 

%Global vars: varible containing the vetricies of the user defined object
global V3J_3F
 
%Initalize X and Y variables as an empty vector incase no values are
%assigned

X = [];
Y = [];

%% Loops through each edge and finds the distance between the point and that edge

%-X and -Y coordinates of verticies
Vx = V3J_3F.x;
Vy = V3J_3F.y;

%number of verticies
l = length(Vx);

distances = zeros(1,l);

%Perpendicular intersection locations for the line and the point
perp_intX = zeros(1,l);
perp_intY = zeros(1,l);


for i = 1:(l - 1)
    %Turns vector entries into independent variables
    vx1 = Vx(i); vy1 = Vy(i);
    vx2 = Vx(i+1); vy2 = Vy(i+1);

    %finds the slope of the edge
    m = (vy2 - vy1) / (vx2 - vx1);

    %finds the perpendicular intersection location
    [xint, yint] = perpIntersect(vx1, vy1, m, x, y);

    %logs the coordinates of the perpendicular intersection location to
    %their respective vectors. 
    perp_intY(i) = yint;
    perp_intX(i) = xint;

    %finds the distance between the intersection location and point
    d = sqrt((xint - x)^2 + (yint - y)^2);

    %logs the distabnce to the distance vector
    distances(i) = d;

end

%slope of the edge connecting the last defined vertex to the first defined
%vertex. 
ml1 = (Vy(l) - Vy(1)) / (Vx(l) - Vx(1));

%finds the perpendicular intersection location of the input point and the
%last edge
[xint, yint] = perpIntersect(Vx(l), Vy(l), ml1, x, y);

%logs the coordinates of the perpendicular intersection location to
%their respective vectors. 
perp_intY(l) = yint;
perp_intX(l) = xint;

%finds the distance between the intersection location and point
d = norm([(xint - x), (yint - y)]);

%logs the distabnce to the distance vector
distances(l) = d;

%% Finds the shortest distance between the point and an edge and continues their intersection location.
ordered_dist = unique(distances);

%This loop looks at the closest edge and makes sure that the point of
%intesection with the edge line is between the two verticies that define
%the edge. If it is not it will find the next closest edge and check the
%same information. 

num = 1; % allows the index of ordered_dist being checked to be increased

for i = 1:l
    
    %% Finds which edge has the shortest distance
    for j = 1:l
        if ordered_dist(num) == distances(j)
            check = j;
            break
        end
    end


    check_x = perp_intX(check);
    check_y = perp_intY(check);

    %% Checks the verticies locations relative to eachother then finds out if the intersection point is between them
    % The if else satement checks if the closest edge is the unique edge
    % between the last defined vertex and the first defined vertex



    %% If the last vertex is fatrther to the right than the first vertex
    if check == l
        if Vx(l) > Vx(1)
            if Vy(l) > Vy(1)
                if Vx(1) < check_x && check_x < Vx(l) && Vy(1) < check_y && check_y < Vy(l)
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            elseif Vy(l) < Vy(1)
                if Vx(1) < check_x && check_x < Vx(l) && Vy(l) < check_y && check_y < Vy(1)
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            elseif Vy(l) == Vy(1)
                if Vx(1) < check_x && check_x < Vx(l)
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            end


        elseif Vx(l) < Vx(1)
            if Vy(l) > Vy(1)
                if Vx(l) < check_x && check_x < Vx(1) && Vy(1) < check_y && check_y < Vy(l)
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end
                
            elseif Vy(l) < Vy(1)
                if Vx(l) < check_x && check_x < Vx(1) && Vy(l) < check_y && check_y < Vy(1)
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            elseif Vy(l) == Vy(1)
                if Vx(l) < check_x && check_x < Vx(1)
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            end

        elseif Vx(l) == Vx(1)

            if Vy(l) > Vy(1)
                if Vy(1) < check_y && check_y < Vy(l)
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            elseif Vy(l) < Vy(1)
                if Vy(l) < check_y && check_y < Vy(1)
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            elseif Vy(l) == Vy(1)
                num = num + 1;
                continue

            end

        end
        %% 

    else
        vxc = Vx(check); vyc = Vy(check);
        vxc1 = Vx(check + 1); vyc1 = Vy(check + 1);
        if vxc > vxc1
            if vyc > vyc1
                if vxc1 < check_x && check_x < vxc && vyc1 < check_y && check_y < vyc
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            elseif vyc < vyc1
                if vxc1 < check_x && check_x < vxc && vyc < check_y && check_y < vyc1
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            elseif vyc == vyc1
                if vxc1 < check_x && check_x < vxc
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            end


        elseif vxc < vxc1
            if vyc > vyc1
                if vxc < check_x && check_x < vxc1 && vyc1 < check_y && check_y < vyc
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end
                

            elseif vyc < vyc1
                if vxc < check_x && check_x < vxc1 && vyc < check_y && check_y < vyc1
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            elseif vyc == vyc1
                if vxc < check_x && check_x < vxc1
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            end

        elseif vxc == vxc1
            if vyc > vyc1
                if vyc1 < check_y && check_y < vyc
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            elseif vyc < vyc1
                if vyc < check_y && check_y < vyc1
                    X = check_x;
                    Y = check_y;
                    break
                else
                    num = num + 1;
                    continue
                end

            elseif vyc == vyc1
                num = num + 1;
                continue

            end


        end


    end

end



end
