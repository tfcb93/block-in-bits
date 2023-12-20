extends Node2D

@onready var counters_node := $Counters;
@onready var pickaxe_bag := $"Pickaxe Bag";
@onready var block_pile := $"Block Pile";
@onready var selector := $Selector;
@onready var game_over_screen := $"Game Over";
@onready var shop_button := $Button;

var counter_value := 0;

func _ready() -> void:
	counters_node.visible = false;
	game_over_screen.visible = false;
	selector.visible = false;
	shop_button.visible = false;
	var screensize := get_viewport_rect().size;
	
	Events.connect("discount_bits", _on_bought_item);
	Events.connect("add_bits", _on_add_bits);

func _unhandled_input(event: InputEvent) -> void:
	if not Globals.game_stop:
		if event is InputEventScreenTouch and event.is_pressed():
			if not Globals.game_start:
				Globals.game_start = true;
				$"Start Screen".visible = false;
				counters_node.visible = true;
				selector.visible = true;
				shop_button.visible = true;
			else:
				Globals.total_taps += 1;
				block_tap_action();
				Events.emit_signal("tap");

# Do the calculations with the actual block and the actual pickaxe
func block_tap_action() -> void:
	var pickaxe_damage = Globals.pickaxe_type_damages[pickaxe_bag.actual_pickaxe_name][Globals.actual_block_type];
	var block_damage = Globals.block_type_pickaxe_damages[Globals.actual_block_type][pickaxe_bag.actual_pickaxe_name];
	var block_points = Globals.block_type_pickaxe_points[Globals.actual_block_type][pickaxe_bag.actual_pickaxe_name];
	block_pile.set_actual_block_damage(pickaxe_damage);
	pickaxe_bag.set_actual_pickaxe_damage(block_damage);
	Globals.actual_block_points += block_points;


func _on_button_button_down() -> void:
	Events.emit_signal("open_shopping");
	
func _on_bought_item(value: int) -> void:
	Globals.total_player_points -= value;
	Events.emit_signal("bits_discounted");
	print(Globals.total_player_points);
	
func _on_add_bits() -> void:
	Globals.total_player_points += Globals.actual_block_points;
