extends Node2D;

@onready var player := $Player;
@onready var block_pile := $"Block Pile";

var counter_value := 0;

func _ready() -> void:
	Events.emit_signal("generate_pile");

	Events.connect("pause_game", _on_pause_game);
	Events.connect("unpause_game", _on_unpause_game);

	Events.connect("open_shop", _on_open_shop);
	Events.connect("close_shop", _on_close_shop);

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("action")):
		match Globals.game_state:
			Globals.GAME_STATES.IN_GAME:
				Events.emit_signal("hit_block", player.get_actual_player_tool().resistance);

func _on_pause_game() -> void:
	block_pile.hide_interface();

func _on_unpause_game() -> void:
	block_pile.show_interface();

func _on_open_shop() -> void:
	block_pile.hide_interface();

func _on_close_shop() -> void:
	block_pile.show_interface();
