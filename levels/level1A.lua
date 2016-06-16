-- These are the hitboxes for this level. The rectangles are created, but never shown.
interactTable = {
-- the downward portal
  {
  xPos = 0,
  yPos = love.graphics.getHeight()-8,
  width = love.graphics.getWidth(),
  height = 9,
  type = 4,
  portal = 1,
},
-- the left portal
  {
  xPos = 0,
  yPos = 0,
  width = 8,
  height = love.graphics.getHeight(),
  type = 4,
  portal = 2,
  },
  -- the right portal
  {
  xPos = love.graphics.getHeight()-8,
  yPos = 0,
  width = 8,
  height = love.graphics.getHeight(),
  type = 4,
  portal = 3,
  },
  {
-- the upward portal
    xPos = 0,
    yPos = 0,
    width = love.graphics.getWidth(),
    height = 8,
    type = 4,
    portal = 4,
  },
}

interactTableG = {
-- the downward portal
  {
  xPos = 0,
  yPos = love.graphics.getHeight()-8,
  width = love.graphics.getWidth(),
  height = 9,
  type = 4,
  portal = 1,
},
-- the left portal
  {
  xPos = 0,
  yPos = 0,
  width = 8,
  height = love.graphics.getHeight(),
  type = 4,
  portal = 2,
  },
  -- the right portal
  {
  xPos = love.graphics.getHeight()-8,
  yPos = 0,
  width = 8,
  height = love.graphics.getHeight(),
  type = 4,
  portal = 3,
  },
  {
-- the upward portal
    xPos = 0,
    yPos = 0,
    width = love.graphics.getWidth(),
    height = 8,
    type = 4,
    portal = 4,
  },
  {
  -- the key
    xPos = 199,
    yPos = 311,
    width = 18,
    height = 18,
    type = 3,
    min = 1,
    max = 3,
    exist = true
  },
}

interactTableA = {
-- the downward portal
  {
  xPos = 0,
  yPos = love.graphics.getHeight()-8,
  width = love.graphics.getWidth(),
  height = 9,
  type = 4,
  portal = 1,
},
-- the left portal
  {
  xPos = 0,
  yPos = 0,
  width = 8,
  height = love.graphics.getHeight(),
  type = 4,
  portal = 2,
  },
  -- the right portal
  {
  xPos = love.graphics.getHeight()-8,
  yPos = 0,
  width = 8,
  height = love.graphics.getHeight(),
  type = 4,
  portal = 3,
  },
  {
-- the upward portal
    xPos = 0,
    yPos = 0,
    width = love.graphics.getWidth(),
    height = 8,
    type = 4,
    portal = 4,
  },
  -- the signpost
  {
    xPos = 159,
    yPos = 269,
    width = 16,
    height = 18,
    type = 3,
    min = 1,
    max = 3,
  },
}

dialogue1A= {
  {
    line = "Navigate the maze!\nHopefully you can\nescape.",
  },
  {
    line = "There are many ways\nto get lost,\nSo be careful!",
  },
  {
    line = "Or you may be here a\nlong time!",
  }
}

dialogue1G= {
  {
    line = "This is...",
  },
  {
    line = "An orb?\nBut what does it do?\nShould you take it?",
  },
  {
    line = "You put it in\nyour inventory.",
  }
}
-- This happens the first time the draw function is looped.
function level1ALoad()
-- This variable changes depending on the level we are on, and is used to load collision tables.
  dialogue = dialogue1A
  collision = deadEndBottomA
  interact = interactTableA
  background = love.graphics.newImage('/assets/maps/deadEndBottom.png')
  for _,v in pairs(collision) do
    love.graphics.rectangle("fill", v.xPos, v.yPos, v.width, v.height)
  end
  gameState["firstLoad"] = false
end

-- This is the looping draw function of the game, specifically this level.
function level1ADraw()
  if gameState["firstLoad"] then
    level1ALoad()
  end
-- The above section is only done once to save memory, the below stuff is looped.
    love.graphics.draw(background)
    love.graphics.draw(signpostSprite, collision[5].xPos, collision[5].yPos, 0, 0.5, 0.5)
    love.graphics.draw(player.img, player.xPos, player.yPos, 0)
      if interactFunction >= 4 then
        interactDo[interactFunction]()
      elseif interactFunction ~= 0 then
      love.graphics.draw(interactButtons[interactFunction], 32, 317)
    end
end

-- This happens the first time the draw function is looped.
function level1BLoad()
-- This variable changes depending on the level we are on, and is used to load collision tables.
  dialogue = dialogue1A
  collision = TSideUp
  interact = interactTable
  background = love.graphics.newImage('assets/maps/TSideUp.png')
  for _,v in pairs(collision) do
    love.graphics.rectangle("fill", v.xPos, v.yPos, v.width, v.height)
  end
  gameState["firstLoad"] = false
end

-- This is the looping draw function of the game, specifically this level.
function level1BDraw()
  if gameState["firstLoad"] then
    level1BLoad()
  end
-- The above section is only done once to save memory, the below stuff is looped.
    love.graphics.draw(background)
    love.graphics.draw(player.img, player.xPos, player.yPos, 0)
    if interactFunction >= 4 then
      interactDo[interactFunction]()
    elseif interactFunction ~= 0 then
    love.graphics.draw(interactButtons[interactFunction], 32, 317)
  end
end


-- This happens the first time the draw function is looped.
function level1CLoad()
-- This variable changes depending on the level we are on, and is used to load collision tables.
  dialogue = dialogue1A
  collision = horizontalLine
  interact = interactTable
  background = love.graphics.newImage('assets/maps/horizontalLine.png')
  for _,v in pairs(collision) do
    love.graphics.rectangle("fill", v.xPos, v.yPos, v.width, v.height)
  end
  gameState["firstLoad"] = false
