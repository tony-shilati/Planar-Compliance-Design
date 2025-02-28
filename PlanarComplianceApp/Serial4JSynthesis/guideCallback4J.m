function [] = guideCallback4J(~, ~, str, msg)

global gdeData4J 

%Gets the msg object
msg_string = get(msg, 'String');

%% checks which message needs to be displayed and displays it
if strcmp(str, 'Next')
    if strcmp(msg_string(1,1), 'W')
        set(msg, 'String', gdeData4J.msg2)
        set(msg, 'FontSize', 0.04)

    elseif strcmp(msg_string,gdeData4J.msg2)
        set(msg, 'String', gdeData4J.msg3)
        set(msg, 'FontSize', 0.04)

    elseif strcmp(msg_string,gdeData4J.msg3)
        set(msg, 'String', gdeData4J.msg4)
        set(msg, 'FontSize', 0.04)

    elseif strcmp(msg_string,gdeData4J.msg4)
        set(msg, 'String', gdeData4J.msg5)
        set(msg, 'FontSize', 0.04)

    elseif strcmp(msg_string,gdeData4J.msg5)
        set(msg, 'String', gdeData4J.msg6)
        set(msg, 'FontSize', 0.04)

    elseif strcmp(msg_string,gdeData4J.msg6)
        set(msg, 'String', gdeData4J.msg7)
        set(msg, 'FontSize', 0.04)
    end

elseif strcmp(str,'Previous')
    if strcmp(msg_string, gdeData4J.msg2)
        set(msg, 'String', gdeData4J.msg1)
        set(msg, 'FontSize', 0.026)

    elseif strcmp(msg_string,gdeData4J.msg3)
        set(msg, 'String', gdeData4J.msg2)
        set(msg, 'FontSize', 0.04)

    elseif strcmp(msg_string,gdeData4J.msg4)
        set(msg, 'String', gdeData4J.msg3)
        set(msg, 'FontSize', 0.04)

    elseif strcmp(msg_string,gdeData4J.msg5)
        set(msg, 'String', gdeData4J.msg4)
        set(msg, 'FontSize', 0.04)

    elseif strcmp(msg_string,gdeData4J.msg6)
        set(msg, 'String', gdeData4J.msg5)
        set(msg, 'FontSize', 0.04)

    elseif strcmp(msg_string,gdeData4J.msg7)
        set(msg, 'String', gdeData4J.msg6)
        set(msg, 'FontSize', 0.04)
    end

end


end