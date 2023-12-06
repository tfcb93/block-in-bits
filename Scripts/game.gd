extends Node2D

@onready var counters_node := $Counters;
@onready var pickaxe_bag := $"Pickaxe Bag";
@onready var block_pile := $"Block Pile";

var counter_value := 0;

func _ready() -> void:
	counters_node.visible = false;
	var screensize := get_viewport_rect().size;

func _unhandled_input(event: InputEvent) -> void:
	if not Globals.game_stop:
		if event is InputEventScreenTouch and event.is_pressed():
			if not Globals.game_start:
				Globals.game_start = true;
				$"Start Screen".visible = false;
				counters_node.visible = true;
			else:
				Globals.total_taps += 1;
				block_tap_action();
				Events.emit_signal("tap");

# Do the calculations with the actual block and the actual pickaxe
func block_tap_action() -> void:
	var pickaxe_damage = pickaxe_bag.actual_pickaxe.block_types[Globals.actual_block_type];
	var block_damage = Globals.block_type_pickaxe_damages[Globals.actual_block_type][pickaxe_bag.actual_pickaxe.type_name];
	var block_points = Globals.block_type_pickaxe_points[Globals.actual_block_type][pickaxe_bag.actual_pickaxe.type_name];
	block_pile.set_actual_block_damage(pickaxe_damage);
	pickaxe_bag.set_actual_pickaxe_damage(block_damage);
	Globals.actual_block_points += block_points;
