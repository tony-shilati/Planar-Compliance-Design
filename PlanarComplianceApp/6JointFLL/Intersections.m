function [x1, y1, x2, y2] = Intersections(str, m, b, E1, T1, E2, T2)
%cl indicates a circle-line intersection 
%cc indicates a circle-circle intersection
try
    if strcmp(str, 'cl')
        syms sx sy
       
        t = [sy; -sx; 1];
    
        eqns = [(sy == m*sx + b);
                (t'*(T1'*E1*T1)*t == 0)];
        
        intersections = [0,0;0,0];
    
        %solve for the corrdinates of the intersections
        while intersections(1,:) == intersections(2,:)
            for n = 1:2
                S = vpasolve(eqns,[sx,sy],'Random',true);
              
                intersections(n,1) = S.sx(1);
                intersections(n,2) = S.sy(1);
                  
            end
        end
    
        %Assign the intersection coordinates to variables
        x1 = double(intersections(1,1)); x2 = double(intersections(2,1));
        y1 = double(intersections(1,2)); y2 = double(intersections(2,2));
    
    elseif strcmp(str, 'cc')
        syms sx sy
       
        t = [sy; -sx; 1];
    
        eqns = [(t'*(T2'*E2*T2)*t == 0);
                (t'*(T1'*E1*T1)*t == 0)];
        
        intersections = [0,0;0,0];
    
        %solve for the corrdinates of the intersections
        while intersections(1,:) == intersections(2,:)
            for n = 1:2
                S = vpasolve(eqns,[sx,sy],'Random',true);
              
                intersections(n,1) = S.sx(1);
                intersections(n,2) = S.sy(1);
                  
            end
        end
    
        %Assign the intersection coordinates to variables
        x1 = double(intersections(1,1)); x2 = double(intersections(2,1));
        y1 = double(intersections(1,2)); y2 = double(intersections(2,2));
    end
catch 
end


end