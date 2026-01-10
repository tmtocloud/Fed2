-- This is a trigger, with regex: (\d+)\.\s+(?:From|From The)\s+(.+?)\s+(?:to|to The)\s+(.+?)\s+-\s+.+?\s+-\s+(\d+)gtu\s+(\d+)ig

local function rpad(str, len)
  str = tostring(str)
  local pad = len - #str
  if pad > 0 then
    return str .. string.rep(" ", pad)
  end
  return str:sub(1, len)
end

--this assumes jobs are provided in lots of 75 tons
--does not capture or display hauling credits per job
-- Job IDs can be clicked on to send the ac JobNum command to FED
-- Planets can be clicked on to send whereis planetName to FED

local jobNum   = matches[2]       --what is the job number
local startLoc = matches[3]     --what planet is the collection point
local destLoc  = matches[4]      --what planet is the delivery point
FEDUI.jobTime  = matches[5]      --how long do you have to deliver it
FEDUI.jobPay   = matches[6] * 75  --how much per ton you're paid * 75 tons of cargo

FEDUI.combineLoc = {startLoc, destLoc}  --put the two planets in one location
table.sort(FEDUI.combineLoc)                        --alphabetize them
FEDUI.combineLoc = table.concat(FEDUI.combineLoc)   --smush the alphabetized planets together

-- If out of Sol, dont try to calculate gtu
if gmcp.room.info.system == "Sol" then
  FEDUI.calcTime = FEDUI.SolDistances[FEDUI.combineLoc] --use that to get the actual time between startLoc and destLoc
  --SolDistances table is found in the MagicNumbers script file
  if tonumber(FEDUI.calcTime) > tonumber(FEDUI.jobTime) then      --you don't have enough time to deliver without penalties
  --we're just not gonna do anything here
  elseif tonumber(FEDUI.calcTime) < tonumber(FEDUI.jobTime) then  --you can deliver faster than allocated time and may receive bonuses
    FEDUI.cargoWindow:cechoLink("<blue><u>" .. jobNum .. "</u><reset>",function() send("ac " .. jobNum) end, "Accept job " .. jobNum, true)
    FEDUI.cargoWindow:cecho(" <ansiCyan>"..rpad(startLoc,8).."<reset> > <ansiCyan>"..rpad(destLoc,8)..
    "<reset> <b>"..FEDUI.jobTime.."/<ansiGreen>"..FEDUI.calcTime.."<reset>gtu - <b>"
    ..FEDUI.jobPay.."</b>ig (<b><ansiGreen>".. math.floor(FEDUI.jobPay+(FEDUI.jobPay*.2)) .."<reset></b>ig)\n")
  else --
    FEDUI.cargoWindow:cecho(jobNum.." <ansiCyan>"..rpad(startLoc,8).."<reset> > <ansiCyan>"..rpad(destLoc,8)..
    "<reset> <b>"..FEDUI.jobTime.."/"..FEDUI.calcTime.."</b>gtu - <b>"..FEDUI.jobPay.."</b>ig\n")
  end
else
  FEDUI.cargoWindow:cechoLink("<blue><u>" .. jobNum .. "</u><reset>",function() send("ac " .. jobNum) end, "Accept job " .. jobNum, true)
  FEDUI.cargoWindow:cechoLink(" <ansiCyan>" .. rpad(startLoc,13).."<reset>",function() send("whereis " .. startLoc) end, "Find " .. startLoc, true)
  FEDUI.cargoWindow:cecho(" > ")
  FEDUI.cargoWindow:cechoLink("<ansiCyan>" .. rpad(destLoc,13) .. "<reset>",function() send("whereis " .. destLoc) end, "Find " .. destLoc, true)
  FEDUI.cargoWindow:cecho(" <b>" .. FEDUI.jobTime .. "</b>gtu - <b>" .. FEDUI.jobPay .. "</b>ig\n")
end
