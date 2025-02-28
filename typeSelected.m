function typeSelected(src, event, str)

global dd1 dd2 dd3 dd4 dd5 dd6 dd7 dd8 vil val val5

val = event.Value;      %Which option dd1 was switched to
vil = src.Items;        %The list of items in dd1


if strcmp(str, 'dd1')
    for i = 2:4
        try
            if val == vil{i}
                if i == 2
                    %Turns on neccessary drop downs
                    dd2.Enable = 'on';
                    dd2.Items = {'','3', '4', '5', '6'};
                    dd2.Placeholder = 'Number of Joints';
                    dd2.Visible = 'on';
                    dd5.Visible = 'on';

                    %Turns off neccessary drop downs
                    dd3.Visible = 'off';
                    dd4.Visible = 'off';
                    dd6.Visible = 'off';
                    dd7.Visible = 'off';
                    dd8.Visible = 'off';

                elseif i == 3
                    %Turns on neccessary drop downs
                    dd2.Enable = 'on';
                    dd2.Items = {'','3', '4', '5', '6'};
                    dd2.Placeholder = 'Number of Springs';
                    dd1.Layout.Row = 3;
                    dd2.Visible = 'on';

                    %Turns off neccessary drop downs
                    dd5.Visible = 'off';
                    dd3.Visible = 'off';
                    dd4.Visible = 'off';
                    dd6.Visible = 'off';
                    dd7.Visible = 'off';
                    dd8.Visible = 'off';
                    
                elseif i == 4
                    %Turns on neccessary drop downs
                    dd6.Visible = 'on';

                    %Turns off neccessary drop downs
                    dd2.Visible = 'off';
                    dd3.Visible = 'off';
                    dd4.Visible = 'off';
                    dd5.Visible = 'off';
                    dd7.Visible = 'off';
                    dd8.Visible = 'off';
                    
                    
                else
                    dd2.Enable = 'off';
                end
            end
        catch
            continue
        end 
    end

elseif strcmp(str, 'dd5')
    for i = 2:3
        try
            if val == vil{i}
                if i == 2
                    dd2.Items = {'', '5', '6'};
                elseif i == 3
                    dd2.Items = {'','3', '4', '5', '6'};

                end
            end
        catch
        end
    end

end
end

