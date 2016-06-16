-- This is how the game knows the player collided with an object.
function collides(collision, i, player)
  return
  player.xPos < collision[i].xPos + collision[i].width
  and
  player.xPos + player.width > collision[i].xPos
  and
  player.yPos < collision[i].yPos + collision[i].height
  and
  player.yPos + player.height > collision[i].yPos
end
-- This is how the game knows the player can interact with something.
function interacts(interact, i, player)
  return
  player.xPos < interact[i].xPos + interact[i].width
  and
  player.xPos + player.width > interact[i].xPos
  and
  player.yPos < interact[i].yPos + interact[i].height
  and
  player.yPos + player.height > interact[i].yPos
end

-- love.pressed is only used here if mainMenu is set to true, which means it's safe to keep it in this file and forget about it later on.
function love.keypressed(key)
        if gameState["mainMenu"] then
           if key == "z" then
              startGame()
            end
        elseif gameState["menuSettings"] then
          if key == "z" then
            gameState["menuSettings"] = false
            gameState["mainMenu"] = true
          end
        end
        if gameState["gameStart"] then
          if key == "z" and interactFunction ~= 0 then
            dialogueProgress = dialogueProgress + 1
            interactDo[interactFunction]()
          end
        end
end

-- This is how the game moves the player and decides how to react in the event of a collision.
function gameControls()
  moving = 0
  if not gameState["dialogue"] then
    if love.keyboard.isDown("up") and moving == 0 then
      moving = 1
    end
    if love.keyboard.isDown("down") and moving == 0 then
      moving = 2
    end
    if love.keyboard.isDown("left") and moving == 0 then
      moving = 3
    end
    if love.keyboard.isDown("right") and moving == 0 then
      moving = 4
    end
  end
  if love.keyboard.isDown("lshift") then
    player.speed = player.sprint
  else
    player.speed = player.walk
  end
-- This is for when a player collides with an object they cannot pass through.
  for i = 1, #collision do
    if collides(collision, i, player) then
      intruder = 0
      intrusion = math.abs(player.xPos + player.width - collision[i].xPos)
      temp = math.abs(player.xPos - (collision[i].xPos + collision[i].width))
      if temp < intrusion then
        intruder = 1
        intrusion = temp
      end
      temp = math.abs(player.yPos - (collision[i].yPos + collision[i].height))
      if temp < intrusion then
        intruder = 2
        intrusion = temp
      end
      temp = math.abs(player.yPos + player.height - collision[i].yPos)
      if temp < intrusion then
        intruder = 3
        intrusion = temp
      end
      if intruder == 0 then
          player.xPos = collision[i].xPos - player.width
      elseif intruder == 1 then
          player.xPos = collision[i].xPos + collision[i].width
      elseif intruder == 2 then
          player.yPos = collision[i].yPos + collision[i].height
      elseif intruder == 3 then
          player.yPos = collision[i].yPos - player.height
      end
      moving = 0
    end
  end
  moveAnimation()
-- This is for what to do when the player collides with an object that the player is allowed to pass through.
  for i = 1, #interact do
    if interacts(interact, i, player) then
      intruder = 0
      intrusion = math.abs(player.xPos + player.width - interact[i].xPos)
      temp = math.abs(player.xPos - (interact[i].xPos + interact[i].width))
      if temp < intrusion then
        intruder = 1
        intrusion = temp
      end
      temp = math.abs(player.yPos - (interact[i].yPos + interact[i].height))
      if temp < intrusion then
        intruder = 2
        intrusion = temp
      end
      temp = math.abs(player.yPos + player.height - interact[i].yPos)
      if temp < intrusion then
        intruder = 3
        intrusion = temp
      end
      interactFunction = interact[i].type
      interactPortal = interact[i].portal
-- If the event is dialogue, this tells the game what the dialogue to display actually is.
      if interactFunction == 3 then
        dialogueStart = interact[i].min
        dialogueEnd = interact[i].max
      end
      break
    else interactFunction = 0
    end
  end
end

