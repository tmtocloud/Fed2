-- This is a trigger with regex: ^$

if not FEDUI.cargo.lastLineWasPrice or #FEDUI.cargo.data == 0 then 
  FEDUI.cargo.lastLineWasPrice = false
  return 
end

FEDUI.cargo.lastLineWasPrice = false

local function rpad(str, len)
  str = tostring(str)
  local pad = len - #str
  if pad > 0 then
    return str .. string.rep(" ", pad)
  end
  return str:sub(1, len)
end

-- Sort by price
table.sort(FEDUI.cargo.data, function(a, b)
  return a.price < b.price
end)

-- Display header
FEDUI.cargoWindow:cecho("<white>System    Planet        Action  Qty   Price\n")
FEDUI.cargoWindow:cecho("<white>──────────────────────────────────────────\n")

-- Display each entry
for _, item in ipairs(FEDUI.cargo.data) do
  -- Column A: Combined action + command
  local actionBtn
  if item.action == "buying" then
    actionBtn = "<green>[SELL]<reset>"
  else
    actionBtn = "<yellow>[BUY]<reset> "
  end
  
  FEDUI.cargoWindow:cecho(rpad(item.system, 9) .. " ")
  
  -- Clickable planet name (truncated to 13 chars)
  local planetDisplay = rpad(item.planet:sub(1, 13), 13)
  FEDUI.cargoWindow:cechoLink(
    "<ansiCyan>" .. planetDisplay .. "<reset>",
    function() send("whereis " .. item.planet) end,
    item.planet,  -- Full name in tooltip
    true
  )
  
  FEDUI.cargoWindow:cecho(" ")
  
  -- Clickable action button
  local cmd = (item.action == "buying") and "sell " or "buy "
  FEDUI.cargoWindow:cechoLink(
    actionBtn,
    function() send(cmd .. FEDUI.cargo.currentCommodity) end,
    cmd .. FEDUI.cargo.currentCommodity,
    true
  )
  
  FEDUI.cargoWindow:cecho(" " .. rpad(item.quantity, 5) .. " ")
  FEDUI.cargoWindow:cecho(rpad(item.price .. "ig", 6) .. "\n")
end

FEDUI.cargoWindow:cecho("\n<white>" .. #FEDUI.cargo.data .. " exchanges\n")
deleteLine()
