extends Node2D;

@onready var level_instance := preload("res://Scenes/level.tscn");

var generated_level: Node;

func _init() -> void:
	check_enviroment();

	if (len(Input.get_connected_joypads()) > 0):
		Globals.controller_type = Input.get_joy_name(0);

func _ready() -> void:
	Events.connect("enter_game", _on_enter_game);
	Events.connect("unpause_game", _on_unpause_game);
	Events.connect("close_select_mode", _on_close_select_mode);
	Events.connect("start_game", _on_start_game);
	Events.connect("exit_level", _on_exit_level);

	load_into_memory();
	
func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("action")):
		match Globals.game_state:
			Globals.GAME_STATES.START_SCREEN:
				select_game_mode();
	elif (event.is_action_pressed("secondary")):
		match Globals.game_state:
			Globals.GAME_STATES.IN_GAME:
				Events.emit_signal("open_shop");
			Globals.GAME_STATES.IN_SHOP:
				Events.emit_signal("close_shop");
	elif (event.is_action_pressed("start")):
		match Globals.game_state:
			Globals.GAME_STATES.START_SCREEN:
				select_game_mode();
			Globals.GAME_STATES.PAUSED:
				pass;
	elif (event.is_action_pressed("controller_start")):
		match Globals.game_state:
			Globals.GAME_STATES.START_SCREEN:
				select_game_mode();
			Globals.GAME_STATES.IN_GAME:
				pause_game();
			Globals.GAME_STATES.PAUSED:
				Events.emit_signal("unpause_game");	
	elif (event.is_action_pressed("return")):
		match Globals.game_state:
			Globals.GAME_STATES.START_SCREEN:
				get_tree().quit();
			Globals.GAME_STATES.IN_GAME:
				pause_game();
			Globals.GAME_STATES.PAUSED:
				Events.emit_signal("unpause_game");
	elif (event.is_action_pressed("left")):
		match Globals.game_state:
			Globals.GAME_STATES.IN_GAME:
				Events.emit_signal("change_tool", 1);
	elif (event.is_action_pressed("right")):
		match Globals.game_state:
			Globals.GAME_STATES.IN_GAME:
				Events.emit_signal("change_tool", -1);

func _on_enter_game() -> void:
	select_game_mode();

func select_game_mode() -> void:
	Events.emit_signal("close_start_screen");
	Events.emit_signal("open_select_mode");
	Globals.game_state = Globals.GAME_STATES.SELECTION;

func pause_game() -> void:
	get_tree().paused = true;
	Globals.game_state = Globals.GAME_STATES.PAUSED;
	Events.emit_signal("pause_game");

func _on_start_game() -> void:
	generated_level = level_instance.instantiate();
	add_child(generated_level);
	Globals.game_state = Globals.GAME_STATES.IN_GAME;

func _on_close_select_mode() -> void:
	pass;

func _on_unpause_game() -> void:
	get_tree().paused = false;
	Globals.game_state = Globals.GAME_STATES.IN_GAME;

func _on_exit_level() -> void:
	get_tree().paused = false;
	Globals.game_state = Globals.GAME_STATES.SELECTION;
	generated_level.queue_free();
	Events.emit_signal("open_select_mode");

func load_into_memory() -> void:
	load_blocks_into_memory();
	load_upgrades_into_memory();

func load_blocks_into_memory() -> void:
	var block_files := DirAccess.open("res://Resources/blocks").get_files();
	for file in block_files:
		# this is stupid
		if (file.ends_with(".remap")):
			file = file.trim_suffix(".remap");
		var new_block := load("res://Resources/blocks/" + file);
		if (not Globals.blocks.get(new_block.min_depth_appearance)):
			Globals.blocks[new_block.min_depth_appearance] = [];
		Globals.blocks[new_block.min_depth_appearance].push_back(new_block);

func load_upgrades_into_memory() -> void:
	var upgrade_files := DirAccess.open("res://Resources/upgrades").get_files();
	for file in upgrade_files:
		# this (the fact that I need to remove something created by Godot since it can't find its own files) is really stupid
		# have to use this https://github.com/godotengine/godot/issues/66014
		# godot should address this properly. This is not good and very error prone
		# or at least make it clear on how to use .remap files properly - tutorials, documentation, whatever
		if (file.ends_with(".remap")):
			file = file.trim_suffix(".remap");
		var upgrade := load("res://Resources/upgrades/" + file);
		Globals.upgrades.push_back(upgrade);
		#sort by indes
		Globals.upgrades.sort_custom(func(a: Upgrade, b: Upgrade): return a.id < b.id);

func check_enviroment() -> void:
	if (OS.has_feature("web") or OS.has_feature("web_android") or OS.has_feature("web_ios")):
		Globals.is_web = true;
	if(OS.has_feature("web_android") or OS.has_feature("web_ios") or OS.has_feature("android") or OS.has_feature("ios")):
		Globals.is_mobile = true;
