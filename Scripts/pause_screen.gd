extends Node2D;


func _ready() -> void:
	Events.connect("pause_game",_on_pause_game);
	Events.connect("unpause_game",_on_unpause_game);
	if (not get_tree().paused):
		%interface.visible = false;

func _on_pause_game() -> void:
	%interface.visible = true;
	%btn_back.grab_focus();
	
func _on_unpause_game() -> void:
	%interface.visible = false;


func _on_btn_back_pressed() -> void:
	Events.emit_signal("unpause_game");


func _on_btn_settings_pressed() -> void:
	pass # Replace with function body.


func _on_btn_info_pressed() -> void:
	pass # Replace with function body.


func _on_btn_exit_pressed() -> void:
	pass # Replace with function body.