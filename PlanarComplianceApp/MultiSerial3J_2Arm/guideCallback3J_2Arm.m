function [] = guideCallback3J_2Arm(~, ~, str, msg)

global gdeData3J_2Arm

%Gets the msg object
msg_string = get(msg, 'String');

%% checks which message needs to be displayed and displays it
if strcmp(str, 'Next')
    if strcmp(msg_string(1:10), '          ')
        set(msg, 'String', gdeData3J_2Arm.msg2)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg2)
        set(msg, 'String', gdeData3J_2Arm.msg3)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg3)
        set(msg, 'String', gdeData3J_2Arm.msg4)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg4)
        set(msg, 'String', gdeData3J_2Arm.msg5)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg5)
        set(msg, 'String', gdeData3J_2Arm.msg6)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg6)
        set(msg, 'String', gdeData3J_2Arm.msg7)
        
    elseif strcmp(msg_string,gdeData3J_2Arm.msg7)
        set(msg, 'String', gdeData3J_2Arm.msg8)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg8)
        set(msg, 'String', gdeData3J_2Arm.msg9)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg9)
        set(msg, 'String', gdeData3J_2Arm.msg10)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg10)
        set(msg, 'String', gdeData3J_2Arm.msg11)

    end

elseif strcmp(str,'Previous')
    if strcmp(msg_string, gdeData3J_2Arm.msg2)
        set(msg, 'String', gdeData3J_2Arm.msg1)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg3)
        set(msg, 'String', gdeData3J_2Arm.msg2)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg4)
        set(msg, 'String', gdeData3J_2Arm.msg3)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg5)
        set(msg, 'String', gdeData3J_2Arm.msg4)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg6)
        set(msg, 'String', gdeData3J_2Arm.msg5)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg7)
        set(msg, 'String', gdeData3J_2Arm.msg6)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg8)
        set(msg, 'String', gdeData3J_2Arm.msg7)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg9)
        set(msg, 'String', gdeData3J_2Arm.msg8)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg10)
        set(msg, 'String', gdeData3J_2Arm.msg9)

    elseif strcmp(msg_string,gdeData3J_2Arm.msg11)
        set(msg, 'String', gdeData3J_2Arm.msg10)

    end

end

end