extends Node2D;

func _ready() -> void:
	%interface.visible = false;
	Events.connect("open_credits", _on_open_credits);

func _on_open_credits() -> void:
	%interface.visible = true;

func _on_btn_exit_pressed() -> void:
	%interface.visible = false;
	Events.emit_signal("close_credits");
