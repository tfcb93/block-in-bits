extends Node2D;

@onready var start_pos := $"Start Pile Position";
@onready var tap_sound := $"Tap Sound";
@onready var block_sounds := $"Block Sounds";
@onready var destroy_block_sound := $"Destroy Block Sound";

@onready var life_value := $interface/life_value;

var pile_types: Array[String] = [];
var taps_since_new_block := 0;
var total_blocks_generated := 0;

# ====
@onready var top_block := $top_block;
@onready var under_block := $under_block;

@export var sequence: BlockSequence = null;

var blocks = [];
var actual_block_hits := 0;

func _ready() -> void:
	var screen_size = get_viewport_rect().size;
	start_pos.position = Vector2(screen_size.x/2, screen_size.y / 2);

	Events.connect("generate_pile", _on_generate_pile);
	Events.connect("hit_block", _on_hit_block);

	Events.connect("pause_game", _on_pause_game);
	Events.connect("unpause_game", _on_unpause_game);
	# Events.connect("tap",_on_screen_tap);
	# life_value.text = str(blocks[0].life);

	# for i in range(len(pile_types)):
	# 	var newBlock = block_scene.instantiate();
	# 	newBlock.position = start_pos.position + Vector2(0.0, block_gap * i);
	# 	newBlock.block_type = pile_types[i];
	# 	pile.add_child(newBlock);
	# 	pile.move_child(newBlock, 0);
		
	# #load_block_sounds();
	# set_actual_block(pile.get_child(-1).block_type);

# func _on_screen_tap() -> void:
# 	if not Globals.game_stop:
# 		#taps_since_new_block += 1;
# 		#if taps_since_new_block >= pile.get_child(-1).life:
# 		if pile.get_child(-1).life <= 0:
# 			#play_block_sound(pile.get_child(-1).block_type);
# 			destroy_block_sound.pitch_scale = randf_range(1.0, 0.7);
# 			destroy_block_sound.play();
# 			pile.get_child(-1).queue_free();
# 			taps_since_new_block = 0;
# 			Globals.total_blocks_destroyed += 1;
# 			pile_types.pop_front();
# 			set_actual_block(pile_types[0]);
			
# 			Events.emit_signal("add_bits");
# 			Globals.actual_block_points = 0;
			
# 			if pile.get_child_count() - 1 == 0:
# 				Globals.game_stop = true;
			
# 			generate_block_pile();
# 			insert_new_block();
			
# 			lift_pile_up();
# 		else:
# 			tap_sound.pitch_scale = randf_range(3.0, 1.0);
# 			tap_sound.play();

func _on_generate_pile() -> void:
	if (not sequence):
		var block_types:Array = Globals.blocks.keys();
		# random order
		for block in range(1, 3):
			var rnd := randi_range(0, len(block_types) - 1);
			var new_block_resource:Block = Globals.blocks[block_types[rnd]];
			blocks.push_back([new_block_resource.life, new_block_resource.resistance, new_block_resource.color]); # Array<[life, resistance, color]>
	update_block_info();

func _on_insert_element_on_pile() -> void:
	var block_types:Array = Globals.blocks.keys();
	var rnd := randi_range(0, len(block_types) - 1);
	var new_block_resource:Block = Globals.blocks[block_types[rnd]];
	blocks.push_back([new_block_resource.life, new_block_resource.resistance, new_block_resource.color]); # Array<[life, resistance, color]>
	update_block_info();


func update_block_info() -> void:
	life_value.text = str(blocks[0][0]);
	top_block.modulate = blocks[0][2]; # block color
	under_block.modulate = blocks[1][2];


func _on_hit_block(tool_resistance: int) -> void:
	blocks[0][0] -= ceili(tool_resistance / float(blocks[0][1])); # I need to convert the divisor, otherwise or I change every block resistance to be float or I lost the float part and the ceil will lose it's value here
	actual_block_hits += 1;
	if (blocks[0][0] <= 0):
		blocks.pop_front();
		print(actual_block_hits);
		calculate_player_points();
		actual_block_hits = 0;
	if (not sequence):
		_on_insert_element_on_pile();
	elif(sequence and len(blocks) == 1):
		under_block.queue_free();
	elif(sequence and len(blocks) == 0):
		# next level
		pass;
	update_block_info();

func calculate_player_points() -> void:
	var total_points_earned = 1;
	Events.emit_signal("earn_points", total_points_earned);

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

# func set_actual_block(type: String) -> void:
# 	Globals.actual_block_type = type;

func _on_pause_game() -> void:
	%interface.visible = false;

func _on_unpause_game() -> void:
	%interface.visible = true;