-- This is a terribly implemented animation and I want to improve it somehow.
function moveAnimation(dt)
  if moving == 1 then
    if time > 0 then
      player.img = playerUp[1]
    end
    player.yPos = player.yPos - player.speed/4
    if time > 0.1 then
      player.img = playerUp[2]
    end
    player.yPos = player.yPos - player.speed/4
    if time > 0.2 then
      player.img = playerUp[3]
    end
    player.yPos = player.yPos - player.speed/4
    if time > 0.3 then
      player.img = playerUp[2]
    end
    player.yPos = player.yPos - player.speed/4
    if time > 0.4 then
      time = 0
    end
  elseif moving == 2 then
      if time > 0 then
        player.img = playerDown[1]
      end
      player.yPos = player.yPos + player.speed/4
      if time > 0.1 then
        player.img = playerDown[2]
      end
      player.yPos = player.yPos + player.speed/4
      if time > 0.2 then
        player.img = playerDown[3]
      end
      player.yPos = player.yPos + player.speed/4
      if time > 0.3 then
        player.img = playerDown[2]
      end
      player.yPos = player.yPos + player.speed/4
      if time > 0.4 then
        time = 0
      end
    elseif moving == 3 then
        if time > 0 then
          player.img = playerLeft[1]
        end
        player.xPos = player.xPos - player.speed/4
        if time > 0.1 then
          player.img = playerLeft[2]
        end
        player.xPos = player.xPos - player.speed/4
        if time > 0.2 then
          player.img = playerLeft[3]
        end
        player.xPos = player.xPos - player.speed/4
        if time > 0.3 then
          player.img = playerLeft[2]
        end
        player.xPos = player.xPos - player.speed/4
        if time > 0.4 then
          time = 0
        end
      elseif moving == 4 then
          if time > 0 then
            player.img = playerRight[1]
          end
          player.xPos = player.xPos + player.speed/4
          if time > 0.1 then
            player.img = playerRight[2]
          end
          player.xPos = player.xPos + player.speed/4
          if time > 0.2 then
            player.img = playerRight[3]
          end
          player.xPos = player.xPos + player.speed/4
          if time > 0.3 then
            player.img = playerRight[2]
          end
          player.xPos = player.xPos + player.speed/4
          if time > 0.4 then
            time = 0
          end
        end
end

function gameTables()
  playerUp = {}
  b = love.filesystem.getDirectoryItems('assets/animations/playerUp')
  for i,v in pairs(b) do
    playerUp[i] = love.graphics.newImage('assets/animations/playerUp/'..v)
  end
  playerDown = {}
  b = love.filesystem.getDirectoryItems('assets/animations/playerDown')
  for i,v in pairs(b) do
    playerDown[i] = love.graphics.newImage('assets/animations/playerDown/'..v)
  end
  playerLeft = {}
  b = love.filesystem.getDirectoryItems('assets/animations/playerLeft')
  for i,v in pairs(b) do
    playerLeft[i] = love.graphics.newImage('assets/animations/playerLeft/'..v)
  end
  playerRight = {}
  b = love.filesystem.getDirectoryItems('assets/animations/playerRight')
  for i,v in pairs(b) do
    playerRight[i] = love.graphics.newImage('assets/animations/playerRight/'..v)
  end
  npcStill = {}
  b = love.filesystem.getDirectoryItems('assets/animations/NPC/')
  for i,v in pairs(b) do
    npcStill[i] = love.graphics.newImage('assets/animations/NPC/'..v)
  end
  signpostSprite = love.graphics.newImage('assets/signpost.png')
  orbSprite = love.graphics.newImage('assets/orb.png')
  interactButtons = {}
  b = love.filesystem.getDirectoryItems('assets/animations/interact/')
  for i,v in pairs(b) do
    interactButtons[i] = love.graphics.newImage('assets/animations/interact/'..v)
  end
  textBox = love.graphics.newImage("assets/textBox.png")
  interactDo = {
    [1]=enter,
    [2]=open,
    [3]=talk,
    [4]=enter,
  }
end

-- These are the buttons in the main menu that the player can interact with.
function menuTables()
  mainMenuButton = {
  	[1] = {
  		text = "Start Game",
      yPos = 220,
  	},

  	[2] = {
  		text = "Quit Game",
      yPos = 260,
  	},
    [3] = {
  		text = "Back",
      yPos = 220,
  	},
  }

  mainButtonFunctions = {
    [1]=startGame,
    [2]=settings,
    [3]=quit,
    [4]=back,
  }
end

