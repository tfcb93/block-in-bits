extends Node2D;

func _ready() -> void:
	Events.connect("close_start_screen", _on_close_start_screen);

func _on_close_start_screen() -> void:
	%interface.visible = false;