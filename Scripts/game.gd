extends Node2D

@onready var counters_node := $Counters;

var counter_value := 0;

func _ready() -> void:
	counters_node.visible = false;
	var screensize := get_viewport_rect().size;

func _unhandled_input(event: InputEvent) -> void:
	if not Globals.game_stop:
		if event is InputEventScreenTouch and event.is_pressed():
			if not Globals.game_start:
				Globals.game_start = true;
				$"Start Screen".visible = false;
				counters_node.visible = true;
			else:
				Globals.total_taps += 1;
				Events.emit_signal("tap");
