extends Node2D;


func _ready() -> void:
	Events.connect("open_select_mode", _on_open_select_mode);

	%interface.visible = false;

func _on_open_select_mode() -> void:
	%interface.visible = true;


func _on_close_select_mode() -> void:
	%interface.visible = false;
	Events.emit_signal("close_select_mode");

func _on_btn_endless_pressed() -> void:
	_on_close_select_mode();
	Events.emit_signal("start_game");


func _on_btn_settings_pressed() -> void:
	pass # Replace with function body.
