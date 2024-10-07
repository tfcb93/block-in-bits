extends Node2D;


func _ready() -> void:
	Events.connect("open_select_mode", _on_open_select_mode);
	Events.connect("close_settings_to_selection", _on_close_settings);
	
	%interface.visible = false;

func _on_open_select_mode() -> void:
	%interface.visible = true;

func _on_close_select_mode() -> void:
	%interface.visible = false;
	Events.emit_signal("close_select_mode");

func _on_close_settings() -> void:
	%interface.visible = true;

func _on_btn_endless_pressed() -> void:
	_on_close_select_mode();
	Events.emit_signal("start_game");


func _on_btn_settings_pressed() -> void:
	%interface.visible = false;
	Events.emit_signal("open_settings_from_selection");
