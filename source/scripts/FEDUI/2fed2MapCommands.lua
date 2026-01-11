FEDUI.movement         = FEDUI.movement or {}
FEDUI.movement.visible = true

-- Build Movement Buttons
function FEDUI.buildMovementButtons()
  
  -- Modern button styling
  local buttonCSS = [[
    QLabel{
      background-color: rgba(40, 40, 45, 200);
      border-style: solid;
      border-width: 1px;
      border-radius: 3px;
      border-color: rgba(100, 100, 110, 180);
      color: rgba(200, 200, 210, 255);
      font-size: 11px;
      font-weight: bold;
    }
    QLabel::hover{
      background-color: rgba(60, 60, 70, 220);
      border-color: rgba(120, 180, 255, 200);
      color: white;
    }
  ]]
  
  local disabledButtonCSS = [[
    QLabel{
      background-color: rgba(25, 25, 28, 150);
      border-style: solid;
      border-width: 1px;
      border-radius: 3px;
      border-color: rgba(60, 60, 65, 120);
      color: rgba(80, 80, 85, 180);
      font-size: 11px;
      font-weight: bold;
    }
  ]]
  
  local toggleButtonCSS = [[
    QLabel{
      background-color: rgba(50, 50, 55, 220);
      border-style: solid;
      border-width: 1px;
      border-radius: 3px;
      border-color: rgba(120, 120, 130, 200);
      color: rgba(220, 220, 230, 255);
      font-size: 10px;
      font-weight: bold;
    }
    QLabel::hover{
      background-color: rgba(70, 130, 180, 240);
      border-color: rgba(150, 200, 255, 230);
      color: white;
    }
  ]]
  
  ------------- Main Container -------------------------------
  FEDUI.mapCommandsContainer = Geyser.Container:new(
    {
      name   = "FEDUI.mapCommandsContainer",
      x      = "1%",
      y      = "-170px",
      width  = "25%",
      height = 180
    },
    FEDUI.tabTopRight.fedmapcenter
  )
  
  ------------- IN/OUT Container -----------------------------
  FEDUI.inOutBox = Geyser.Container:new(
    {
      name   = "FEDUI.inOutBox",
      x      = "50%-40px",
      y      = 5,
      width  = 80,
      height = 22
    },
    FEDUI.mapCommandsContainer
  )
  
  ------------- IN Button ------------------------------------
  FEDUI.btnIn = Geyser.Label:new(
    {
      name    = "FEDUI.btnIn",
      x       = 0,
      y       = 0,
      width   = 37,
      height  = 22,
      message = "<center>IN</center>"
    },
    FEDUI.inOutBox
  )

  FEDUI.btnIn:setStyleSheet(buttonCSS)
  FEDUI.btnIn:setClickCallback("FEDUI.moveIn")
  
  ------------- OUT Button -----------------------------------
  FEDUI.btnOut = Geyser.Label:new(
    {
      name    = "FEDUI.btnOut",
      x       = 42,
      y       = 0,
      width   = 37,
      height  = 22,
      message = "<center>OUT</center>"
    },
    FEDUI.inOutBox
  )

  FEDUI.btnOut:setStyleSheet(buttonCSS)
  FEDUI.btnOut:setClickCallback("FEDUI.moveOut")
  
  ------------- Compass Container ----------------------------
  FEDUI.cardinalBox = Geyser.Container:new(
    {
      name   = "FEDUI.cardinalBox",
      x      = "50%-60px",
      y      = 32,
      width  = 120,
      height = 120
    },
    FEDUI.mapCommandsContainer
  )
  
  -- Button standards for compass
  local btnSize = 35
  local btnGap  = 5
  
  ------------- NW Button ------------------------------------
  FEDUI.btnNW = Geyser.Label:new(
    {
      name    = "FEDUI.btnNW",
      x       = 0,
      y       = 0,
      width   = btnSize,
      height  = btnSize,
      message = "<center>NW</center>"
    },
    FEDUI.cardinalBox
  )
  
  FEDUI.btnNW:setStyleSheet(buttonCSS)
  FEDUI.btnNW:setClickCallback("FEDUI.moveNW")
  
  ------------- N Button -------------------------------------
  FEDUI.btnN = Geyser.Label:new(
    {
      name    = "FEDUI.btnN",
      x       = btnSize + btnGap,
      y       = 0,
      width   = btnSize,
      height  = btnSize,
      message = "<center>N</center>"
    },
    FEDUI.cardinalBox
  )
  
  FEDUI.btnN:setStyleSheet(buttonCSS)
  FEDUI.btnN:setClickCallback("FEDUI.moveN")
  
  ------------- NE Button ------------------------------------
  FEDUI.btnNE = Geyser.Label:new(
    {
      name    = "FEDUI.btnNE",
      x       = (btnSize + btnGap) * 2,
      y       = 0,
      width   = btnSize,
      height  = btnSize,
      message = "<center>NE</center>"
    },
    FEDUI.cardinalBox
  )
  
  FEDUI.btnNE:setStyleSheet(buttonCSS)
  FEDUI.btnNE:setClickCallback("FEDUI.moveNE")
  
  ------------- W Button -------------------------------------
  FEDUI.btnW = Geyser.Label:new(
    {
      name    = "FEDUI.btnW",
      x       = 0,
      y       = btnSize + btnGap,
      width   = btnSize,
      height  = btnSize,
      message = "<center>W</center>"
    },
    FEDUI.cardinalBox
  )
  
  FEDUI.btnW:setStyleSheet(buttonCSS)
  FEDUI.btnW:setClickCallback("FEDUI.moveW")
  
  ------------- LOOK Button ----------------------------------
  FEDUI.btnLook = Geyser.Label:new(
    {
      name    = "FEDUI.btnLook",
      x       = btnSize + btnGap,
      y       = btnSize + btnGap,
      width   = btnSize,
      height  = btnSize,
      message = "<center>👁</center>"
    },
    FEDUI.cardinalBox
  )
  
  FEDUI.btnLook:setStyleSheet(buttonCSS)
  FEDUI.btnLook:setClickCallback("FEDUI.look")
  
  ------------- E Button -------------------------------------
  FEDUI.btnE = Geyser.Label:new(
    {
      name    = "FEDUI.btnE",
      x       = (btnSize + btnGap) * 2,
      y       = btnSize + btnGap,
      width   = btnSize,
      height  = btnSize,
      message = "<center>E</center>"
    },
    FEDUI.cardinalBox
  )
  
  FEDUI.btnE:setStyleSheet(buttonCSS)
  FEDUI.btnE:setClickCallback("FEDUI.moveE")
  
  ------------- SW Button ------------------------------------
  FEDUI.btnSW = Geyser.Label:new(
    {
      name    = "FEDUI.btnSW",
      x       = 0,
      y       = (btnSize + btnGap) * 2,
      width   = btnSize,
      height  = btnSize,
      message = "<center>SW</center>"
    },
    FEDUI.cardinalBox
  )
  
  FEDUI.btnSW:setStyleSheet(buttonCSS)
  FEDUI.btnSW:setClickCallback("FEDUI.moveSW")
  
  ------------- S Button -------------------------------------
  FEDUI.btnS = Geyser.Label:new(
    {
      name    = "FEDUI.btnS",
      x       = btnSize + btnGap,
      y       = (btnSize + btnGap) * 2,
      width   = btnSize,
      height  = btnSize,
      message = "<center>S</center>"
    },
    FEDUI.cardinalBox
  )
  
  FEDUI.btnS:setStyleSheet(buttonCSS)
  FEDUI.btnS:setClickCallback("FEDUI.moveS")
  
  ------------- SE Button ------------------------------------
  FEDUI.btnSE = Geyser.Label:new(
    {
      name    = "FEDUI.btnSE",
      x       = (btnSize + btnGap) * 2,
      y       = (btnSize + btnGap) * 2,
      width   = btnSize,
      height  = btnSize,
      message = "<center>SE</center>"
    },
    FEDUI.cardinalBox
  )
  
  FEDUI.btnSE:setStyleSheet(buttonCSS)
  FEDUI.btnSE:setClickCallback("FEDUI.moveSE")
  
  ------------- UP/DOWN Container ----------------------------
  FEDUI.verticalBox = Geyser.Container:new(
    {
      name   = "FEDUI.verticalBox",
      x      = "50%+60px",
      y      = 61,
      width  = 70,
      height = 120,
    },
    FEDUI.mapCommandsContainer
  )
  
  ------------- UP Button ------------------------------------
  FEDUI.btnUp = Geyser.Label:new(
    {
      name    = "FEDUI.btnUp",
      x       = 0,
      y       = 0,
      width   = 25,
      height  = 28,
      message = "<center>UP</center>"
    },
    FEDUI.verticalBox
  )
  
  FEDUI.btnUp:setStyleSheet(buttonCSS)
  FEDUI.btnUp:setClickCallback("FEDUI.moveUp")
  
  ------------- DOWN Button ----------------------------------
  FEDUI.btnDown = Geyser.Label:new(
    {
      name    = "FEDUI.btnDown",
      x       = 0,
      y       = 30,
      width   = 25,
      height  = 28,
      message = "<center>DN</center>"
    },
    FEDUI.verticalBox
  )
  
  FEDUI.btnDown:setStyleSheet(buttonCSS)
  FEDUI.btnDown:setClickCallback("FEDUI.moveDown")
  
  ------------- Show/Hide Button -----------------------------
  FEDUI.btnShowHide = Geyser.Label:new(
    {
      name    = "FEDUI.btnShowHide",
      x       = "100%",
      y       = 127,
      width   = 80,
      height  = 18,
      message = "<center>Hide Buttons</center>"
    },
    FEDUI.mapCommandsContainer
  )
  
  FEDUI.btnShowHide:setStyleSheet(toggleButtonCSS)
  FEDUI.btnShowHide:setClickCallback("FEDUI.toggleMovementButtons")
  
  ------------- Buy Fuel Button ------------------------------
  FEDUI.btnFuel = Geyser.Label:new(
    {
      name    = "FEDUI.btnFuel",
      x       = "100%+85px",
      y       = 127,
      width   = 55,
      height  = 18,
      message = "<center>Buy Fuel</center>"
    },
    FEDUI.mapCommandsContainer
  )
  
  FEDUI.btnFuel:setStyleSheet(buttonCSS)
  FEDUI.btnFuel:setClickCallback("FEDUI.buyFuel")
  
  ------------- Work Button --------------------------------
  FEDUI.btnWork = Geyser.Label:new(
    {
      name    = "FEDUI.btnWork",
      x       = "100%+160px",
      y       = 127,
      width   = 25,
      height  = 20,
      message = "<center>W</center>"
    },
    FEDUI.mapCommandsContainer
  )
  
  FEDUI.btnWork:setStyleSheet(buttonCSS)
  FEDUI.btnWork:setClickCallback("FEDUI.work")
  
  ------------- Collect Button -------------------------------
  FEDUI.btnCollect = Geyser.Label:new(
    {
      name    = "FEDUI.btnCollect",
      x       = "100%+187px",
      y       = 127,
      width   = 25,
      height  = 20,
      message = "<center>C</center>"
    },
    FEDUI.mapCommandsContainer
  )
  
  FEDUI.btnCollect:setStyleSheet(buttonCSS)
  FEDUI.btnCollect:setClickCallback("FEDUI.collect")

  ------------- Deliver Button -------------------------------
  FEDUI.btnDeliver = Geyser.Label:new(
    {
      name    = "FEDUI.btnDeliver",
      x       = "100%+214px",
      y       = 127,
      width   = 25,
      height  = 20,
      message = "<center>D</center>"
    },
    FEDUI.mapCommandsContainer
  )
  
  FEDUI.btnDeliver:setStyleSheet(buttonCSS)
  FEDUI.btnDeliver:setClickCallback("FEDUI.deliver")

  ------------- Score Button -------------------------------
  FEDUI.btnScore = Geyser.Label:new(
    {
      name    = "FEDUI.btnScore",
      x       = "100%+173px",
      y       = 100,
      width   = 25,
      height  = 20,
      message = "<center>SC</center>"
    },
    FEDUI.mapCommandsContainer
  )
  
  FEDUI.btnScore:setStyleSheet(buttonCSS)
  FEDUI.btnScore:setClickCallback("FEDUI.score")

  ------------- Status Button -------------------------------
  FEDUI.btnStatus = Geyser.Label:new(
    {
      name    = "FEDUI.btnStatus",
      x       = "100%+200px",
      y       = 100,
      width   = 25,
      height  = 20,
      message = "<center>ST</center>"
    },
    FEDUI.mapCommandsContainer
  )
  
  FEDUI.btnStatus:setStyleSheet(buttonCSS)
  FEDUI.btnStatus:setClickCallback("FEDUI.status")

  -------------- Board Button --------------------------------
  FEDUI.btnBoard = Geyser.Label:new(
    {
      name    = "FEDUI.btnBoard",
      x       = "0%-7px",
      y       = 5,
      width   = 25,
      height  = 20,
      message = "<center>B</center>"
    },
    FEDUI.mapCommandsContainer
  )
  
  FEDUI.btnBoard:setStyleSheet(buttonCSS)
  FEDUI.btnBoard:setClickCallback("FEDUI.board")
  
  -- Store button and action references for easy access
  FEDUI.movement.directions = {
    n      = { button = FEDUI.btnN,     action = "FEDUI.moveN"    },
    ne     = { button = FEDUI.btnNE,    action = "FEDUI.moveNE"   },
    e      = { button = FEDUI.btnE,     action = "FEDUI.moveE"    },
    se     = { button = FEDUI.btnSE,    action = "FEDUI.moveSE"   },
    s      = { button = FEDUI.btnS,     action = "FEDUI.moveS"    },
    sw     = { button = FEDUI.btnSW,    action = "FEDUI.moveSW"   },
    w      = { button = FEDUI.btnW,     action = "FEDUI.moveW"    },
    nw     = { button = FEDUI.btnNW,    action = "FEDUI.moveNW"   },
    up     = { button = FEDUI.btnUp,    action = "FEDUI.moveUp"   },
    down   = { button = FEDUI.btnDown,  action = "FEDUI.moveDown" },
    ["in"] = { button = FEDUI.btnIn,    action = "FEDUI.moveIn"   },
    out    = { button = FEDUI.btnOut,   action = "FEDUI.moveOut"  },
    board  = { button = FEDUI.btnBoard, action = "FEDUI.board"    },
  }
  
  FEDUI.movement.buttonCSS   = buttonCSS
  FEDUI.movement.disabledCSS = disabledButtonCSS
  
