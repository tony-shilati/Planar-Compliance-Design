 function [x,y] = calcIntersections( ax )
% 

[t23x,t23y] = grabData('N5',ax);
[t12x,t12y] = grabData('N1',ax);
[t34x,t34y] = grabData('N2',ax);
[t14x,t14y] = grabData('N6',ax);

[t5x,t5y] = grabData('N3',ax);
[t5x2,t5y2] = grabData('N4',ax);


w1x = [t12x,t14x];
w1y = [t12y,t14y];

w2x = [t12x,t23x];
w2y = [t12y,t23y];

w3x = [t23x,t34x];
w3y = [t23y,t34y];

w4x = [t14x,t34x];
w4y = [t14y,t34y];

w5x = [t5x,t5x2];
w5y = [t5y,t5y2];

drawLine(w1x,w1y,'W1',ax);
drawLine(w2x,w2y,'W2',ax);
drawLine(w3x,w3y,'W3',ax);
drawLine(w4x,w4y,'W4',ax);

%[x1,y1,w1norm] = convertToPoint(w1x,w1y);
%[x2,y2,w2norm] = convertToPoint(w2x,w2y);
%[x3,y3,w3norm] = convertToPoint(w3x,w3y);
%[x4,y4,w4norm] = convertToPoint(w4x,w4y);
%[x5,y5,w5norm] = convertToPoint(w5x,w5y);

% 
% 
%drawPoint(x1,y1,'t1',ax);
%drawPoint(x2,y2,'t2',ax);
%drawPoint(x3,y3,'t3',ax);
%drawPoint(x4,y4,'t4',ax);
%drawPoint(x5,y5,'t5',ax);


% 
%text(x1,y1,'  T1','tag','t1','PickableParts','none');
%text(x2,y2,'  T2','tag','t2','PickableParts','none');
%text(x3,y3,'  T3','tag','t3','PickableParts','none');
%text(x4,y4,'  T4','tag','t4','PickableParts','none');
%text(x5,y5,'  T5','tag','t5','PickableParts','none');
% 
% 




 end 
