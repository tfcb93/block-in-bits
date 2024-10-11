extends Node2D;

var prices := {"time_10": 1000, "time_20": 2000};
var actual_upgrade_index = 1;

func _ready() -> void:
	%interface.visible = false;
	
	Events.connect("open_shop", _on_open_shop);
	Events.connect("close_shop", _on_close_shop);
	Events.connect("inform_shop_data", inform_shop_data);

	update_upgrade_button();

func update_upgrade_button() -> void:
	if (actual_upgrade_index > len(Globals.upgrades) - 1):
		# there are no more upgrades
		update_empty_upgrade();
		return;
	var actual_upgrade: Upgrade = Globals.upgrades[actual_upgrade_index];
	%btn_upgrade.text = actual_upgrade.name;
	%price_upgrade.text = str(actual_upgrade.price) + " bits - " + str(actual_upgrade.depth) + "m";
	var description := "";
	for effect_index in range(1, len(actual_upgrade.effects)):
		description += Globals.available_tools_names[effect_index] + ": +" + str(actual_upgrade.effects[effect_index][0]) + " resistance & +" + str(actual_upgrade.effects[effect_index][1]) + " points multiplier\n"
	%intf_upgrade_description.text = description


func _on_open_shop() -> void:
	%interface.visible = true;
	Globals.game_state = Globals.GAME_STATES.IN_SHOP;


func _on_close_shop() -> void:
	%interface.visible = false;
	Globals.game_state = Globals.GAME_STATES.IN_GAME;

func inform_shop_data(player_points: int, depth: int) -> void:
	%intf_player_points.text = str(player_points);
	%btn_time_10.disabled = true if (prices["time_10"] > player_points) else false;
	%btn_time_20.disabled = true if (prices["time_20"] > player_points) else false;
	if (actual_upgrade_index > len(Globals.upgrades) - 1):
		update_empty_upgrade();
		return;
	var actual_upgrade:Upgrade = Globals.upgrades[actual_upgrade_index];
	%btn_upgrade.disabled = true if (actual_upgrade.price > player_points and actual_upgrade_index != -1 or depth < actual_upgrade.depth) else false;

func update_empty_upgrade() -> void:
	%btn_upgrade.disabled = true
	%btn_upgrade.text = "No more updates";
	%price_upgrade.text = "No price to display";
	%intf_upgrade_description.text = "That's it\nYou did it!"

func _on_btn_upgrade_pressed() -> void:
	var clicked_update_price:int = Globals.upgrades[actual_upgrade_index].price; # had to do that, otherwise I need to remove the data update from discount price and create another signal for the player to update data after the index is updated
	Events.emit_signal("upgrade_tools", Globals.upgrades[actual_upgrade_index]);
	actual_upgrade_index += 1;
	Events.emit_signal("discount_points", clicked_update_price);
	update_upgrade_button();


func _on_btn_time_10_pressed() -> void:
	Events.emit_signal("add_time", 10);
	Events.emit_signal("discount_points", prices["time_10"]);


func _on_btn_time_20_pressed() -> void:
	Events.emit_signal("add_time", 20);
	Events.emit_signal("discount_points", prices["time_20"]);


func _on_btn_exit_pressed() -> void:
	Events.emit_signal("close_shop");
