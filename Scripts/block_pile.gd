extends Node2D;

@onready var start_pos := $"Start Pile Position";
@onready var life_value := $interface/life_value;
@onready var top_block := $top_block;
@onready var under_block := $under_block;

@export var sequence: BlockSequence = null;

var blocks = [];
var block_groups = [0];
var actual_block_hits := 0;

func _ready() -> void:
	var screen_size = get_viewport_rect().size;
	start_pos.position = Vector2(screen_size.x/2, screen_size.y / 2);

	Events.connect("generate_pile", _on_generate_pile);
	Events.connect("hit_block", _on_hit_block);

	Events.connect("pause_game", _on_pause_game);
	Events.connect("unpause_game", _on_unpause_game);

func _on_generate_pile() -> void:
	if (not sequence):
		# var block_types:Array = Globals.blocks.keys();
		# random order
		for block in range(1, 50):
			generate_new_block();
			# var rnd := randi_range(0, len(block_types) - 1);
			# var new_block_resource:Block = Globals.blocks[block_types[rnd]];
			# blocks.push_back([new_block_resource.life, new_block_resource.toughness, new_block_resource.color]); # Array<[life, resistance, color]>
	update_block_info();

func _on_insert_element_on_pile() -> void:
	# var block_types:Array = Globals.blocks.keys();
	# var rnd := randi_range(0, len(block_types) - 1);
	# var new_block_resource:Block = Globals.blocks[block_types[rnd]];
	# blocks.push_back([new_block_resource.life, new_block_resource.toughness, new_block_resource.color]); # Array<[life, resistance, color]>
	generate_new_block();
	update_block_info();

func generate_new_block() -> void:
	# first, grab a random block group that is valid
	# access the group
	# pick up a random block from that group if value is bigger than 1
	var rnd_group := randi_range(0, len(block_groups) - 1) if len(block_groups) > 1 else 0;
	var rnd_block_index := randi_range(0, len(Globals.blocks[rnd_group]) - 1) if len(Globals.blocks[rnd_group]) else 0;
	var block_from_resource:Block = Globals.blocks[rnd_group][rnd_block_index];
	blocks.push_back([block_from_resource.life, block_from_resource.toughness, block_from_resource.color]);

func update_block_groups() -> void:
	pass


func update_block_info() -> void:
	life_value.text = str(blocks[0][0]);
	top_block.modulate = blocks[0][2]; # block color
	under_block.modulate = blocks[1][2];


func _on_hit_block(tool_resistance: int) -> void:
	blocks[0][0] -= roundi((tool_resistance / float(blocks[0][1])) * 100);
	actual_block_hits += 1;
	if (blocks[0][0] <= 0):
		blocks.pop_front();
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

func _on_pause_game() -> void:
	%interface.visible = false;

func _on_unpause_game() -> void:
	%interface.visible = true;
