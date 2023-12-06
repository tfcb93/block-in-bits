extends Node

@onready var canvas := $CanvasLayer;

func _ready() -> void:
	canvas.visible = false;
	Events.connect("finish", _on_game_finish);


func _on_game_finish() -> void:
	canvas.visible = true;


func _on_restart_button_down() -> void:
	pass;


func _on_quit_button_down() -> void:
	get_tree().quit();
