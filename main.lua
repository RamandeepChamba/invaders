WINDOW_WIDTH = 640
WINDOW_HEIGHT = 480

PLAYER_WIDTH = 100
PLAYER_HEIGHT = 20

BULLET_WIDTH = 6
BULLET_HEIGHT = 15

function love.load()
  -- Player
  player = {}
  player.x = WINDOW_WIDTH / 2 - PLAYER_WIDTH / 2
  player.y = WINDOW_HEIGHT - PLAYER_HEIGHT - 10
  player.speed = 10
  player.cooldown = 20
  player.bullets = {}
  player.fire = function ()
    if player.cooldown <= 0 then
      player.cooldown = 10
      bullet = {}
      bullet.x = player.x + PLAYER_WIDTH / 2 - BULLET_WIDTH / 2
      bullet.y = player.y
      table.insert(player.bullets, bullet)
    end
  end

  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })
end

function love.update(dt)
  player.cooldown = player.cooldown - 1

  -- Keyboard events

  -- Quit
  function love.keypressed(key)
    if key == 'escape' then
      love.event.quit()
    end
  end

  -- Player Controls
  if love.keyboard.isDown('left') and player.x >= 0 then
    player.x = player.x - player.speed
  end

  if love.keyboard.isDown('right')
    and player.x <= (WINDOW_WIDTH - PLAYER_WIDTH) then
    player.x = player.x + player.speed
  end

  if love.keyboard.isDown('space') then
    -- Fire bullets
    player.fire()
  end

  -- Move / Delete bullets
  for i, b in pairs(player.bullets) do
    -- If bullet off screen
    if b.y < -10 then
      -- Delete bullet
      table.remove(player.bullets, i)
    else
      -- Move bullet
      b.y = b.y - 10
    end
  end
end

function love.draw()
  -- Render player
  love.graphics.setColor(0, 0, 1)
  love.graphics.rectangle('fill', player.x, player.y,
    PLAYER_WIDTH, PLAYER_HEIGHT)

  -- Render bullets
  love.graphics.setColor(1, 1, 1)
  for _, b in pairs(player.bullets) do
    love.graphics.rectangle('fill', b.x, b.y,
    BULLET_WIDTH, BULLET_HEIGHT)
  end
end
