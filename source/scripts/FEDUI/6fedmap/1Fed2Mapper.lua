-----[ tell mudlet that we're a legit mapper ]-----
mudlet = mudlet or {}
mudlet.mapper_script = true

--===begin useful mapping functions===--

-----[ custom env colors ]-----
setCustomEnvColor(33, 255, 192, 203, 255) --mudlet's 'pink', used for auto-generated unexplored rooms

--mapper default color reference--
--257 - dark red    --265 - red
--258 - dark green	--266 - green
--259 - dark yellow	--267 - yellow
--260 - dark blue	  --268 - blue
--261 - dark pink	  --269 - pink
--262 - dark cyan	  --270 - cyan
--263 - light grey	--271 - white
--264 - black		    --272 - dark grey


-----[ set room environment ]-----
--set the room color and symbol based on the room's flags
--colors are the mapper defaults, found from getCustomEnvColorTable()
--if the 'link', 'orbit', 'shuttlepad', or 'exchange' flags are found, room is maroon
--having just the 'space' flag or no flags at all results in the room being grey
--rooms with the 'shuttlepad' flag get a star symbol so they're easy to find
--rooms with the 'exchange' flag get 'EX' as a symbol so they're easy to find
--not setting symbols on 'link' or 'orbit' flags because there's too much variety here to hardcode something
	--end users should be setting their own symbols via alias anyway
function fedmap.roomColor(roomID)
  local table = gmcp.room.info.flags
  if next(table) == nil then --the room's table of flags is empty, this is an ordinary room on a planet
  	setRoomEnv(roomID, 272)
    setRoomChar(roomID, "")
  else
  	local flags = {}
  	for key,value in ipairs(table) do        --take the values from the room's table of flags
  		setRoomUserData(roomID, value, "true")	--put them into the room's user data
		end
		if getRoomUserData(roomID, "link") == "true" then --this room lets people jump to different systems
			--echo("link flag found")
			setRoomEnv(roomID, 260)
      setRoomChar(roomID, "")
		elseif getRoomUserData(roomID, "orbit") == "true" or gmcp.room.info.orbit then --this room lets people board their shuttle to land on the planet
			--echo("orbit flag found")
			setRoomEnv(roomID, 257)
      setRoomChar(roomID, "")
		elseif getRoomUserData(roomID, "space") == "true" then --this is an ordinary space room with no orbits or system links
			--echo("space flag found")
			setRoomEnv(roomID, 272)
      setRoomChar(roomID, "")
		elseif getRoomUserData(roomID, "shuttlepad") == "true" then --this room lets people board their shuttle to reach their spaceship
			--echo("shuttlepad flag found")
			setRoomEnv(roomID, 257)
			setRoomChar(roomID, "★")
		elseif getRoomUserData(roomID, "exchange") == "true" then --this room lets people use the exchange features
			--echo("exchange flag found")
			setRoomEnv(roomID, 257)
			setRoomChar(roomID, "EX")
		else 							--we have no idea what this room is, panic
			--echo("other flag found")
			setRoomEnv(roomID, 259)
      setRoomChar(roomID, "")
  	end
  end
end

-----[ create ghost room ]-----
--unexplored rooms are generated for each valid exit, so we have something to hook the exit to
--they're colored a pale pink and identified with a ? so we know they haven't been entered yet
local function makeGhostRoom(destinationHash, areaID, number) --called by generateExits
	local ID = createRoomID()          --get the next free room number
	setRoomIDbyHash(ID, destinationHash) --assign that room number to the destination room's hash 
	addRoom(ID, areaID)            --create the room using our generated room number
	local coordX, coordY = fedmap.makeCoords(number)
	setRoomCoordinates(ID, coordX, coordY, 0)
	setRoomEnv(ID, 33) --custom env, not one of the mapper defaults
	setRoomChar(ID, "?")
end

-----[ create exits ]-----
--convert each fed room number into a a room hash, check to see if there's a mapper room number associated
--if there is no room already existing with that hash, create one via makeGhostRoom
--once we are assured the room exists, hook an exit to it
function fedmap.generateExits(areaID, roomID) --called as part of fedmap.makeRoom
	local exits = gmcp.room.info.exits
	for dir, number in pairs(exits) do
		local destinationHash = gmcp.room.info.system .. "." .. gmcp.room.info.area .. "." .. number
		if getRoomIDbyHash(destinationHash) == -1 then --no room is associated with this hash
      makeGhostRoom(destinationHash, areaID, number) --let's fix that
    end
		setExit(roomID, getRoomIDbyHash(destinationHash), dir)
	end
end

--===begin core mapping functions===--

-----[ get area ID ]-----
--this function returns the areaID, adding the area to mudlet's mapper table if necessary
local function findAreaID(areaname)
	--areaname is expected to be gmcp.room.info.area
	local list = getAreaTable() --load mudlet's mapper table
	local areaID = -1
	if list[areaname] ~= nil then --not nil, so there is already an area with that name in the mapper table
		areaID = list[areaname] --get the value indexed to the area's name
	else --nil result, so the area name is NOT the mapper table and needs to be added
		areaID = addAreaName(areaname) --add the area to the mapper table, returning the new area ID
    setMapZoom(6, areaID) --sets the zoom of our new area to something reasonable
	end			
	return areaID
end


-----[ generate room coordinates ]-----
--rooms are built on a grid that is 64 sqares wide and 63 squares tall
--we only need to care about how wide the grid is to get the room coordinates
--calculate their location using the power of MATH
function fedmap.makeCoords(roomnum)
	--roomnum is expected to be gmcp.room.info.num
	local coordX = roomnum % 64 --modulus to get the column
  --local coordY = roomnum // 64 --floor division to get the row
  local coordY = math.floor(roomnum / 64) --evidently mudlet has no native floor division
	--there is no Z coord returned because the underlying grid is flat
	return coordX, -coordY
end
--Y is returned inverted because the game's map puts 0,0 at the top left
--and mudlet's map puts 0,0 in the center
--inverting Y syncs everything back up


-----[ create room ]-----
--generates a room if no room exists, and either way centers the map on the current location
--this is the function called when we receive gmcp.room data from the game
function fedmap.makeRoom()
	local roomHash = gmcp.room.info.system .. "." .. gmcp.room.info.area .. "." .. gmcp.room.info.num
	local roomID = getRoomIDbyHash(roomHash)
	local areaID = findAreaID(gmcp.room.info.area)
	local coordX, coordY = fedmap.makeCoords(gmcp.room.info.num)
	
	if roomID == -1 then -- -1 is returned if no room ID matches the hash
		roomID = createRoomID() --get the next free room number
		setRoomIDbyHash(roomID, roomHash) --assign that room number to this room's hash
		addRoom(roomID, areaID) --create the room using our generated room number
		setRoomCoordinates(roomID, coordX, coordY, 0) --place the room on the map
		setRoomName(roomID, gmcp.room.info.name)
    fedmap.roomColor(roomID)
    fedmap.generateExits(areaID, roomID)
  elseif getRoomName(roomID) == "" then --room exists but hasn't had its info set
		--this existing room already has an ID, hash, and coordinates
		setRoomName(roomID, gmcp.room.info.name)
		fedmap.roomColor(roomID)
		fedmap.generateExits(areaID, roomID)
	end
  centerview(roomID)
end
