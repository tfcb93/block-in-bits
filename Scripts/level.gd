extends Node2D;

@onready var player := $Player;

var counter_value := 0;

func _ready() -> void:
	Events.emit_signal("generate_pile");

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("action")):
		match Globals.game_state:
			Globals.GAME_STATES.IN_GAME:
				Events.emit_signal("hit_block", player.get_actual_player_tool().resistance);
