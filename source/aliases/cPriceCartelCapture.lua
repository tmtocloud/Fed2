-- This is an alias with regex: ^c price (\w+) cartel$

FEDUI.cargo.currentCommodity = matches[2]
FEDUI.cargo.data = {}
FEDUI.cargo.lastLineWasPrice = false
FEDUI.cargoWindow:clear()
send("c price " .. matches[2] .. " cartel", false)
