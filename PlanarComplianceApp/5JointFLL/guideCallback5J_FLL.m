function [] = guideCallback5J_FLL(~, ~, str, msg)

global gdeData5J_FLL

%Gets the msg object
msg_string = get(msg, 'String');
%% checks which message needs to be displayed and displays it
if strcmp(str, 'Next')
    if strcmp(msg_string(1:10), '   T   oW ')
        set(msg, 'String', gdeData5J_FLL.msg2)

    elseif strcmp(msg_string,gdeData5J_FLL.msg2)
        set(msg, 'String', gdeData5J_FLL.msg3)

    elseif strcmp(msg_string,gdeData5J_FLL.msg3)
        set(msg, 'String', gdeData5J_FLL.msg4)

    elseif strcmp(msg_string,gdeData5J_FLL.msg4)
        set(msg, 'String', gdeData5J_FLL.msg5)

    elseif strcmp(msg_string,gdeData5J_FLL.msg5)
        set(msg, 'String', gdeData5J_FLL.msg6)

    elseif strcmp(msg_string,gdeData5J_FLL.msg6)
        set(msg, 'String', gdeData5J_FLL.msg7)
    end

elseif strcmp(str,'Previous')
    if strcmp(msg_string, gdeData5J_FLL.msg2)
        set(msg, 'String', gdeData5J_FLL.msg1)

    elseif strcmp(msg_string,gdeData5J_FLL.msg3)
        set(msg, 'String', gdeData5J_FLL.msg2)

    elseif strcmp(msg_string,gdeData5J_FLL.msg4)
        set(msg, 'String', gdeData5J_FLL.msg3)

    elseif strcmp(msg_string,gdeData5J_FLL.msg5)
        set(msg, 'String', gdeData5J_FLL.msg4)

    elseif strcmp(msg_string,gdeData5J_FLL.msg6)
        set(msg, 'String', gdeData5J_FLL.msg5)

    elseif strcmp(msg_string,gdeData5J_FLL.msg7)
        set(msg, 'String', gdeData5J_FLL.msg6)
    end

end

end