end

-- Toggle Movement Buttons Visibility
function FEDUI.toggleMovementButtons()
  if FEDUI.movement.visible then
    FEDUI.cardinalBox:hide()
    FEDUI.verticalBox:hide()
    FEDUI.inOutBox:hide()
    FEDUI.btnShowHide:echo("<center>Show Buttons</center>")
    FEDUI.btnBoard:hide()
    FEDUI.btnFuel:hide()
    FEDUI.btnWork:hide()
    FEDUI.btnCollect:hide()
    FEDUI.btnDeliver:hide()
    FEDUI.btnScore:hide()
    FEDUI.btnStatus:hide()
    FEDUI.movement.visible = false
  else
    FEDUI.cardinalBox:show()
    FEDUI.verticalBox:show()
    FEDUI.inOutBox:show()
    FEDUI.btnShowHide:echo("<center>Hide Buttons</center>")
    FEDUI.btnBoard:show()
    FEDUI.btnFuel:show()
    FEDUI.btnWork:show()
    FEDUI.btnCollect:show()
    FEDUI.btnDeliver:show()
    FEDUI.btnScore:show()
    FEDUI.btnStatus:show()
    FEDUI.movement.visible = true
  end
end

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Register GMCP handler
function FEDUI.registerGMCPHandlers()
  if FEDUI.gmcpRoomHandler then killAnonymousEventHandler(FEDUI.gmcpRoomHandler) end
  
  FEDUI.gmcpRoomHandler = registerAnonymousEventHandler("gmcp.room.info", "FEDUI.onGMCPRoomInfo")
