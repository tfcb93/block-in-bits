extends Node2D

var counter_value := 0;

func _ready() -> void:
	var screensize := get_viewport_rect().size;

func _unhandled_input(event: InputEvent) -> void:
	if not Globals.game_stop:
		if event is InputEventScreenTouch and event.is_pressed():
			Globals.total_taps += 1;
			Events.emit_signal("tap");
