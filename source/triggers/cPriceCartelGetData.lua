-- This is a trigger with regex: ^([\w\s]+): ([\w\s]+) is (buying|selling) (\d+) tons at (\d+)ig/ton$

local system = matches[2]
local planet = matches[3]
local action = matches[4]
local quantity = matches[5]
local price = matches[6]

-- Store the data
table.insert(FEDUI.cargo.data, {
  system = system,
  planet = planet,
  action = action,
  quantity = tonumber(quantity),
  price = tonumber(price)
})

FEDUI.cargo.lastLineWasPrice = true  -- Flag for blank line trigger
deleteLine()
