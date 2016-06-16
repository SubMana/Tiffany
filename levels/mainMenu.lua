-- The reason this is in a function is so that is exclusively used when the player is in the main menu.
function mainMenuLoad()
  cursorPos = 1
  cursor = love.graphics.newImage('assets/cursor.png')
  fontSize = 18
  font = love.graphics.newFont("assets/text.ttf", fontSize)

  menuMin = 1
  menuMax = 2

  -- Background and sound, as per usual.
  background = love.graphics.newImage("assets/mainMenu.png")
  music = love.audio.newSource("music/mainMenu.ogg")
end

function mainMenuDraw()
-- Loading some local variables to simplify the development process.
  local backgroundScale = 0.5
  local buttonxPos = 150
-- This stuff only needs to be drawn once, so we only draw it once.

-- This stuff must be constantly updated, therefore we are constantly looping through it to check for changes.
  love.graphics.draw(background, 0, 0, 0, backgroundScale, backgroundScale)
  for v=1, 1, 1 do
    love.graphics.print(mainMenuButton[v].text, buttonxPos, mainMenuButton[v].yPos)
  end
-- Draws the cursor in a certain position depending on the input given by the user.
  if cursorPos == 1 then
    love.graphics.draw(cursor, buttonxPos-cursor:getWidth(), mainMenuButton[1].yPos-5, 0, 0.5, 0.5)

  elseif cursorPos == 2 then
    love.graphics.draw(cursor, buttonxPos-cursor:getWidth(), mainMenuButton[3].yPos-5, 0, 0.5, 0.5)
  end
end

function menuSettingsDraw()
  if gameState["firstLoad"] then
    mainMenuLoad()
    music:play()
    love.graphics.setFont(font)
    gameState["firstLoad"] = false
  end
-- Loading some local variables to simplify the development process.
  local backgroundScale = 0.5
  local buttonxPos = 150
-- This stuff must be constantly updated, therefore we are constantly looping through it to check for changes.
  love.graphics.draw(background, 0, 0, 0, backgroundScale, backgroundScale)
  love.graphics.print("How to play!", 75, 180, 0, 2, 2)
  love.graphics.print("- Z to interact!\n\n- Arrow keys to move!\n\n- Find the treasure and escape!", 30, 240, 0, 0.8, 0.8)
end

-- Currently no functitonality.
function startGame()
  love.audio.stop()
  music = love.audio.newSource("music/levelOneA.ogg")
  gameState["firstLoad"] = true
  gameState["mainMenu"] = false
  gameState["gameStart"] = true
  gameState["level1A"] = true
end

-- Currently no functionality.
function settings()
  menuSettingsLoad()
  gameState["mainMenu"] = false
  gameState["menuSettings"] = true
end

-- Quits the game, yo.
function quit()
  love.event.quit()
end

function back()
  gameState["mainMenu"] = true
  gameState["menuSettings"] = false
  mainMenuLoad()
end

function gameEndDraw()
  endTimer = gameTimer
  love.graphics.print("The orb vibrates as you walk...\n\n\nThe path you are on changes!\n\n\nWhere are you now?\n\n\nNobody knows...\n\n\nCompletion time: "..math.floor(endTimer).." seconds.")

end