end

-- This is the looping draw function of the game, specifically this level.
function level1CDraw()
  if gameState["firstLoad"] then
    level1CLoad()
  end
-- The above section is only done once to save memory, the below stuff is looped.
    love.graphics.draw(background)
    love.graphics.draw(player.img, player.xPos, player.yPos, 0)
    if interactFunction >= 4 then
      interactDo[interactFunction]()
    elseif interactFunction ~= 0 then
    love.graphics.draw(interactButtons[interactFunction], 32, 317)
  end
end

function level1DLoad()
-- This variable changes depending on the level we are on, and is used to load collision tables.
  dialogue = dialogue1A
  collision = northEastDirection
  interact = interactTable
  background = love.graphics.newImage('assets/maps/northEastDirection.png')
  for _,v in pairs(collision) do
    love.graphics.rectangle("fill", v.xPos, v.yPos, v.width, v.height)
  end
  gameState["firstLoad"] = false
end

-- This is the looping draw function of the game, specifically this level.
function level1DDraw()
  if gameState["firstLoad"] then
    level1DLoad()
  end
-- The above section is only done once to save memory, the below stuff is looped.
    love.graphics.draw(background)
    love.graphics.draw(player.img, player.xPos, player.yPos, 0)
    if interactFunction >= 4 then
      interactDo[interactFunction]()
    elseif interactFunction ~= 0 then
    love.graphics.draw(interactButtons[interactFunction], 32, 317)
  end
end

function level1ELoad()
-- This variable changes depending on the level we are on, and is used to load collision tables.
  dialogue = dialogue1A
  collision = spread
  interact = interactTable
  background = love.graphics.newImage('assets/maps/spread.png')
  for _,v in pairs(collision) do
    love.graphics.rectangle("fill", v.xPos, v.yPos, v.width, v.height)
  end
  gameState["firstLoad"] = false
end

-- This is the looping draw function of the game, specifically this level.
function level1EDraw()
  if gameState["firstLoad"] then
    level1ELoad()
  end
-- The above section is only done once to save memory, the below stuff is looped.
    love.graphics.draw(background)
    love.graphics.draw(player.img, player.xPos, player.yPos, 0)
    if interactFunction >= 4 then
      interactDo[interactFunction]()
    elseif interactFunction ~= 0 then
    love.graphics.draw(interactButtons[interactFunction], 32, 317)
  end
end

function level1FLoad()
-- This variable changes depending on the level we are on, and is used to load collision tables.
  dialogue = dialogue1A
  collision = TSideRight
  interact = interactTable
  background = love.graphics.newImage('assets/maps/TSideRight.png')
  for _,v in pairs(collision) do
    love.graphics.rectangle("fill", v.xPos, v.yPos, v.width, v.height)
  end
  gameState["firstLoad"] = false
end

-- This is the looping draw function of the game, specifically this level.
function level1FDraw()
  if gameState["firstLoad"] then
    level1FLoad()
  end
-- The above section is only done once to save memory, the below stuff is looped.
    love.graphics.draw(background)
    love.graphics.draw(player.img, player.xPos, player.yPos, 0)
    if interactFunction >= 4 then
      interactDo[interactFunction]()
    elseif interactFunction ~= 0 then
    love.graphics.draw(interactButtons[interactFunction], 32, 317)
  end
end

function level1GLoad()
-- This variable changes depending on the level we are on, and is used to load collision tables.
  dialogue = dialogue1G
  collision = deadEndBottomG
  if gameState["key"] then
    interact = interactTable
  else interact = interactTableG
  end
  background = love.graphics.newImage('assets/maps/deadEndBottom.png')
  for _,v in pairs(collision) do
    love.graphics.rectangle("fill", v.xPos, v.yPos, v.width, v.height)
  end
  gameState["firstLoad"] = false
end

-- This is the looping draw function of the game, specifically this level.
function level1GDraw()
  if gameState["firstLoad"] then
    level1GLoad()
  end
-- The above section is only done once to save memory, the below stuff is looped.
    love.graphics.draw(background)
    love.graphics.draw(player.img, player.xPos, player.yPos, 0)
    if not gameState["key"] then
      love.graphics.draw(orbSprite, interactTableG[5].xPos, interactTableG[5].yPos)
    end
      if interactFunction >= 4 then
        interactDo[interactFunction]()
      elseif interactFunction ~= 0 then
      love.graphics.draw(interactButtons[interactFunction], 32, 317)
    end
end

function level1HLoad()
-- This variable changes depending on the level we are on, and is used to load collision tables.
  dialogue = dialogue1A
  collision = deadEndTop
  interact = interactTable
  background = love.graphics.newImage('assets/maps/deadEndTop.png')
  for _,v in pairs(collision) do
    love.graphics.rectangle("fill", v.xPos, v.yPos, v.width, v.height)
  end
  gameState["firstLoad"] = false
end

-- This is the looping draw function of the game, specifically this level.
function level1HDraw()
  if gameState["firstLoad"] then
    level1HLoad()
  end
-- The above section is only done once to save memory, the below stuff is looped.
    love.graphics.draw(background)
    love.graphics.draw(player.img, player.xPos, player.yPos, 0)
    if interactFunction >= 4 then
      interactDo[interactFunction]()
    elseif interactFunction ~= 0 then
    love.graphics.draw(interactButtons[interactFunction], 32, 317)
  end
end
