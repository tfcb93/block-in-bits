extends Node2D;

func _ready() -> void:
	Events.connect("close_start_screen", _on_close_start_screen);

	if (Globals.is_mobile):
		%start_button.visible = true;
		%start_text.visible = false;

func _on_close_start_screen() -> void:
	%interface.visible = false;

func _on_start_button_pressed() -> void:
	Events.emit_signal("enter_game");
