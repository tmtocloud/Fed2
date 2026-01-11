--===[ generate the adjustable containers everything goes into ]===--
function FEDUI.buildFramework()

  local FrameCSS = [[
    background-color: black;
    border-style: solid;
    border-width: 1px;
    border-radius: 5;
    border-color: white;
    margin: 1px;
  ]]

-----[ build the actual boxes, style and attach them ]-----
--left box for overflow
  FEDUI.leftFrame = Adjustable.Container:new({ 
    name = "FEDUI.leftFrame",
    titleText = "FEDUI.leftFrame",
    x = "0%", y = "0%",
    width = "15%", height = "100%",
    adjLabelstyle = FEDUI.FrameCSS, 
    attached = "left" 
  })

--right box for map, comms, and cargo
--sadly we can't have an 'upper' and 'lower' box at this point
--because adjustable containers only attach to borders and not to each other
--and it's too much work to integrate code that'll change that
  FEDUI.rightFrame = Adjustable.Container:new({ 
    name = "FEDUI.rightFrame",
    titleText = "FEDUI.rightFrame",
    x = "-20%", y = "0%",
    width = "20%", height = "100%",
    adjLabelstyle = FEDUI.FrameCSS, 
    attached = "right" 
  })

--top box for stats
  FEDUI.topFrame = Adjustable.Container:new({
    name = "FEDUI.topFrame",
    titleText = "FEDUI.topFrame",
    x = "15%", y = "0%",
    width = "65%", height = "5%",
    adjLabelstyle = FEDUI.FrameCSS, 
    attached = "top" 
  })

-----[ add connect menu to the frames, so users can connect/disconnect them ]-----
  Adjustable.Container:doAll(function(self) self:addConnectMenu() end)
  
-----[ connect the containers ourselves ]-----
  FEDUI.leftFrame:connectToBorder("left")
  FEDUI.rightFrame:connectToBorder("right")
  FEDUI.topFrame:connectToBorder("left")
  FEDUI.topFrame:connectToBorder("right")

-----[ lock the containers in place ]-----
  FEDUI.leftFrame:lockContainer("border")
  FEDUI.rightFrame:lockContainer("border")
  FEDUI.topFrame:lockContainer("border")

end

--===[ populate the top framework with labels ]===--
function FEDUI.buildHeader()

--build the hbox the stat labels will go into
  FEDUI.header = Geyser.HBox:new({
    name = "FEDUI.header",
    x = 0, y = 0,
    width = "100%",
    height = "100%",
  }, FEDUI.topFrame)

--create the labels inside the box
--six labels: rank, hold space, fuel, stamina, groats, slithies
  for i = 1, 6 do
    FEDUI["Label"..i] = Geyser.Label:new({
      name = "FEDGUI.label"..i,
      --message = "test text",
    }, FEDUI.header)
  end

--style the labels: background color and a little border between each label
  local LabelCSS = [[
    background-color: rgba(77,77,77,100); /*because DimGrey is not dark enough*/
    border-right-style: solid;
    border-left-style: solid;
    border-width: 1px;
    border-radius: 1;
    border-color: white;
  ]]
    
  FEDUI.Label1:setStyleSheet(LabelCSS)
  FEDUI.Label1:setFontSize(12)
  
  FEDUI.Label2:setStyleSheet(LabelCSS)
  FEDUI.Label2:setFontSize(12)
  
  FEDUI.Label3:setStyleSheet(LabelCSS)
  FEDUI.Label3:setFontSize(12)
  
  FEDUI.Label4:setStyleSheet(LabelCSS)
  FEDUI.Label4:setFontSize(12)
  
  FEDUI.Label5:setStyleSheet(LabelCSS)
  FEDUI.Label5:setFontSize(12)
  
  FEDUI.Label6:setStyleSheet(LabelCSS)
  FEDUI.Label6:setFontSize(12)

end

--===[ populate the framework with tabs - requires AdjustableTabWindow ]===--
function FEDUI.buildTabs()

-----[ styling for tabs ]-----
--wanted: some method to set text size on tabs

  local activeTabText = "white" --active tab text color
  local activeTabColor = "black" --active tab window color
  
  local inactiveTabText = "lightgrey" --inactive tab text color
  local inactiveTabColor = "dimgrey" --inactive tab window color

--active tab 
  activeTabCSS = activeTabCSS or [[
    background-color: ]]..activeTabColor..[[;
    color: ]]..activeTabText..[[;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    border-width: 1px;
    border-style: solid;
    border-color: ]]..activeTabText..[[;
    margin-right: 1px;
    margin-left: 1px;
    qproperty-alignment: 'AlignVCenter';
    ]]
    
--inactive tab - will highlight with the active tab colors on mouseover
    inactiveTabCSS = inactiveTabCSS or [[QLabel::hover{
        background-color: ]]..activeTabColor..[[;
        color: ]]..activeTabText..[[;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        border-width: 1px;
        border-style: solid;
        border-color: ]]..activeTabText..[[;
        margin-right: 1px;
        margin-left: 1px;
        qproperty-alignment: 'AlignVCenter';
    }
    QLabel::!hover{
        background-color: ]]..inactiveTabColor..[[;
        color: ]]..inactiveTabText..[[;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        margin-right: 1px;
        margin-left: 1px;
        qproperty-alignment: 'AlignVCenter';
    }
    ]]

