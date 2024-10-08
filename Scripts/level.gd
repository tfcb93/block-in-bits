extends Node2D

@onready var player := $Player;

var counter_value := 0;

func _ready() -> void:
	load_blocks_into_memory();

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("action")):
		match Globals.game_state:
			Globals.GAME_STATES.IN_GAME:
				Events.emit_signal("hit_block", player.player_tool.resistance);

func load_blocks_into_memory() -> void:
	var block_files := DirAccess.open("res://Resources/blocks").get_files();
	for file in block_files:
		var new_block := load("res://Resources/blocks/" + file);
		Globals.blocks[file.replace("_block.tres", "")] = new_block;
	Events.emit_signal("generate_pile");

func _on_bought_item(value: int) -> void:
	Globals.total_player_points -= value;
	Events.emit_signal("bits_discounted");
	print(Globals.total_player_points);
	
func _on_add_bits() -> void:
	Globals.total_player_points += Globals.actual_block_points;