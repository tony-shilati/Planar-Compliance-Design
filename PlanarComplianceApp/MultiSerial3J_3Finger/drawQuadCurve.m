function [] = drawQuadCurve(ax, K, num)
%Get the first four lines
[l1x, l1y] = grabData('L1',ax);
[l2x, l2y] = grabData('L2', ax);
[l3x, l3y] = grabData('L3', ax);
[l4x, l4y] = grabData('L4', ax);

%Use wrench from line to get the first four wrenches
w1 = wrenchFromLine(l1x(1), l1y(1), l1x(2), l1y(2));
w2 = wrenchFromLine(l2x(1), l2y(1), l2x(2), l2y(2));
w3 = wrenchFromLine(l3x(1), l3y(1), l3x(2), l3y(2));
w4 = wrenchFromLine(l4x(1), l4y(1), l4x(2), l4y(2));

%Use the crossproduct of the wrenches to get the neccesary unit wrenches
t12 = cross(w1, w2); t12 = t12/t12(3);
t34 = cross(w3, w4); t34 = t34/t34(3);
t13 = cross(w1, w3); t13 = t13/t13(3);
t24 = cross(w2, w4); t24 = t24/t24(3);

%Calculate the B matrix
B = (t12'*K*t34)*(t13*t24') - (t13'*K*t24)*(t12*t34');

%Calculate the H matrix
H = B + B';
H = inv(H);

h = @(x,y) H(1,1)*y.^2 + H(2,2)*x.^2 - 2*H(1,2)*x.*y + 2*H(1,3)*y - 2*H(2,3)*x + H(3,3);

xlim = get(ax, 'xlim');

if num == 1
    
   qc = findobj(ax, 'Tag', 'QuadCurve');
   if ~isempty(qc)
        delete(qc)
   end

   QC = fimplicit(ax, h, 'LineWidth', 1, 'Color', 'r', 'Tag', 'QuadCurve');
   uistack(QC, 'bottom')

elseif num > 3
    [l5x, l5y] = grabData('L5', ax);
    w5 = wrenchFromLine(l5x(1), l5y(1), l5x(2), l5y(2));
    [l6x, l6y] = grabData('L6', ax);
    w6 = wrenchFromLine(l6x(1), l6y(1), l6x(2), l6y(2));

    t35 = cross(w3, w5);
    t45 = cross(w4, w5);
    t16 = cross(w1, w6);
    t15 = cross(w1, w5);
    t46 = cross(w4, w6);
    t56 = cross(w5, w6); 
    t26 = cross(w2, w6);
    t23 = cross(w2, w3);
    t25 = cross(w2, w5);
    t36 = cross(w3, w6);
    t14 = cross(w1, w4);



    if num == 4
        A5 = (t23'*w4)*(t56'*w4)*t25*t36' - (t25'*w4)*(t36'*w4)*t23*t56';
        G5 = A5 + A5';
        G5 = inv(G5);
    
        g = @(x,y) G5(1,1)*y.^2 + G5(2,2)*x.^2 - 2*G5(1,2)*x.*y + 2*G5(1,3)*y - 2*G5(2,3)*x + G5(3,3);

        qc = findobj(ax, 'Tag', 'QuadCurve');
        if ~isempty(qc)
             delete(qc)
        end
    
        QC = fimplicit(ax, g, 'LineWidth', 1, 'Color', [0 0.4470 0.7410], 'Tag', 'QuadCurve');
        uistack(QC, 'bottom')


    elseif num == 5
        A5 = (t34'*w5)*(t16'*w5)*t36*t14' - (t36'*w5)*(t14'*w5)*t34*t16';
        G5 = A5 + A5';
        G5 = inv(G5);
    
        g = @(x,y) G5(1,1)*y.^2 + G5(2,2)*x.^2 - 2*G5(1,2)*x.*y + 2*G5(1,3)*y - 2*G5(2,3)*x + G5(3,3);

        qc = findobj(ax, 'Tag', 'QuadCurve');
        if ~isempty(qc)
             delete(qc)
        end
    
        QC = fimplicit(ax, g, 'LineWidth', 1, 'Color', [0.9290 0.6940 0.1250], 'Tag', 'QuadCurve');
        uistack(QC, 'bottom')



    elseif num == 6
        A5 = (t12'*w4)*(t56'*w4)*t15*t26' - (t15'*w4)*(t26'*w4)*t12*t56';
        G5 = A5 + A5';
        G5 = inv(G5);
    
        g = @(x,y) G5(1,1)*y.^2 + G5(2,2)*x.^2 - 2*G5(1,2)*x.*y + 2*G5(1,3)*y - 2*G5(2,3)*x + G5(3,3);

        qc = findobj(ax, 'Tag', 'QuadCurve');
        if ~isempty(qc)
             delete(qc)
        end
    
        QC = fimplicit(ax, g, 'LineWidth', 1, 'Color', [0.8500 0.3250 0.0980], 'Tag', 'QuadCurve');
        uistack(QC, 'bottom')


    elseif num == 7
        A5 = (t12'*w3)*(t56'*w3)*t15*t26' - (t15'*w3)*(t26'*w3)*t12*t56';
        G5 = A5 + A5';
        G5 = inv(G5);
    
        g = @(x,y) G5(1,1)*y.^2 + G5(2,2)*x.^2 - 2*G5(1,2)*x.*y + 2*G5(1,3)*y - 2*G5(2,3)*x + G5(3,3);

        qc = findobj(ax, 'Tag', 'QuadCurve');
        if ~isempty(qc)
             delete(qc)
        end
    
        QC = fimplicit(ax, g, 'LineWidth', 1, 'Color', [0.4940 0.1840 0.5560], 'Tag', 'QuadCurve');
        uistack(QC, 'bottom')

    elseif num == 8
        A5 = (t12'*w3)*(t46'*w3)*t14*t26' - (t14'*w3)*(t26'*w3)*t12*t46';
        G5 = A5 + A5';
        G5 = inv(G5);
    
        g = @(x,y) G5(1,1)*y.^2 + G5(2,2)*x.^2 - 2*G5(1,2)*x.*y + 2*G5(1,3)*y - 2*G5(2,3)*x + G5(3,3);

        qc = findobj(ax, 'Tag', 'QuadCurve');
        if ~isempty(qc)
             delete(qc)
        end
    
        QC = fimplicit(ax, g, 'LineWidth', 1, 'Color', [0.4660 0.6740 0.1880], 'Tag', 'QuadCurve');
        uistack(QC, 'bottom')


    elseif num == 9
        A5 = (t12'*w3)*(t45'*w3)*t14*t25' - (t14'*w3)*(t25'*w3)*t12*t45';
        G5 = A5 + A5';
        G5 = inv(G5);
    
        g = @(x,y) G5(1,1)*y.^2 + G5(2,2)*x.^2 - 2*G5(1,2)*x.*y + 2*G5(1,3)*y - 2*G5(2,3)*x + G5(3,3);

        qc = findobj(ax, 'Tag', 'QuadCurve');
        if ~isempty(qc)
             delete(qc)
        end
    
        QC = fimplicit(ax, g, 'LineWidth', 1, 'Color', [0.3010 0.7450 0.9330], 'Tag', 'QuadCurve');
        uistack(QC, 'bottom')



    end


end  

end