# Fed2
These are [Mudlet](https://wiki.mudlet.org/w/Main_Page) packages designed for the [Federation 2 Community Edition](https://federation2.com) text-based space trading game.

Two packages are available: the standalone fed2mapper package that has no UI elements, or the fed2ui package that contains a lightweight UI and includes the mapper. Plese remove the Generic Mapper package before installing the fed2mapper. The fed2ui package will uninstall Generic Mapper on its own.

## fed2ui screenshot
![Screenshot of the v1.5 fed2ui interface](https://raw.githubusercontent.com/Ohmi02/Fed2/refs/heads/main/fed2ui_screenshot_v2.PNG)

## Install Instructions
- Download either fed2ui.mpackage or fed2mapper.mpackage and place it in the directory of your choice.
- Open Mudlet, click on the 'Packages' button in the menu bar to reach the Package Manager.
- Select 'Install new package' in the window that appears, navigate to where you placed your mpackage, and select it.
  + if installing the fed2mapper, also select the Generic Mapper and remove it.
- You may need to restart Mudlet before everything works.

# fed2ui
basic UI and mapper for Federation 2 Community Edition

This is a basic interface that breaks out useful information into separate windows. Exchange and login/logoff spam goes on the left, useful stats on top, a mapper on the top right, and a copy of chat on the bottom right.

Currently colors and font sizes are hardcoded. Customization is planned in a future update.

This primarily uses GMCP events to collect information, with some aliases designed to catch outgoing chat and copy it into the chat window. Exchange and login/logoff spam is caught entirely through triggers. The mapper uses GMCP events and is always on, but has some aliases allowing basic map editing. Once installed type 'fedmap help' for the list of mapper aliases.

## Change Log
- *fed2ui v1.6.2*:
  + fixed issue where stats wouldn't display for ranks with no groat cap
- *fed2ui v1.6.1*:
  + fixed up the 'work' output to no longer show unprofitable jobs, adjusted the formatting to be cleaner
  + fixed some travel times in the SolDistances list
  + fixed the status display to work with the 'Adventuress' rank, and not just the 'Adventurer' rank
- *fed2ui v1.6*:
  + in light of my ongoing quest to not need to look at external pages while playing,
    the 'work' command now copies a condensed summary of Armstrong Cuthbert jobs to the Cargo tab.
    This condensed output shows actual travel times between planets and total pay, making it easier
    to identify high-paying jobs and avoid jobs with a penalty.
- *fed2ui v1.5*:
  + changed 'Exchange' tab to 'Overflow' tab
  + login/logoff spam (in addition to exchange spam) is sent to the Overflow tab
  + adjusted integrated mapper to v1.2 - see fed2mapper changelog for details
- *fed2ui v1.4*:
  + since the package is no longer autoinstalled on launching Fed2, removed the install toggle
  + Formatted money display to be more readable
  + Added alarming colors when your cargo space, fuel, or stamina get low
  + Added 'Commodities' tab that displays every commodity in-game, sorted by base price
- *fed2ui v1.3*:
  + Fixed adjustable windows not actually being adjustable
  + Cargo window will now clear itself before displaying cargo
  + Added a toggle so you can tell the UI not to automatically build itself on install
  + Added auto uninstall of Generic Mapper
- *fed2ui v1.2*:
  + UI will automatically build itself on install
 ## To Do
 - Better triggers/logic for catching exchange spam
 - Aliases so the UI will respect when the in-game default colors for chat and exchange messages are changed
 - Add logic to catch XT chat 

# fed2mapper
standalone mapper for Federation 2 Community Edition

This mapper is designed to work with Federation 2 Community Edition. This is the standalone version that does not include any other GUI. Does not support speedwalking. Please remove the Generic Mapper package before using. Display the map by clicking on the 'Map' icon in the Mudlet toolbar.

The mapper uses GMCP events only and is a bare-bones mapper designed to 'just work'. No need to turn it on, it automatically runs when it receives room data. It will intelligently identify and mark shuttlepads, exchanges, planets, and link gates on the map.

Also included are some aliases allowing light map editing from the command line, such as setting room colors, room symbols, doors (cosmetic only), shifting or moving rooms entirely, as well as resetting rooms or wiping the entire map. See 'fedmap help' for a full list of aliases.

## fed2mapper aliases
- **fedmap symbol {x}** - will add text to the room you're in
  + recommended 1 or 2 characters only, will accept ascii/unicode/emoji
- **fedmap clear symbol** - will clear any existing text in your room
- **fedmap color {color}** - sets the room's color
  + available colors:
  + red, green, yellow, blue, magenta, cyan,
  + white, black, grey, bright grey,
  + bright red, bright green, bright yellow
  + bright blue, bright magenta, bright cyan
- **fedmap door {direction} {door color}** - sets some cosmetic lines on the map
  + available door colors:
  + 'none', 'green', 'yellow', 'red'
- **fedmap exit {direction} {room number}** - manually sets a one way exit
  + running it on an exit that already exists will remove it instead
  + good for situations where exits appear and disappear, such as earth's shuttle
- **fedmap shift {direction}** - nudges a room one square in the indicated direction
- **fedmap move {x-coordinate} {y-coordinate}** - moves the room to the specified coordinates
- **fedmap reset room** - resets the room to its default name, color, symbols, and coordinates
- **fedmap reset exits** - resets the room's exits to whatever the game is showing right now
- **fedmap reset zoom** - resets the area zoom to default
- **fedmap delete area** - wipes the current map, for when you want to start over completely
- **fedmap grid {on/off}** - toggles mapper's grid mode, smushing rooms together and hiding the exit lines
- **fedmap help** - lists all the aliases
## Change Log
- *fed2mapper v1.2*:
  + adjusted the default zoom to be closer
  + added an alias to reset zoom to the default
  + changed the default color for jump points to blue
