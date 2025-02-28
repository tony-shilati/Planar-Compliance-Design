function [] = guideCallback3S(~, ~, str, msg)

global gdeData3S

%% Gets the msg object
msg_string = get(msg, 'String');

%% Finds out which message needs to be displayed and displays it
if strcmp(str, 'Next')
    if strcmp(msg_string(1), 'W')
        set(msg, 'String', gdeData3S.msg2)
        set(msg, 'FontSize', 0.04)

    elseif strcmp(msg_string,gdeData3S.msg2)
        set(msg, 'String', gdeData3S.msg3)
        set(msg, 'FontSize', 0.04)

    elseif strcmp(msg_string,gdeData3S.msg3)
        set(msg, 'String', gdeData3S.msg4)
        set(msg, 'Fontsize', 0.04)

    end

elseif strcmp(str,'Previous')
    if strcmp(msg_string, gdeData3S.msg2)
        set(msg, 'String', gdeData3S.msg1)
        set(msg, 'Fontsize', 0.026)

    elseif strcmp(msg_string,gdeData3S.msg3)
        set(msg, 'String', gdeData3S.msg2)
        set(msg, 'Fontsize', 0.04)

    elseif strcmp(msg_string,gdeData3S.msg4)
        set(msg, 'String', gdeData3S.msg3)
        set(msg, 'Fontsize', 0.04)

    end

end

end