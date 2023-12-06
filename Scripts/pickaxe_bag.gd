extends Node;

var actual_pickaxe: Node2D;
var actual_pickaxe_name: String;

var pickaxes: Array[Node] = [];
var pickaxe_quantities := {"water" = 1, "stone" = 1, "shovel" = 1};

func _ready() -> void:
	Events.connect("tap",_on_screen_tap);
	Events.connect("change_pickaxe_type",_on_change_pickaxe_type);
	
	pickaxes = get_children();
	
	var actual_pickaxes := pickaxe_quantities.keys();
	for pickaxe in actual_pickaxes:
		change_pickaxe_qtd(1, pickaxe)
	set_actual_pickaxe("stone");
	
	
func _on_screen_tap() -> void:
	if actual_pickaxe.qtd == 0:
		remove_pickaxe_qtd(actual_pickaxe.type_name);
		if pickaxe_quantities.is_empty():
			# game over
			return;
		_on_change_pickaxe_type("any");
	if actual_pickaxe.life <= 0:
		change_pickaxe_qtd(-1, actual_pickaxe.type_name);
		
			

func set_actual_pickaxe(type: String) -> void:
	for pickaxe in pickaxes:
		if pickaxe.type_name == type:
			actual_pickaxe = pickaxe;
			actual_pickaxe_name = pickaxe.type_name;
	Globals.actual_picaxe_type = actual_pickaxe.type_name
	Events.emit_signal("pickaxe_type_changed", actual_pickaxe_name);

func set_actual_pickaxe_damage(value: int) -> void:
	actual_pickaxe.life -= value;

func _on_change_pickaxe_type(dir: String) -> void:
	var actual_types:Array = pickaxe_quantities.keys();
	var actual_index := actual_types.find(actual_pickaxe_name);
	if dir == "any" or actual_index == -1:
		set_actual_pickaxe(actual_types[0]);
	if dir == "next":
		actual_index = -1 if actual_index + 1 >= len(actual_types) else actual_index;
		var new_type: String = actual_types[actual_index + 1];
		set_actual_pickaxe(new_type);
	else:
		var new_type:String = actual_types[actual_index - 1];
		set_actual_pickaxe(new_type);
		
func change_pickaxe_qtd(value: int, type: String) -> void:
	if pickaxe_quantities.find_key(type):
		pickaxe_quantities[type] += value;
	else:
		pickaxe_quantities[type] = value;

func remove_pickaxe_qtd(type: String) -> void:
	pickaxe_quantities.erase(type);
