function Start(~,~,fig)

dd1 = findobj(fig, 'Tag', 'dd1');
dd2 = findobj(fig, 'Tag', 'dd2');
dd3 = findobj(fig, 'Tag', 'dd3');
dd4 = findobj(fig, 'Tag', 'dd4');
dd5 = findobj(fig, 'Tag', 'dd5');
dd6 = findobj(fig, 'Tag', 'dd6');


val = get(dd1, 'Value');
val2 = get(dd2, 'Value');
val3 = get(dd3, 'Value');
val4 = get(dd4, 'Value');
val5 = get(dd5, 'Value');
val6 = get(dd6, 'Value');


% if strcmp(val, '')
%     invalidSelection
% elseif strcmp(val2, '')
%     invalidSelection
% elseif strcmp(val3, '')
%     invalidSelection
% elseif strcmp(val4, '')
%     invalidSelection
% end 



if strcmp(val, 'Serial')
    if strcmp(val5, 'No')
        if strcmp(val2, '3')
            all_fig = findall(0, 'type', 'figure');
            close(all_fig)
            Synthesis3J
        elseif strcmp(val2, '4')
            all_fig = findall(0, 'type', 'figure');
            close(all_fig)
            Synthesis4J
        elseif strcmp(val2, '5')
            all_fig = findall(0, 'type', 'figure');
            close(all_fig)
            Synthesis5J
        elseif strcmp(val2, '6')
            all_fig = findall(0, 'type', 'figure');
            close(all_fig)
            Synthesis6J
        else
            
        end
        
    elseif strcmp(val5, 'Yes')
        if strcmp(val2, '5')
            all_fig = findall(0, 'type', 'figure');
            close(all_fig)
            Synthesis5J_FLL
        elseif strcmp(val2, '6')
            all_fig = findall(0, 'type', 'figure');
            close(all_fig)
            Synthesis6J_FLL
        else
            
        end

    end
elseif strcmp(val, 'Parallel')
    if val2 == '3'
        all_fig = findall(0, 'type', 'figure');
        close(all_fig)
        Synthesis3S
    elseif val2 == '4'
        all_fig = findall(0, 'type', 'figure');
        close(all_fig)
        Synthesis4S()
    elseif val2 == '5'
        all_fig = findall(0, 'type', 'figure');
        close(all_fig)
        Synthesis5S
    elseif val2 == '6'
        all_fig = findall(0, 'type', 'figure');
        close(all_fig)
        Synthesis6S
    else
        invalidSelection
    end
elseif strcmp(val, 'Multiserial')
   if strcmp(val6, 'Rigid')
       Synthesis3J_2Arm

   elseif strcmp(val6, 'Point')
       Synthesis3J_3Finger

   end

end 



end