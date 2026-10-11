hl.on('hyprland.start', function()
	hl.exec_cmd('waybar')
	hl.exec_cmd('pw-play ~/.config/sound/start.wav')
end)

hl.on('workspace.active', function()
	hl.exec_cmd('pw-play ~/.config/sound/transition.wav')
end)

hl.on('window.open', function()
	hl.exec_cmd('pw-play ~/.config/sound/open.wav')
end)

hl.on('window.close', function()
	hl.exec_cmd('pw-play ~/.config/sound/close.wav')
end)

hl.on('window.fullscreen', function()
	hl.exec_cmd('pw-play ~/.config/sound/expand.wav')
end)