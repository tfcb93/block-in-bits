extends Node2D;

@export var pile_total_blocks := 1;

@onready var block_scene := preload("res://Scenes/block.tscn");
@onready var start_pos := $"Start Pile Position";
@onready var pile = $Pile;

var pile_types: Array[String] = [];
var block_gap := 54.0;
var taps_since_new_block := 0;

func _ready() -> void:
	
	var screen_size = get_viewport_rect().size;
	start_pos.position = Vector2(screen_size.x/2, screen_size.y / 2);
	
	Events.connect("tap",_on_screen_tap);
	
	generate_pile_types();
	
	for i in range(pile_total_blocks):
		var newBlock = block_scene.instantiate();
		newBlock.position = start_pos.position + Vector2(0.0, block_gap * i);
		newBlock.block_type = pile_types[i];
		pile.add_child(newBlock);
		pile.move_child(newBlock, 0);


func _on_screen_tap() -> void:
	if not Globals.game_stop:
		taps_since_new_block += 1;
		if taps_since_new_block >= pile.get_child(-1).life:
			pile.get_child(-1).queue_free();
			taps_since_new_block = 0;
			Globals.total_blocks_destroyed += 1;
			
			print(pile.get_child_count());
			
			if pile.get_child_count() - 1 == 0:
				Events.emit_signal("win");
				Globals.game_stop = true;
			
			lift_pile_up();
		
func lift_pile_up() -> void:
	for block in pile.get_children():
		block.position -= Vector2(0.0, block_gap);

func generate_pile_types() -> void:
	
	pile_types = [];
	
	for i in range(pile_total_blocks):
		# for now I will do it randomly
		# I also could make those values with better acessibility
		var type = randi() % 3;
		match type:
			0:
				pile_types.push_back("earth");
			1:
				pile_types.push_back("stone");
			2:
				pile_types.push_back("coal");
			3:
				pile_types.push_back("metal");
			_:
				pile_types.push_back("earth");
