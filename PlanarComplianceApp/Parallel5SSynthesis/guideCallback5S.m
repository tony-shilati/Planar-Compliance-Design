function [] = guideCallback5S(~, ~, str, msg)

global gdeData5S 

%Gets the msg object
msg_string = get(msg, 'String');

%% checks which message needs to be displayed and displays it
if strcmp(str, 'Next')
    if strcmp(msg_string(1:10), '        W ')
        set(msg, 'String', gdeData5S.msg2)

    elseif strcmp(msg_string,gdeData5S.msg2)
        set(msg, 'String', gdeData5S.msg3)

    elseif strcmp(msg_string,gdeData5S.msg3)
        set(msg, 'String', gdeData5S.msg4)

    elseif strcmp(msg_string,gdeData5S.msg4)
        set(msg, 'String', gdeData5S.msg5)

    elseif strcmp(msg_string,gdeData5S.msg5)
        set(msg, 'String', gdeData5S.msg6)

    elseif strcmp(msg_string,gdeData5S.msg6)
        set(msg, 'String', gdeData5S.msg7)

    end

elseif strcmp(str,'Previous')
    if strcmp(msg_string, gdeData5S.msg2)
        set(msg, 'String', gdeData5S.msg1)

    elseif strcmp(msg_string,gdeData5S.msg3)
        set(msg, 'String', gdeData5S.msg2)

    elseif strcmp(msg_string,gdeData5S.msg4)
        set(msg, 'String', gdeData5S.msg3)

    elseif strcmp(msg_string,gdeData5S.msg5)
        set(msg, 'String', gdeData5S.msg4)

    elseif strcmp(msg_string,gdeData5S.msg6)
        set(msg, 'String', gdeData5S.msg5)

    elseif strcmp(msg_string,gdeData5S.msg7)
        set(msg, 'String', gdeData5S.msg6)

    end

end

end