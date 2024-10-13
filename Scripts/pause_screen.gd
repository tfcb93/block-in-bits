extends Node2D;

func _ready() -> void:
	Events.connect("pause_game",_on_pause_game);
	Events.connect("unpause_game",_on_unpause_game);
	Events.connect("close_settings_to_pause", _on_close_settings);
	Events.connect("close_instructions_to_pause", _on_close_instructions);
	
	if (not get_tree().paused):
		%interface.visible = false;

	# while I don't have other settings besides fullscree
	if (Globals.is_mobile):
		%btn_settings.visible = false;
		# in case someone is using a controller on the phone or tablet
		%btn_back.focus_neighbor_bottom = %btn_info;
		%btn_back.focus_neighbor_top = %btn_back;

func _on_pause_game() -> void:
	%interface.visible = true;
	%btn_back.grab_focus();
	
func _on_unpause_game() -> void:
	%interface.visible = false;

func _on_close_settings() -> void:
	%interface.visible = true;
	%btn_settings.grab_focus();

func _on_close_instructions() -> void:
	%interface.visible = true;
	%btn_info.grab_focus();

func _on_btn_back_pressed() -> void:
	Events.emit_signal("unpause_game");

func _on_btn_settings_pressed() -> void:
	%interface.visible = false;
	Events.emit_signal("open_settings_from_pause");

func _on_btn_info_pressed() -> void:
	%interface.visible = false;
	Events.emit_signal("open_instructions_from_pause");

func _on_btn_exit_pressed() -> void:
	%interface.visible = false;
	Events.emit_signal("exit_level");