function talk()
  if not gameState["dialogue"] then
    gameState["dialogue"] = true
    dialogueProgress = dialogueStart
  elseif gameState["dialogue"] and dialogueProgress > #printMe then
    printMe = {}
    gameState["dialogue"] = false
    if gameState["level1G"] then
      gameState["key"] = true
    end
    gameState["firstLoad"] = true
  end
end
-- Dear god this is a mess. Pls fix.
function enter()
  if gameState["level1A"] then
    gameState["level1A"] = false
    gameState["level1B"] = true
    player.yPos = love.graphics.getHeight()-8-player.height
    -- level1b
  elseif gameState["level1B"] then
    if interactPortal == 1 then
      gameState["level1B"] = false
      gameState["level1A"] = true
      player.yPos = 8
    elseif interactPortal == 2 then
      gameState["level1B"] = false
      gameState["level1C"] = true
      player.xPos = love.graphics.getWidth()-8-player.width
    elseif interactPortal == 3 then
      gameState["level1B"] = false
      if gameState["key"] then
        gameState["gameEnd"] = true
        gameState["gameStart"] = false
      else
      gameState["level1C"] = true
      player.xPos = 8
      end
    end
    -- level1c
  elseif gameState["level1C"] then
    if interactPortal == 3 then
      gameState["level1C"] = false
      gameState["level1B"] = true
      player.xPos = 8
    elseif interactPortal == 2 then
      gameState["level1C"] = false
      gameState["level1D"] = true
      player.xPos = love.graphics.getWidth()-8-player.width
    end
    -- level1d
  elseif gameState["level1D"] then
    if interactPortal == 4 then
      gameState["level1D"] = false
      gameState["level1E"] = true
      player.yPos = love.graphics.getHeight()-8-player.height
    elseif interactPortal == 3 then
      gameState["level1D"] = false
      gameState["level1C"] = true
      player.xPos = 8
    end
    -- level1e
  elseif gameState["level1E"] then
    if interactPortal == 1 then
      gameState["level1E"] = false
      gameState["level1D"] = true
      player.yPos = 8
    elseif interactPortal == 2 then
      gameState["level1E"] = false
      gameState["level1C"] = true
      player.xPos = love.graphics.getWidth()-8-player.width
    elseif interactPortal == 3 then
      gameState["level1E"] = false
      gameState["level1F"] = true
      player.xPos = 8
    elseif interactPortal == 4 then
      gameState["level1E"] = false
      gameState["level1B"] = true
      player.yPos = love.graphics.getHeight()-8-player.height
    end
    -- level1f
  elseif gameState["level1F"] then
    gameState["level1F"] = false
    if interactPortal == 1 then
      gameState["level1G"] = true
      player.yPos = 8
    elseif interactPortal == 2 then
      gameState["level1E"] = true
      player.xPos = love.graphics.getWidth()-8-player.width
    elseif interactPortal == 4 then
      gameState["level1H"] = true
      player.yPos = love.graphics.getHeight()-8-player.height
    end
      -- level1g
    elseif gameState["level1G"] then
      gameState["level1G"] = false
      gameState["level1F"] = true
      player.yPos = love.graphics.getHeight()-8-player.height
      -- level1H
    elseif gameState["level1H"] then
      gameState["level1H"] = false
      gameState["level1F"] = true
      player.yPos = 8
  end
  gameState["firstLoad"] = true
  interactFunction = 0
end

function dialogueDraw()
  printMe = {}
  for i=dialogueStart, dialogueEnd, 1 do
    printMe[i] = dialogue[i].line
  end
  if #printMe < dialogueProgress then
    return
  else
    love.graphics.draw(textBox, 128, 317)
    love.graphics.print(printMe[dialogueProgress], 138, 327)
  end
end


deadEndBottomA = {
  -- Left wall
  {
  xPos = 0,
  yPos = 0,
  width = 112,
  height = love.graphics.getHeight(),
  type = "wall",
 },
 -- right wall
  {
  xPos = love.graphics.getWidth()-112,
  yPos = 0,
  width = 112,
  height = love.graphics.getHeight(),
  type = "wall",
 },
 -- top wall (left)
 {
 xPos = 0,
 yPos = 0,
 width = 0,
 height = 0,
 type = "wall",
},
 -- bottom wall
 {
  xPos = 0,
  yPos = love.graphics.getHeight()-32,
  width = love.graphics.getWidth(),
  height = 32,
  type = "wall",
 },
 {
   xPos = 160,
   yPos = 270,
   width = 14,
   height = 16,
   type = "npc",
 },
}

