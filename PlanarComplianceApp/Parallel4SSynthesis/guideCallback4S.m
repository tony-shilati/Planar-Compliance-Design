function [] = guideCallback4S(~, ~, str, msg)

global gdeData4S 

%Gets the msg object
msg_string = get(msg, 'String');
%% checks which message needs to be displayed and displays it
if strcmp(str, 'Next')
    if strcmp(msg_string(1), 'W')
        set(msg, 'String', gdeData4S.msg2)

    elseif strcmp(msg_string,gdeData4S.msg2)
        set(msg, 'FontSize', 0.035)
        set(msg, 'String', gdeData4S.msg3)
        
    elseif strcmp(msg_string,gdeData4S.msg3)
        set(msg, 'String', gdeData4S.msg4)

    elseif strcmp(msg_string,gdeData4S.msg4)
        set(msg, 'String', gdeData4S.msg5)

    elseif strcmp(msg_string,gdeData4S.msg5)
        set(msg, 'String', gdeData4S.msg6)

    end

elseif strcmp(str,'Previous')
    if strcmp(msg_string, gdeData4S.msg2)
        set(msg, 'String', gdeData4S.msg1)

    elseif strcmp(msg_string,gdeData4S.msg3)
        set(msg, 'String', gdeData4S.msg2)

    elseif strcmp(msg_string,gdeData4S.msg4)
        set(msg, 'String', gdeData4S.msg3)

    elseif strcmp(msg_string,gdeData4S.msg5)
        set(msg, 'String', gdeData4S.msg4)

    elseif strcmp(msg_string,gdeData4S.msg6)
        set(msg, 'String', gdeData4S.msg5)

    end

end

end