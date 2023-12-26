extends Node2D;

@onready var block_scene := preload("res://Scenes/block.tscn");
@onready var start_pos := $"Start Pile Position";
@onready var pile := $Pile;
@onready var tap_sound := $"Tap Sound";
@onready var block_sounds := $"Block Sounds";
@onready var destroy_block_sound := $"Destroy Block Sound";

var pile_types: Array[String] = [];
var block_gap := 54.0;
var taps_since_new_block := 0;
var total_blocks_generated := 0;

func _ready() -> void:
	var screen_size = get_viewport_rect().size;
	start_pos.position = Vector2(screen_size.x/2, screen_size.y / 2);
	
	Events.connect("tap",_on_screen_tap);
	generate_block_pile();
	
	for i in range(len(pile_types)):
		var newBlock = block_scene.instantiate();
		newBlock.position = start_pos.position + Vector2(0.0, block_gap * i);
		newBlock.block_type = pile_types[i];
		pile.add_child(newBlock);
		pile.move_child(newBlock, 0);
		
	#load_block_sounds();
	set_actual_block(pile.get_child(-1).block_type);

func _on_screen_tap() -> void:
	if not Globals.game_stop:
		#taps_since_new_block += 1;
		#if taps_since_new_block >= pile.get_child(-1).life:
		if pile.get_child(-1).life <= 0:
			#play_block_sound(pile.get_child(-1).block_type);
			destroy_block_sound.pitch_scale = randf_range(1.0, 0.7);
			destroy_block_sound.play();
			pile.get_child(-1).queue_free();
			taps_since_new_block = 0;
			Globals.total_blocks_destroyed += 1;
			pile_types.pop_front();
			set_actual_block(pile_types[0]);
			
			Events.emit_signal("add_bits");
			Globals.actual_block_points = 0;
			
			if pile.get_child_count() - 1 == 0:
				Globals.game_stop = true;
			
			generate_block_pile();
			insert_new_block();
			
			lift_pile_up();
		else:
			tap_sound.pitch_scale = randf_range(3.0, 1.0);
			tap_sound.play();

func lift_pile_up() -> void:
	for block in pile.get_children():
		block.position -= Vector2(0.0, block_gap);

func insert_new_block() -> void:
	var newBlock = block_scene.instantiate();
	newBlock.position = start_pos.position + Vector2(0.0, block_gap * (len(pile.get_children()) - 1));
	newBlock.block_type = pile_types[len(pile.get_children()) - 1];
	pile.add_child(newBlock);
	pile.move_child(newBlock, 0);

func generate_block_pile() -> void:
	if total_blocks_generated == 0:
		generate_starter_blocks();
	elif total_blocks_generated >= 20 or total_blocks_generated < 1000:
		generate_new_block_level_1();
	elif total_blocks_generated >= 1000 or total_blocks_generated < 10000:
		generate_new_block_level_2();
	# TODO: Delete this elif statement when building other levels
	elif total_blocks_generated >= 100000:
		generate_new_block_random_1();
	#elif total_blocks_generated >= 10000 or total_blocks_generated < 100000:
		#generate_new_block_random_1();
	#elif total_blocks_generated >= 100000:
		#generate_new_block_random_2();
	else:
		generate_random_starter_block();

func generate_starter_blocks() -> void:
	pile_types = ["earth", "earth", "earth", "earth", "earth", "stone", "stone", "stone", "sand", "sand", "stone", "stone", "stone", "coal", "stone", "coal", "stone", "stone", "stone", "metal"];
	total_blocks_generated = len(pile_types);

func generate_new_block_level_1() -> void:
	var last_pile_block = pile_types[len(pile.get_children()) - 2];
	
	match last_pile_block:
		"metal":
			insert_new_block_in_pile_types(["stone", "metal", "silver", "gold", "copper"]);
		"stone":
			insert_new_block_in_pile_types(["stone", "metal", "coal"]);
		"coal":
			insert_new_block_in_pile_types(["stone", "coal"]);
		"silver":
			insert_new_block_in_pile_types(["metal", "silver", "gold", "copper"]);
		"gold":
			insert_new_block_in_pile_types(["silver", "gold", "quartz"]);
		"copper":
			insert_new_block_in_pile_types(["metal", "silver", "copper"]);
		"quartz":
			insert_new_block_in_pile_types(["quartz", "silver", "gold"]);
		_:
			generate_random_starter_block();
	
func generate_new_block_level_2() -> void:
	pass
func generate_new_block_random_1() -> void:
	pass
func generate_new_block_random_2() -> void:
	pass

func generate_random_starter_block() -> void:
	var all_blocks = Globals.block_type_pickaxe_damages.keys();
	insert_new_block_in_pile_types(all_blocks);
	
func insert_new_block_in_pile_types(types:Array[String]) -> void:
	var new_type = randi() % len(types) - 1;
	pile_types.push_back(types[new_type]);
	++total_blocks_generated;

#func load_block_sounds() -> void:
	#for block_type in Globals.block_types:
		#var newSound = AudioStreamPlayer.new();
		#newSound.stream  = load("res://Resources/Sounds/" + block_type + ".wav");
		#newSound.name = block_type;
		#block_sounds.add_child(newSound);
		#
#
#func play_block_sound(type: String) -> void:
	#get_node("Block Sounds/" + type).play();

func set_actual_block(type: String) -> void:
	Globals.actual_block_type = type;

func set_actual_block_damage(value: int) -> void:
	pile.get_child(-1).life -= value;
