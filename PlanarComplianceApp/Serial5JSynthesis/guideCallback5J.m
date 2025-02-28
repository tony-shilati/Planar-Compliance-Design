function [] = guideCallback5J(~, ~, str, msg)

global gdeData5J 

%Gets the msg object
msg_string = get(msg, 'String');

%% checks which message needs to be displayed and displays it
if strcmp(str, 'Next')
    if strcmp(msg_string(1:10), '        W ')
        set(msg, 'String', gdeData5J.msg2)

    elseif strcmp(msg_string,gdeData5J.msg2)
        set(msg, 'String', gdeData5J.msg3)

    elseif strcmp(msg_string,gdeData5J.msg3)
        set(msg, 'String', gdeData5J.msg4)

    elseif strcmp(msg_string,gdeData5J.msg4)
        set(msg, 'String', gdeData5J.msg5)

    elseif strcmp(msg_string,gdeData5J.msg5)
        set(msg, 'String', gdeData5J.msg6)

    elseif strcmp(msg_string,gdeData5J.msg6)
        set(msg, 'String', gdeData5J.msg7)

    elseif strcmp(msg_string,gdeData5J.msg7)
        set(msg, 'String', gdeData5J.msg8)
    end

elseif strcmp(str,'Previous')
    if strcmp(msg_string, gdeData5J.msg2)
        set(msg, 'String', gdeData5J.msg1)

    elseif strcmp(msg_string,gdeData5J.msg3)
        set(msg, 'String', gdeData5J.msg2)

    elseif strcmp(msg_string,gdeData5J.msg4)
        set(msg, 'String', gdeData5J.msg3)

    elseif strcmp(msg_string,gdeData5J.msg5)
        set(msg, 'String', gdeData5J.msg4)

    elseif strcmp(msg_string,gdeData5J.msg6)
        set(msg, 'String', gdeData5J.msg5)

    elseif strcmp(msg_string,gdeData5J.msg7)
        set(msg, 'String', gdeData5J.msg6)

    elseif strcmp(msg_string,gdeData5J.msg8)
        set(msg, 'String', gdeData5J.msg7)
    end

end


end