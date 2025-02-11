extends Node

const WINDOW_SCALE = 0.6

func _init() -> void:
	# Hack to visually hide window until size is changed to fit a percentage.
	# of the screen resolution.
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	DisplayServer.window_set_size(DisplayServer.screen_get_size() * WINDOW_SCALE)
	DisplayServer.window_set_position(DisplayServer.screen_get_size() * (1.0 - WINDOW_SCALE) / 2.0) # Centered
