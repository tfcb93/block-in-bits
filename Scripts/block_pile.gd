extends Node2D;

@export var pile_total_blocks := 1;

@onready var block_scene := preload("res://Scenes/block.tscn");
@onready var start_pos := $"Start Pile Position";
@onready var pile := $Pile;
@onready var tap_sound := $"Tap Sound";
@onready var block_sounds := $"Block Sounds";

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
		
	load_block_sounds();
	set_actual_block(pile.get_child(-1).block_type);


func _on_screen_tap() -> void:
	if not Globals.actual_pickaxe_available:
		#play another sound;
		return;
	if not Globals.game_stop:
		#taps_since_new_block += 1;
		#if taps_since_new_block >= pile.get_child(-1).life:
		if pile.get_child(-1).life <= 0:
			play_block_sound(pile.get_child(-1).block_type);
			pile.get_child(-1).queue_free();
			taps_since_new_block = 0;
			Globals.total_blocks_destroyed += 1;
			pile_types.pop_front();
			set_actual_block(pile_types[0]);
			
			Globals.total_player_points += Globals.actual_block_points;
			Globals.actual_block_points = 0;
			
			if pile.get_child_count() - 1 == 0:
				Events.emit_signal("win");
				Globals.game_stop = true;
			
			lift_pile_up();
		else:
			tap_sound.pitch_scale = randf_range(3.0, 1.0);
			tap_sound.play();

func lift_pile_up() -> void:
	for block in pile.get_children():
		block.position -= Vector2(0.0, block_gap);

func generate_pile_types() -> void:
	
	pile_types = [];
	
	for i in range(pile_total_blocks):
		# for now I will do it randomly
		# I also could make those values with better acessibility
		var type = randi() % 4;
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
				
func load_block_sounds() -> void:
	for block_type in Globals.block_types:
		var newSound = AudioStreamPlayer.new();
		newSound.stream  = load("res://Resources/Sounds/" + block_type + ".wav");
		newSound.name = block_type;
		block_sounds.add_child(newSound);
		

func play_block_sound(type: String) -> void:
	get_node("Block Sounds/" + type).play();

func set_actual_block(type: String) -> void:
	Globals.actual_block_type = type;

func set_actual_block_damage(value: int) -> void:
	pile.get_child(-1).life -= value;
