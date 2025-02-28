function [] = guideCallback3J_3Finger(~, ~, str, msg)

global gdeData3J_3Finger

%Gets the msg object
msg_string = get(msg, 'String');

%% checks which message needs to be displayed and displays it
if strcmp(str, 'Next')
    if strcmp(msg_string(1:10), '          ')
        set(msg, 'String', gdeData3J_3Finger.msg2)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg2)
        set(msg, 'String', gdeData3J_3Finger.msg3)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg3)
        set(msg, 'String', gdeData3J_3Finger.msg4)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg4)
        set(msg, 'String', gdeData3J_3Finger.msg5)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg5)
        set(msg, 'String', gdeData3J_3Finger.msg6)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg6)
        set(msg, 'String', gdeData3J_3Finger.msg7)
        
    elseif strcmp(msg_string,gdeData3J_3Finger.msg7)
        set(msg, 'String', gdeData3J_3Finger.msg8)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg8)
        set(msg, 'String', gdeData3J_3Finger.msg9)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg9)
        set(msg, 'String', gdeData3J_3Finger.msg10)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg10)
        set(msg, 'String', gdeData3J_3Finger.msg11)

    end

elseif strcmp(str,'Previous')
    if strcmp(msg_string, gdeData3J_3Finger.msg2)
        set(msg, 'String', gdeData3J_3Finger.msg1)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg3)
        set(msg, 'String', gdeData3J_3Finger.msg2)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg4)
        set(msg, 'String', gdeData3J_3Finger.msg3)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg5)
        set(msg, 'String', gdeData3J_3Finger.msg4)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg6)
        set(msg, 'String', gdeData3J_3Finger.msg5)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg7)
        set(msg, 'String', gdeData3J_3Finger.msg6)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg8)
        set(msg, 'String', gdeData3J_3Finger.msg7)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg9)
        set(msg, 'String', gdeData3J_3Finger.msg8)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg10)
        set(msg, 'String', gdeData3J_3Finger.msg9)

    elseif strcmp(msg_string,gdeData3J_3Finger.msg11)
        set(msg, 'String', gdeData3J_3Finger.msg10)

    end

end

end