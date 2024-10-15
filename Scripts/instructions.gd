extends Node2D;

func _ready() -> void:
	%interface.visible = false;

	Events.connect("open_instructions_from_selection", _on_open_instructions);
	Events.connect("open_instructions_from_pause", _on_open_instructions);
	Events.connect("unpause_game", _on_unpause_game);

func _on_open_instructions() -> void:
	%interface.visible = true;
	%btn_exit.grab_focus();

	check_controller_instructions();

func check_controller_instructions() -> void:
	%info_keyboard.visible = false;
	%info_ps.visible = false;
	%info_xbox.visible = false;
	%info_nintendo.visible = false;
	if(Globals.controller_type.contains("Nintendo")):
		%info_nintendo.visible = true;
	elif(Globals.controller_type.contains("PS")):
		%info_ps.visible = true;
	elif(Globals.controller_type.contains("Xbox")):
		%info_xbox.visible = true;
	else:
		%info_keyboard.visible = true;

# necessary due to controller commands
func _on_unpause_game() -> void:
	%interface.visible = false;

func _on_btn_exit_pressed() -> void:
	%interface.visible = false;
	match Globals.game_state:
		Globals.GAME_STATES.PAUSED:
			Events.emit_signal("close_instructions_to_pause");
		Globals.GAME_STATES.SELECTION:
			Events.emit_signal("close_instructions_to_selection");
