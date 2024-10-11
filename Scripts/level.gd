extends Node2D;

@onready var player := $Player;
@onready var block_pile := $"Block Pile";

var counter_value := 0;
var level_playtime := 0.0;
var is_game_finished := false;
var level_countdown := 5;

func _ready() -> void:
	Events.emit_signal("generate_pile");

	Events.connect("pause_game", _on_pause_game);
	Events.connect("unpause_game", _on_unpause_game);

	Events.connect("open_shop", _on_open_shop);
	Events.connect("close_shop", _on_close_shop);
	Events.connect("discount_points", _on_discount_points);
	Events.connect("upgrade_tools", _on_upgrade_tools);

	Events.connect("add_time", _on_add_time);

	start_level_timers();
	update_timer();

func _process(delta: float) -> void:
	if (not is_game_finished):
		level_playtime += delta;

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("action") and not is_game_finished):
		match Globals.game_state:
			Globals.GAME_STATES.IN_GAME:
				Events.emit_signal("hit_block", player.get_actual_player_tool().resistance);

func start_level_timers() -> void:
	%countdown.start();

func update_timer() -> void:
	%timer.text = str(level_countdown);

func _on_add_time(add_time: int) -> void:
	level_countdown += add_time;

func _on_pause_game() -> void:
	block_pile.hide_interface();
	%countdown.paused = true;

func _on_unpause_game() -> void:
	block_pile.show_interface();
	%countdown.paused = false;

func _on_open_shop() -> void:
	block_pile.hide_interface();
	%countdown.paused = true;
	Events.emit_signal("inform_shop_data", player.points, block_pile.actual_depth);

func _on_close_shop() -> void:
	block_pile.show_interface();
	%countdown.paused = false;

func _on_discount_points(discounted_points: int) -> void:
	player.points -= discounted_points;
	player.update_interface_player_points();
	Events.emit_signal("inform_shop_data", player.points, block_pile.actual_depth);

func _on_upgrade_tools(upgrade: Upgrade) -> void:
	for t in player.player_tools:
		t.resistance += upgrade.effects[t.link_name][0];
		t.point_multiplier += upgrade.effects[t.link_name][1];
	player.update_interface_tool_values();

func _on_countdown_timeout() -> void:
	level_countdown -= 1;
	if (level_countdown <= 0):
		%countdown.stop();
		is_game_finished = true;
		block_pile.hide_interface();
		Events.emit_signal("game_over", player.points, block_pile.actual_depth, level_playtime);
	update_timer();
