-- Registered events: gmcp.comm.say

function echoSay()
  FEDUI.chatWindow:cecho('<ansiCyan>' .. gmcp.comm.say.from .. ' says: "' .. gmcp.comm.say.message .. '"\n')
end
