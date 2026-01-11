-- Registered events: gmcp.comm.tell

function echoTell()
  FEDUI.chatWindow:cecho('<ansiRed>' .. gmcp.comm.tell.from .. ' tight beams you: "' .. gmcp.comm.tell.message .. '"\n')
end
