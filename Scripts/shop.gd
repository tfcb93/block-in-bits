extends Node2D;

var prices := {"upgrade": 100, "time_10": 1, "time_20": 2000};

func _ready() -> void:
	# %interface.visible = false;
	
	Events.connect("open_shop", _on_open_shop);
	Events.connect("close_shop", _on_close_shop);
	Events.connect("inform_shop_player_points", _on_inform_shop_player_points);



func _on_open_shop() -> void:
	%interface.visible = true;
	Globals.game_state = Globals.GAME_STATES.IN_SHOP;


func _on_close_shop() -> void:
	%interface.visible = false;
	Globals.game_state = Globals.GAME_STATES.IN_GAME;

func _on_inform_shop_player_points(player_points: int) -> void:
	%intf_player_points.text = str(player_points);
	%btn_time_10.disabled = true if (prices["time_10"] > player_points) else false;
	%btn_time_20.disabled = true if (prices["time_20"] > player_points) else false;


func _on_btn_upgrade_pressed() -> void:
	pass # Replace with function body.


func _on_btn_time_10_pressed() -> void:
	print("Add 10 seconds to the player!");
	Events.emit_signal("discount_points", prices["time_10"]);


func _on_btn_time_20_pressed() -> void:
	print("Add 20 seconds to the player!");
	Events.emit_signal("discount_points", prices["time_20"]);


func _on_btn_exit_pressed() -> void:
	Events.emit_signal("close_shop");
