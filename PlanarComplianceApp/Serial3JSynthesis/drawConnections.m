function [ output_args ] = drawConnections(ax)

global C
%finds the children objects of the axes
ch = get(ax,'children');
fig = get(ax, 'Parent');
%deletes the links if they already exists
han = findobj(ch,'tag','link');
if ~isempty(han)
   delete(han);
end

%finds each of the joints on the axes
pt1 = findobj(ch,'tag','point1');
pt2 = findobj(ch,'tag','point2');
pt3 = findobj(ch,'tag','point3');

%puts the joint x and y data into vectors
px = [pt1.XData, pt2.XData, pt3.XData];
py = [pt1.YData, pt2.YData, pt3.YData];


%Plots the links between each joint
plot(ax, px,py,'color',[0.2 0.6 1],'linewidth',2,...
            'tag','link',...
            'pickableparts','none');

%formats the x and y data
px1 = sprintf('%0.3f', pt1.XData);
px2 = sprintf('%0.3f', pt2.XData);
px3 = sprintf('%0.3f', pt3.XData);

py1 = sprintf('%0.3f', pt1.YData);
py2 = sprintf('%0.3f', pt2.YData);
py3 = sprintf('%0.3f', pt3.YData);


try
    %gets the output table object
    jh = findobj(fig,'tag','jout');

    %Gets the data from the output table 
    Jout = get(jh,'Data');

    %Changes the data from the output table
    Jout{1,2} = px1;
    Jout{1,3} = px2;
    Jout{1,4} = px3;
    Jout{2,2} = py1;
    Jout{2,3} = py2;
    Jout{2,4} = py3;

    %sets the new data to the output table
    set(jh,'Data',Jout);
catch
end 

%Calculates the compliance of each joint
[c1, c2, c3, Cmat] = calcCompliance(ax);

%Formats the joint compliances
C1 = sprintf('%0.4f', c1);
C2 = sprintf('%0.4f', c2);
C3 = sprintf('%0.4f', c3);

%Finds the output boxes for the compliances
c1out = findobj(fig, 'Tag', 'comp1');
c2out = findobj(fig, 'Tag', 'comp2');
c3out = findobj(fig, 'Tag', 'comp3');


%Sets the value of the output boxes to the joint compliances
set(c1out, 'String', C1)
set(c2out, 'String', C2)
set(c3out, 'String', C3)


Cout = findobj(fig, 'Tag', 'Cout');
set(Cout, 'Data', Cmat)