deadEndBottomG = {
  -- Left wall
  {
  xPos = 0,
  yPos = 0,
  width = 112,
  height = love.graphics.getHeight(),
  type = "wall",
 },
 -- right wall
  {
  xPos = love.graphics.getWidth()-112,
  yPos = 0,
  width = 112,
  height = love.graphics.getHeight(),
  type = "wall",
 },
 -- top wall (left)
 {
 xPos = 0,
 yPos = 0,
 width = 0,
 height = 0,
 type = "wall",
},
 -- bottom wall
 {
  xPos = 0,
  yPos = love.graphics.getHeight()-32,
  width = love.graphics.getWidth(),
  height = 32,
  type = "wall",
 },
 {
   xPos = 200,
   yPos = 312,
   width = 16,
   height = 16,
   type = "npc",
 },
}

deadEndTop = {
  -- Left wall
  {
  xPos = 0,
  yPos = 0,
  width = 112,
  height = love.graphics.getHeight(),
  type = "wall",
 },
 -- right wall
  {
  xPos = love.graphics.getWidth()-96,
  yPos = 0,
  width = 96,
  height = love.graphics.getHeight(),
  type = "wall",
 },
 -- top wall
 {
 xPos = 0,
 yPos = 0,
 width = love.graphics.getWidth(),
 height = 80,
 type = "wall",
},
}

TSideUp = {
  -- top wall
  {
  xPos = 0,
  yPos = 0,
  width = love.graphics.getWidth(),
  height = 64,
  type = "wall",
 },
 -- bottom wall (left)
 {
  xPos = 0,
  yPos = love.graphics.getHeight()-112,
  width = 112,
  height = 112,
  type = "wall",
 },
-- bottom wall (right)
 {
  xPos = love.graphics.getWidth()-112,
  yPos = love.graphics.getHeight()-96,
  width = 112,
  height = 112,
  type = "wall",
 },
}

horizontalLine = {
  -- top wall
  {
    xPos = 0,
    yPos = 0,
    width = love.graphics.getWidth(),
    height = 64,
    type = "wall",
  },
  -- bottom wall
  {
    xPos = 0,
    yPos = love.graphics.getHeight()-104,
    width = love.graphics.getWidth(),
    height = 96,

  },
}

northEastDirection = {
  -- left wall
  {
    xPos = 0,
    yPos = 0,
    width = 100,
    height = love.graphics.getHeight(),
    type = "wall",
  },
  -- bottom wall
  {
    xPos = 0,
    yPos = love.graphics.getHeight()-96,
    width = love.graphics.getWidth(),
    height = 96,
    type = "wall"
  },
  -- tree
  {
    xPos = love.graphics.getWidth()-80,
    yPos = 0,
    width = 80,
    height = 64,
    type = "wall"
  },
}

spread = {
  -- bottom left
  {
    xPos = 0,
    yPos = love.graphics.getHeight()-88,
    width = 96,
    height = 88,
    type = "wall"
  },
  -- bottom right
  {
    xPos = love.graphics.getWidth()-88,
    yPos = love.graphics.getHeight()-80,
    width = 88,
    height = 80,
    type = "wall"
  },
  -- top right
  {
    xPos = love.graphics.getWidth()-80,
    yPos = 0,
    width = 80,
    height = 64,
    type = "wall"
  },
  -- top left
  {
    xPos = 0,
    yPos = 0,
    width = 96,
    height = 48,
    type = "wall"
  },
}

TSideRight = {
  -- right wall
   {
   xPos = love.graphics.getWidth()-80,
   yPos = 0,
   width = 80,
   height = love.graphics.getHeight(),
   type = "wall",
  },
  -- bottom left
  {
    xPos = 0,
    yPos = love.graphics.getHeight()-92,
    width = 112,
    height = 92,
    type = "wall"
  },
  -- top left
  {
    xPos = 0,
    yPos = 0,
    width = 96,
    height = 48,
    type = "wall"
  },
}
