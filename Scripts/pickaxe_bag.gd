extends Node;

var actual_pickaxe_name: String;

var pickaxe_quantities := {"water" = 0, "stone" = 0, "shovel" = 0, "steel" = 0};
var pickaxe_actual_lives := {};

func _ready() -> void:
	Events.connect("tap",_on_screen_tap);
	Events.connect("change_pickaxe_type",_on_change_pickaxe_type);
	Events.connect("bought_pickaxe", _on_bought_pickaxe);
	
	var actual_pickaxes := pickaxe_quantities.keys();
	for pickaxe in actual_pickaxes:
		change_pickaxe_qtd(1, pickaxe)
		pickaxe_actual_lives[pickaxe] = Globals.pickaxe_information[pickaxe].life_at_start;
	print(pickaxe_actual_lives);
	set_actual_pickaxe("shovel");
	
	
func _on_screen_tap() -> void:
	print(pickaxe_actual_lives[actual_pickaxe_name]);
	if pickaxe_actual_lives[actual_pickaxe_name] <= 0:
		change_pickaxe_qtd(-1, actual_pickaxe_name);
		if not pickaxe_quantities[actual_pickaxe_name] == 0:
			pickaxe_actual_lives[actual_pickaxe_name] = Globals.pickaxe_information[actual_pickaxe_name].life_at_start;
	if pickaxe_quantities[actual_pickaxe_name] == 0:
		remove_pickaxe_qtd(actual_pickaxe_name);
		if pickaxe_quantities.is_empty():
			Globals.game_stop = true;
			Events.emit_signal("finish");
			return;
		_on_change_pickaxe_type("any");

func set_actual_pickaxe(type: String) -> void:
	actual_pickaxe_name = type;
	Globals.actual_picaxe_type = actual_pickaxe_name
	Events.emit_signal("pickaxe_type_changed", actual_pickaxe_name);

func set_actual_pickaxe_damage(value: int) -> void:
	pickaxe_actual_lives[actual_pickaxe_name] -= value;

func _on_change_pickaxe_type(dir: String) -> void:
	var actual_types:Array = pickaxe_quantities.keys();
	var actual_index := actual_types.find(actual_pickaxe_name);
	if dir == "any" or actual_index == -1:
		set_actual_pickaxe(actual_types[0]);
		return;
	if dir == "next":
		actual_index = -1 if actual_index + 1 >= len(actual_types) else actual_index;
		var new_type: String = actual_types[actual_index + 1];
		set_actual_pickaxe(new_type);
	else:
		var new_type:String = actual_types[actual_index - 1];
		set_actual_pickaxe(new_type);

func _on_bought_pickaxe(type: String) -> void:
	change_pickaxe_qtd(1, type);

func change_pickaxe_qtd(value: int, type: String) -> void:
	
	if pickaxe_quantities.get(type) != null:
		pickaxe_quantities[type] += value;
		print("this is the actual pickaxe %s value: %d" % [type, pickaxe_quantities[type]]);
	else:
		print("new pickaxe %s" % type);
		pickaxe_actual_lives[type] = Globals.pickaxe_information[type].life_at_start;
		pickaxe_quantities[type] = value;

func remove_pickaxe_qtd(type: String) -> void:
	print("pickaxe removed");
	pickaxe_quantities.erase(type);
