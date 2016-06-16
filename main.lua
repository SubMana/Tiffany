-- These files are needed in order to load the rest of the game.

require("gameLoad")
require("levels/mainMenu")
require("levels/level1A")
function love.load()
-- Random unsorted variables\
  debug = 0
  time = 0
  moveTimer = false
  interactFunction = 0
  dialogueProgress = 0
  gameTimer = 0
-- These are functions from other files that I need to load. They are made in seperate files so that it looks nicer.
  menuTables()
  gameTables()
-- This table checks which part of the game the user is in, whether it is in a menu, or in a battle.
gameState = {
  gameStart = false,
  menuSettings = true,
  mainMenu = false,
  level1A = false,
  level1B = false,
  level1C = false,
  level1D = false,
  level1E = false,
  key = false,
  firstLoad = true,
  dialogue = false,
}
-- This table holds all of the player's data, including character model and stats.
player = {}
  player.img = playerDown[2]
  player.width = 16
  player.height = 18
  player.xPos = 200
  player.yPos = 350
  player.dead = false
  player.walk = 2
  player.sprint = 4
end

function love.update(dt)
  if not gameState["gameEnd"] and gameState["gameStart"] then
    gameTimer = gameTimer + dt
  end
  if gameState["gameStart"] and not gameState["firstLoad"] then
    gameControls()
  end
-- This allows the player animation to function. I forgot to put this in and spent too long wondering why the game crashed.
  if moving ~= 0 then
    moveTimer = true
  else moveTimer = false
  end
  if moveTimer then
    time = time + dt
  end
  if gameState["gameStart"] then
    music:play()
  end
end

function love.draw()
  if gameState["mainMenu"] then
    mainMenuDraw()
  elseif gameState["menuSettings"] then
    menuSettingsDraw()
  elseif gameState["gameStart"] then
    if gameState["level1A"] then
      level1ADraw()
    elseif gameState["level1B"] then
      level1BDraw()
    elseif gameState["level1C"] then
      level1CDraw()
    elseif gameState["level1D"] then
      level1DDraw()
    elseif gameState["level1E"] then
      level1EDraw()
    elseif gameState["level1F"] then
      level1FDraw()
    elseif gameState["level1G"] then
      level1GDraw()
    elseif gameState["level1H"] then
      level1HDraw()
    end
  elseif gameState["gameEnd"] then
    gameEndDraw()
  end
  if gameState["dialogue"] then
    dialogueDraw()
  end
end
