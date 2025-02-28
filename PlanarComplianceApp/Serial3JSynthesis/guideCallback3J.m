function [] = guideCallback3J(~, ~, str, msg)

global gdeData3J 

%Gets the msg object
msg_string = get(msg, 'String');

%% checks which message needs to be displayed and displays it
if strcmp(str, 'Next')
    if strcmp(msg_string(1), 'W')
        set(msg, 'String', gdeData3J.msg2)
        set(msg, 'FontSize', 0.04)

    elseif strcmp(msg_string, gdeData3J.msg2)
        set(msg, 'String', gdeData3J.msg3)
        set(msg, 'FontSize', 0.04)

    elseif strcmp(msg_string, gdeData3J.msg3)

    end


elseif strcmp(str, 'Previous')
    if strcmp(msg_string, gdeData3J.msg1)

    elseif strcmp(msg_string,gdeData3J.msg2)
        set(msg, 'String', gdeData3J.msg1)
        set(msg, 'FontSize', 0.0275)

    elseif strcmp(msg_string, gdeData3J.msg3)
        set(msg, 'String', gdeData3J.msg2)
        set(msg, 'FontSize', 0.04)

    end

end


end