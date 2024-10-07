extends Node2D;

@onready var level_instance := preload("res://Scenes/level.tscn");

var generated_level: Node;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("unpause_game", _on_unpause_game);

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("action")):
		match Globals.game_state:
			Globals.GAME_STATES.START_SCREEN:
				start_game();
			Globals.GAME_STATES.IN_GAME:
				print("ignore value here");
	elif (event.is_action_pressed("start")):
		match Globals.game_state:
			Globals.GAME_STATES.START_SCREEN:
				start_game();
			Globals.GAME_STATES.IN_GAME:
				pause_game();
			Globals.GAME_STATES.PAUSED:
				print("ignore this paused value");

func start_game() -> void:
	print("game start");
	Events.emit_signal("close_start_screen");
	generated_level = level_instance.instantiate();
	add_child(generated_level);
	Globals.game_state = Globals.GAME_STATES.IN_GAME;

func pause_game() -> void:
	get_tree().paused = true;
	Globals.game_state = Globals.GAME_STATES.PAUSED;
	Events.emit_signal("pause_game");

func _on_unpause_game() -> void:
	get_tree().paused = false;
	Globals.game_state = Globals.GAME_STATES.IN_GAME;