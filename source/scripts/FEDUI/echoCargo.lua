--echoes cargo information to the cargo console
function echoCargo()
  local cargo = gmcp.char.ship.cargo --this is a table, and possibly a table of tables
  if cargo then
    clearWindow("FEDUI.cargoWindow") --reset the window, no need to have old cargo sticking around
    FEDUI.cargoWindow:cecho("<b>Current Cargo:</b>\n")
    for key, value in pairs(cargo) do
      FEDUI.cargoWindow:cecho("<b>"..value.commodity) --name of the commodity
      FEDUI.cargoWindow:cecho("</b> at ")
      FEDUI.cargoWindow:echo(value.cost) --how much you paid for it
      FEDUI.cargoWindow:echo("/")
      FEDUI.cargoWindow:echo(value.base) --default price of commodity
      if value.base-value.cost >=0 then
        FEDUI.cargoWindow:cecho(" (<green>+"..value.base-value.cost)
      else
        FEDUI.cargoWindow:cecho(" (<red>-"..value.base-value.cost)
      end
      FEDUI.cargoWindow:cecho("<reset>) from ")
      FEDUI.cargoWindow:cecho("<b>"..value.origin) --what planet you bought it from
      FEDUI.cargoWindow:cecho("</b>\n")
    end
    FEDUI.cargoWindow:echo("\n")
  end
end

--cargo table contents:
  --base = [number] --this the commodity's default price
  --commodity = [string] --this is the name of the commodity
  --cost = [number] --this is how much you paid for the commodity
  --origin = [string] --this is where the commodity came from
