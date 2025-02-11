extends Node

const WINDOW_SCALE = 0.6

func _ready() -> void:
	var window := get_window()
	if window.is_embedded() or Engine.is_embedded_in_editor(): return
	
	# Hack to visually hide window until size is changed to fit a percentage.
	# of the screen resolution.
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	window.size = DisplayServer.screen_get_size() * WINDOW_SCALE
	window.move_to_center()
