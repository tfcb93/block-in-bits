extends Node2D;

func _ready() -> void:
	%interface.visible = false;

	Events.connect("open_instructions_from_selection", _on_open_instructions);
	Events.connect("open_instructions_from_pause", _on_open_instructions);
	Events.connect("unpause_game", _on_unpause_game);

func _on_open_instructions() -> void:
	%interface.visible = true;
	%btn_exit.grab_focus();

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