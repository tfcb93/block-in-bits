extends Node2D;


func _ready() -> void:
	%interface.visible = false;

	Events.connect("open_settings_from_selection", _on_open_settings);
	Events.connect("open_settings_from_pause", _on_open_settings);

func _on_open_settings() -> void:
	%interface.visible = true;

func _on_btn_fullscreen_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.


func _on_btn_resolution_item_selected(index: int) -> void:
	pass # Replace with function body.


func _on_btn_exit_pressed() -> void:
	%interface.visible = false;
	match Globals.game_state:
		Globals.GAME_STATES.PAUSED:
			Events.emit_signal("close_settings_to_pause");
		Globals.GAME_STATES.SELECTION:
			Events.emit_signal("close_settings_to_selection");