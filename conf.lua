function love.conf(t)
	t.title = "Pong"
	t.author = "M. Groll"
	--t.url = nil
	--t.identity = nil
	t.version = "0.8.0"
	t.console = true
	t.release = false
	t.screen.width = 600
	t.screen.height = 800
	t.fullscreen = false
	t.vsync = false
	t.screen.fsaa = 0
	t.modules.joystick = false
	t.modules.audio = true
	t.modules.keyboard = true
	t.modules.mouse = true
	t.modules.event = true
	t.modules.image = true
	t.modules.graphics = true
	t.modules.timer = true
	t.modules.sound = true
	t.modules.physics = false
end