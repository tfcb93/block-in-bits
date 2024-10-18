extends Node2D;

func _ready() -> void:
	Events.connect("open_settings_from_selection", _on_open_settings);
	Events.connect("open_settings_from_pause", _on_open_settings);
	Events.connect("unpause_game", _on_unpause_game);

	%interface.visible = false;
	%btn_fullscreen.button_pressed = Globals.is_game_fullscreen;
	%btn_vibration.button_pressed = Globals.is_vibration_active;
	%btn_sound_effects.button_pressed = Globals.is_sound_effects_on;
	%btn_background.button_pressed = Globals.is_background_on;

func _on_open_settings() -> void:
	%interface.visible = true;
	%btn_fullscreen.grab_focus();

# necessary due to controller commands
func _on_unpause_game() -> void:
	%interface.visible = false;

func _on_btn_fullscreen_toggled(toggled_on: bool) -> void:
	Globals.is_game_fullscreen = toggled_on;
	Events.emit_signal("config_change","fullscreen", toggled_on);
	if (toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);

func _on_btn_exit_pressed() -> void:
	%interface.visible = false;
	match Globals.game_state:
		Globals.GAME_STATES.PAUSED:
			Events.emit_signal("close_settings_to_pause");
		Globals.GAME_STATES.SELECTION:
			Events.emit_signal("close_settings_to_selection");

func _on_btn_vibration_toggled(toggled_on: bool) -> void:
	Globals.is_vibration_active = toggled_on;
	Events.emit_signal("config_change", "vibration_active", toggled_on);


func _on_btn_sound_effects_toggled(toggled_on: bool) -> void:
	Globals.is_sound_effects_on = toggled_on;
	Events.emit_signal("config_change", "sound_effects", toggled_on);


func _on_btn_music_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.


func _on_btn_background_toggled(toggled_on: bool) -> void:
	Globals.is_background_on = toggled_on;
	Events.emit_signal("toggle_background", toggled_on);
	Events.emit_signal("config_change", "background_on", toggled_on);

func _on_btn_clear_data_pressed() -> void:
	Globals.high_depth_score = 0;
	Events.emit_signal("config_change", "high_score", 0);