end

-- Run on every update to GMCP room info
function FEDUI.onGMCPRoomInfo()
  local exits = {}

  -- get all the gmcp room exits and add them to valid exits
  for exit, _ in pairs(gmcp.room.info.exits) do
    table.insert(exits, exit:lower())
  end

  -- Detect shuttlepad or orbit and add board to valid exits
  if table.contains(gmcp.room.info.flags, "shuttlepad") or table.contains(gmcp.room.info.flags, "orbit") or gmcp.room.info.orbit then table.insert(exits, "board") end

  for dir, dirData in pairs(FEDUI.movement.directions) do
    if table.contains(exits, dir) then
      dirData.button:setStyleSheet(FEDUI.movement.buttonCSS)
      dirData.button:setClickCallback(dirData.action)
    else
      dirData.button:setStyleSheet(FEDUI.movement.disabledCSS)
      dirData.button:setClickCallback(function() end)
    end
  end
  
  -- grey out buy fuel if in space
  if table.contains(gmcp.room.info.flags, "space") then
    FEDUI.btnFuel:setStyleSheet(FEDUI.movement.disabledCSS)
    FEDUI.btnFuel:setClickCallback(function() end)
  else
    FEDUI.btnFuel:setStyleSheet(FEDUI.movement.buttonCSS)
    FEDUI.btnFuel:setClickCallback("FEDUI.buyFuel")
  end
end

------------- Commands ---------------------------------------
function FEDUI.moveN()
  send("n")
end

function FEDUI.moveNE()
  send("ne")
end

function FEDUI.moveE()
  send("e")
end

function FEDUI.moveSE()
  send("se")
end

function FEDUI.moveS()
  send("s")
end

function FEDUI.moveSW()
  send("sw")
end

function FEDUI.moveW()
  send("w")
end

function FEDUI.moveNW()
  send("nw")
end

function FEDUI.moveUp()
  send("up")
end

function FEDUI.moveDown()
  send("down")
end

function FEDUI.moveIn()
  send("in")
end

function FEDUI.moveOut()
  send("out")
end

function FEDUI.look()
  send("look")
end

function FEDUI.board()
  send("board")
end

function FEDUI.buyFuel()
  send("buy fuel")
end

function FEDUI.work()
  send("work")
end

function FEDUI.collect()
  send("collect")
end

function FEDUI.deliver()
  send("deliver")
end

function FEDUI.score()
  send("score")
end

function FEDUI.status()
  send("status")
end
