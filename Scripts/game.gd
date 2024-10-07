extends Node2D;

@onready var level_instance := preload("res://Scenes/level.tscn");

var generated_level: Node;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("unpause_game", _on_unpause_game);
	Events.connect("close_select_mode", _on_close_select_mode);
	Events.connect("start_game", _on_start_game);

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("action")):
		match Globals.game_state:
			Globals.GAME_STATES.START_SCREEN:
				select_game_mode();
			Globals.GAME_STATES.IN_GAME:
				print("ignore value here");
	elif (event.is_action_pressed("start")):
		match Globals.game_state:
			Globals.GAME_STATES.START_SCREEN:
				# start_game();
				select_game_mode();
			Globals.GAME_STATES.IN_GAME:
				pause_game();
			Globals.GAME_STATES.PAUSED:
				print("ignore this paused value");

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