--the outer border of the window, which should never be seen since it's being covered by a container
  local footerCSS = [[
    background-color: ]] .. activeTabColor..[[;
    border-bottom-left-radius: 1px;
    border-bottom-right-radius: 1px;
    border-width: 1px;
    border-style: solid;
    border-color: ]]..activeTabText..[[;
    ]]
  
--the core of the window, which should never be seen because we're using it as a container
  local centerCSS = [[
    background-color: ]]..inactiveTabColor..[[;
    border-radius: 5px;
    margin: 5px;
  ]]

-----[ place Overflow/Commodities tab windows ]-----
  FEDUI.tabLeft = Adjustable.TabWindow:new({
    name = "FEDUI.tabLeft",
    x = "0%", y = "0%",
    width = "100%",
    height = "100%",
    tabBarHeight = "5%",
    tabs = {"Overflow", "Commodities"},
    activeTabStyle = activeTabCSS,
    inactiveTabStyle = inactiveTabCSS,
    footerStyle = footerCSS,
    centerStyle = centerCSS,
  }, FEDUI.leftFrame)
    
  
-----[ build and place Map and Comm/Cargo tab windows ]-----
--the box these two tab windows will go into
  FEDUI.vboxRight = Geyser.VBox:new({
    name = "FEDUI.vboxRight",
    x = 0,
    y = 0,
    width = "100%",
    height = "100%",
  }, FEDUI.rightFrame)
  
--map tab
  FEDUI.tabTopRight = Adjustable.TabWindow:new({
    name = "FEDUI.tabTopRight",
    x = "0%", y = "0%",
    width = "100%",
    height = "100%",
    tabBarHeight = "10%",
    tabs = {"fedmap"},
    activeTabStyle = activeTabCSS,
    inactiveTabStyle = inactiveTabCSS,
    footerStyle = footerCSS,
    centerStyle = centerCSS,
  }, FEDUI.vboxRight)
  
--comm and cargo tabs
    FEDUI.tabBottomRight = Adjustable.TabWindow:new({
    name = "FEDUI.tabBottomRight",
    x = "0%", y = "0%",
    width = "100%",
    height = "100%",
    tabBarHeight = "10%",
    tabs = {"Comm", "Cargo"},
    activeTabStyle = activeTabCSS,
    inactiveTabStyle = inactiveTabCSS,
    footerStyle = footerCSS,
    centerStyle = centerCSS,
  }, FEDUI.vboxRight)
end

--===[ populate our various tabs ]===--
function FEDUI.popUI()

  local textSize = 12

  --put map into map window
  FEDUI.mapper = Geyser.Mapper:new({
    name = "fedmap",
    x = 0, y = 0, 
    width = "100%", height = "100%",
}, FEDUI.tabTopRight.fedmapcenter )

  --put overflow console in overflow tab
  FEDUI.overflowWindow = Geyser.MiniConsole:new({
    name = "FEDUI.overflowWindow",
    x = "0%", y = "0%",
    width = "100%",
    height = "100%",
    autoWrap = true,
    scrollBar = false,
    fontSize = textSize,
    color = "black",
  }, FEDUI.tabLeft.Overflowcenter)
  --FEDUI.overflowWindow:echo("+++\n")
  
  --put commodities console in commodities tab
  FEDUI.commoditiesWindow = Geyser.MiniConsole:new({
    name = "FEDUI.commoditiesWindow",
    x = "0%", y = "0%",
    width = "100%",
    height = "100%",
    autoWrap = true,
    scrollBar = true,
    fontSize = textSize,
    color = "black",
  }, FEDUI.tabLeft.Commoditiescenter)
  --FEDUI.commoditiesWindow:echo("+++\n")
  
  --put chat console in chat tab
  FEDUI.chatWindow = Geyser.MiniConsole:new({
    name = "FEDUI.chatWindow",
    x = "0%", y = "0%",
    width = "100%",
    height = "100%",
    autoWrap = true,
    scrollBar = false,
    fontSize = textSize,
    color = "black",
  }, FEDUI.tabBottomRight.Commcenter)
  --FEDUI.chatWindow:echo("chat initalized\n")
    
  --put cargo console in cargo tab
  FEDUI.cargoWindow = Geyser.MiniConsole:new({
    name = "FEDUI.cargoWindow",
    x = "0%", y = "0%",
    width = "100%",
    height = "100%",
    autoWrap = true,
    scrollBar = false,
    fontSize = textSize,
    color = "black",
  }, FEDUI.tabBottomRight.Cargocenter)
  --FEDUI.cargoWindow:echo("cargo initalized\n")
  
end

--===[ build the UI at connection ]===--
function FEDUI.buildUI()
  FEDUI.buildFramework()
  FEDUI.buildHeader()
  FEDUI.buildTabs()
  FEDUI.popUI()
  -- *************the two lines below are the only tmtocloud edits to this file***********
  FEDUI.buildMovementButtons()
  FEDUI.registerGMCPHandlers()
  FEDUI.outputCommodities()
end

--should run on install, check that this package is what has been installed,
--remove the generic mapper, then build the UI
function FEDUI.onInstall(event, package, path)
  if package == "fed2ui" then
    if table.contains(getPackages(),"generic_mapper") then
      uninstallPackage("generic_mapper")
    end
    FEDUI.buildUI()
  end
end

registerAnonymousEventHandler("sysConnectionEvent", "FEDUI.buildUI()")
registerAnonymousEventHandler("sysInstallPackage", FEDUI.onInstall)
