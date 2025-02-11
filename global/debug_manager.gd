extends Node

var should_render_imgui := not Engine.is_editor_hint()

@onready var viewport : Variant = Engine.get_singleton(&'EditorInterface').get_editor_viewport_3d(0) if Engine.is_editor_hint() else get_viewport()
@onready var camera : Variant = viewport.get_camera_3d()
@onready var _camera_fov := [camera.fov]

func _process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	if should_render_imgui: _render_imgui()
	camera.set_process_input(not (ImGui.IsWindowHovered(ImGui.HoveredFlags_AnyWindow) or ImGui.IsAnyItemActive()))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&'toggle_imgui'):
		should_render_imgui = not should_render_imgui

func _render_imgui() -> void:
	var fps := Engine.get_frames_per_second()
	var window := get_window()

	ImGui.Begin(' ', [], ImGui.WindowFlags_AlwaysAutoResize | ImGui.WindowFlags_NoMove)
	ImGui.SetWindowPos(Vector2(20, 20))
	ImGui.SeparatorText(ProjectSettings.get_setting('application/config/name'))
	ImGui.Text('FPS:                %d (%s)' % [fps, '%.2fms' % (1.0 / fps*1e3)])

	ImGui.SeparatorText('Camera')
	ImGui.Text('Camera Position:    %+.2v' % camera.global_position)
	ImGui.Text('Camera FOV:        '); ImGui.SameLine(); if ImGui.SliderFloat('##fov_float', _camera_fov, 20, 170): camera.fov = _camera_fov[0]

	ImGui.Dummy(Vector2(0,0)); ImGui.Separator(); ImGui.Dummy(Vector2(0,0))
	ImGui.PushStyleColor(ImGui.Col_Text, Color.WEB_GRAY)
	ImGui.Text('Press %s-H to toggle GUI visibility!' % ['Cmd' if OS.get_name() == 'macOS' else 'Ctrl'])
	if not window.is_embedded() and not Engine.is_embedded_in_editor():
		ImGui.Text('Press %s-F to toggle fullscreen!' % ['Cmd' if OS.get_name() == 'macOS' else 'Ctrl'])
	ImGui.PopStyleColor()
	ImGui.End()
