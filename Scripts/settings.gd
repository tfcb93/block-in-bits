extends Node2D;

func _ready() -> void:
	Events.connect("open_settings_from_selection", _on_open_settings);
	Events.connect("open_settings_from_pause", _on_open_settings);
	Events.connect("unpause_game", _on_unpause_game);

	%interface.visible = false;
	%btn_fullscreen.button_pressed = Globals.is_game_fullscreen;
	%btn_resolution.selected = Globals.game_resolution_index;

func _on_open_settings() -> void:
	%interface.visible = true;
	%btn_fullscreen.grab_focus();

# necessary due to controller commands
func _on_unpause_game() -> void:
	%interface.visible = false;

func _on_btn_fullscreen_toggled(toggled_on: bool) -> void:
	Globals.is_game_fullscreen = toggled_on;
	if (toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
		%btn_resolution.disabled = true;
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);
		%btn_resolution.disabled = false;

func _on_btn_resolution_item_selected(index: int) -> void:
	print(index);

func _on_btn_exit_pressed() -> void:
	%interface.visible = false;
	match Globals.game_state:
		Globals.GAME_STATES.PAUSED:
			Events.emit_signal("close_settings_to_pause");
		Globals.GAME_STATES.SELECTION:
			Events.emit_signal("close_settings_to_selection");