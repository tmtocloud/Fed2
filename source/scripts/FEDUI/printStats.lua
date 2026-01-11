--takes important character and ship stats, prints them to the labels at the top of the screen

if magicCashNumbers == nil then
  magicCashNumbers = {
    ["Commander"] = 250000,
    ["Captain"] = 400000,
    ["Adventurer"] = 600000,
    ["Adventuress"] = 600000,
    ["Merchant"] = 7500000,
    ["Trader"] = 12500000,
    ["Industrialist"] = 17500000,
    ["Manufacturer"] = 22500000,
    ["Financier"] = 27500000,
  }--magic numbers taken from the documentation (https://federation2.com/guide/#sec-220.10)
  --magic numbers confirmed by in-game 'help tax' document
  --everyone over Financier has no cap (but may have a cap of 1,000,000,000?)
  --planets and companies do have a cap of 1,000,000,000 but we don't track this so it's fine
  --businesses have a cap of 100,000,000 but we also don't track this so it's still fine
end

--called by 'cash = convert_value(vitals.cash)'
--called by 'groatsMax = convert_value(magicCashNumbers[rank])'
local function convert_value(amount) --format very long numbers
  local formatted = amount
  if tonumber(formatted) == nil then return nil end
  if tonumber(formatted) <= 1000000 then --we are below or just equal to a meg
    while true do
      formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
      if (k==0) then
        break
      end
    end
  else --we are above a meg
    --divide by 100,000 so the decimal is shifted
    --floor the result to throw away everything after the decimal
    --divide by 10 to put the decimal in the right spot
    formatted = math.floor(tonumber(formatted)/100000) / 10 .. " m"
  end
  return formatted
end

local function colorPercent(numCur, numMax) --colorize based on a percentage
  --0 is ansiRed, 5 is ansiYellow, 9 is ansiGreen, 10 is default white
  --unfortunately mudlet's color table doesn't have a good gradiant 
  --so hexcodes from a random online gradiant tool it is
  local colorGrad = {[0] = "#800000", [1] = "#801a00", [2] = "#803400", [3] = "#804e00", [4] = "#806800", 
    [5] = "#808000", [6] = "#668000", [7] = "#4c8000", [8] = "#328000", [9] = "#008000", [10] = "#FFFFFF"
  }
  --divide the current value by the max value to get a percentage
  --then multiply it by ten to shift the decimal
  --then floor it to chop off everything after the decimal
  --should result in a number between 0 and 10
  percent = math.floor((tonumber(numCur) / tonumber(numMax)) * 10)
  color = colorGrad[percent]
  return color
end

--Tracking: Rank, Cargo Space, Fuel, Stamina, Money, Slithies

function printStats()
  local vitals = (gmcp.char and gmcp.char.vitals) or {}
  local ship = (gmcp.char and gmcp.char.ship) or {}

  local rank    = vitals.rank or "-"
  local holdCur = (ship.hold and ship.hold.cur) or "-"
  local holdMax = (ship.hold and ship.hold.max) or "-"
  local fuelCur = (ship.fuel and ship.fuel.cur) or "-"
  local fuelMax = (ship.fuel and ship.fuel.max) or "-"
  local stamCur = (vitals.stamina and vitals.stamina.cur) or "-"
  local stamMax = (vitals.stamina and vitals.stamina.max) or "-"
  local cash    = convert_value(vitals.cash) or "-"
  local slith   = vitals.slithies or "-"
  local groatsMax = convert_value(magicCashNumbers[rank]) or "-"

  FEDUI.Label1:echo("Rank: ".. [[<b>]] .. rank .. [[</b>]])
  if tonumber(holdCur) then FEDUI.Label2:echo("Hold: " .. [[<b><font color=]]..colorPercent(holdCur,holdMax)..[[>]] .. holdCur .. [[</font></b>]] .. "/" .. holdMax) end
  if tonumber(fuelCur) then FEDUI.Label3:echo("Fuel: " .. [[<b><font color=]]..colorPercent(fuelCur,fuelMax)..[[>]] .. fuelCur .. [[</font></b>]] .. "/" .. fuelMax) end
  if tonumber(stamCur) then FEDUI.Label4:echo("Stamina: " .. [[<b><font color=]]..colorPercent(stamCur,stamMax)..[[>]] .. stamCur .. [[</font></b>]].. "/" .. stamMax) end
  if groatsMax == "-" then
    FEDUI.Label5:echo("Groats: " .. [[<b>]] .. cash .. [[</b>]])
  else
    FEDUI.Label5:echo("Groats: " .. [[<b>]] .. cash .. [[</b>]] .. "/" .. groatsMax)
  end
  FEDUI.Label6:echo("Slithies: " .. [[<b>]] .. slith .. [[</b>]])
end
