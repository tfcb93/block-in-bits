extends Node2D;

var prices := {"time_10": 1000, "time_20": 2000};
var actual_upgrade_index = 1;
var actual_upgrade_price = 0;

func _ready() -> void:
	%interface.visible = false;
	
	Events.connect("open_shop", _on_open_shop);
	Events.connect("close_shop", _on_close_shop);
	Events.connect("inform_shop_player_points", _on_inform_shop_player_points);

	update_upgrade_button();

func update_upgrade_button() -> void:
	if (actual_upgrade_index > len(Globals.upgrades) - 1):
		# there are no more upgrades
		actual_upgrade_price = -1; # keep button disabled
		%btn_upgrade.disabled = true
		%btn_upgrade.text = "No more updates";
		%price_upgrade.text = "No price to display";
		%intf_upgrade_description.text = "That's it\nYou did it!"
		return;
	var actual_upgrade: Upgrade = Globals.upgrades[actual_upgrade_index];
	actual_upgrade_price = actual_upgrade.price;
	%btn_upgrade.text = actual_upgrade.name;
	%price_upgrade.text = str(actual_upgrade.price) + " bits";
	var description := "";
	for effect_index in range(0, len(actual_upgrade.effects)):
		description += Globals.available_tools_names[effect_index] + ": +" + str(actual_upgrade.effects[effect_index][0]) + " resistance & +" + str(actual_upgrade.effects[effect_index][1]) + " points multiplier\n"
	%intf_upgrade_description.text = description


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
	%btn_upgrade.disabled = true if (actual_upgrade_price > player_points and actual_upgrade_index != -1) else false;

func _on_btn_upgrade_pressed() -> void:
	Events.emit_signal("upgrade_tools", Globals.upgrades[actual_upgrade_index]);
	actual_upgrade_index += 1;
	update_upgrade_button();


func _on_btn_time_10_pressed() -> void:
	Events.emit_signal("add_time", 10);
	Events.emit_signal("discount_points", prices["time_10"]);


func _on_btn_time_20_pressed() -> void:
	Events.emit_signal("add_time", 20);
	Events.emit_signal("discount_points", prices["time_20"]);


func _on_btn_exit_pressed() -> void:
	Events.emit_signal("close_shop");
