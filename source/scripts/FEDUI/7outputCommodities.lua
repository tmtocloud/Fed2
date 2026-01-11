--puts the CommodyTable in the Commodities window, sorted by price
function FEDUI.outputCommodities()
  clearWindow("FEDUI.commoditiesWindow")

  local entities = {}
  for key, value in pairs(FEDUI.CommoditiesBasePrice) do
    table.insert(entities, {key = key, value = value})
  end
  table.sort(entities, function (a,b) return a.value < b.value end)
  
  for key, entity in ipairs(entities) do
    FEDUI.commoditiesWindow:echo(entity.key.." ("..entity.value..")\n")
  end
end
