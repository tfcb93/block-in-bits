extends Node2D;

@onready var seconds_particle := preload("res://Scenes/add_second_particle.tscn");
@onready var start_pos := $"Start Pile Position";
@onready var life_value := $interface/life_value;
@onready var top_block := $top_block;
@onready var under_block := $under_block;

@export var sequence: BlockSequence = null;

var blocks = [];
var block_groups = {0: 0};
var actual_block_hits := 0;
var actual_depth := 0;
var actual_milestone := Globals.endless_initial_milestone;

func _ready() -> void:
	var screen_size = get_viewport_rect().size;
	start_pos.position = Vector2(screen_size.x/2, screen_size.y / 2);

	Events.connect("generate_pile", _on_generate_pile);
	Events.connect("hit_block", _on_hit_block);

func _on_generate_pile() -> void:
	if (not sequence):
		# random order
		for block in range(1, 10):
			generate_new_block();
	update_block_info();

func _on_insert_element_on_pile() -> void:
	generate_new_block();
	update_block_info();

func generate_new_block() -> void:
	# first, grab a random block group that is valid
	var rnd_group := randi_range(0, len(block_groups) - 1) if len(block_groups) > 1 else 0;
	# access the group
	var rnd_group_key:int = block_groups.keys()[rnd_group];
	# pick up a random block from that group if value is bigger than 1
	var rnd_block_index := randi_range(0, len(Globals.blocks[rnd_group_key]) - 1) if len(Globals.blocks[rnd_group_key]) else 0;
	var block_from_resource:Block = Globals.blocks[rnd_group_key][rnd_block_index];
	var toughness_multiplier:float = block_from_resource.toughness_increase_factor * block_groups[rnd_group_key] if (block_groups[rnd_group_key] > 0) else 1;
	blocks.push_back([block_from_resource.life, block_from_resource.toughness * toughness_multiplier, block_from_resource.color, block_from_resource.points]);

func update_blocks() -> void:
	if(Globals.blocks.get(actual_depth)):
		block_groups[actual_depth] = 0;
	if(actual_depth == actual_milestone):
		actual_milestone *= Globals.endelss_milestone_multiply_factor;
		for k in block_groups.keys():
			block_groups[k] += 1;
		if (not Globals.controller_type.is_empty() and Globals.is_vibration_active):
			Input.start_joy_vibration(0, 1, 0.5, 0.5);
		

func update_block_life_text() -> void:
	life_value.text = str(blocks[0][0]);

func update_block_info() -> void:
	life_value.text = str(blocks[0][0]);
	top_block.modulate = blocks[0][2]; # block color
	under_block.modulate = blocks[1][2];


func _on_hit_block(tool_resistance: int) -> void:
	blocks[0][0] -= roundi((tool_resistance / float(blocks[0][1])) * 100);
	actual_block_hits += 1;	
	if (blocks[0][0] <= 0):
		break_block();
		if (not sequence):
			_on_insert_element_on_pile();
		elif(sequence and len(blocks) == 1):
			under_block.queue_free();
		elif(sequence and len(blocks) == 0):
			# next level
			pass;
	update_block_life_text();

func break_block() -> void:
	calculate_player_points();
	blocks.pop_front();
	actual_block_hits = 0;
	actual_depth += 1;
	update_blocks();
	update_block_info();
	Events.emit_signal("depth_change", actual_depth);
	Events.emit_signal("add_time", 1);
	var new_seconds_particle := seconds_particle.instantiate();
	%particles_position.add_child(new_seconds_particle);
	new_seconds_particle.emitting = true;
	play_sound_effects();

func calculate_player_points() -> void:
	Events.emit_signal("earn_points", blocks[0][3]);

func play_sound_effects() -> void:
	if (Globals.is_sound_effects_on):
		%sfx_block_break.volume_db = randf_range(0.5, 3);
		%sfx_block_break.pitch_scale = randf_range(1, 4);
		%sfx_block_break.play();

func hide_interface() -> void:
	%interface.visible = false;

func show_interface() -> void:
	%interface.visible = true;