extends Node;

var actual_pickaxe: Node2D;

var pickaxes: Array[Node] = [];
var starter_types := ["water", "stone", "shovel"];

func _ready() -> void:
	Events.connect("tap",_on_screen_tap);
	Events.connect("change_pickaxe_type",_on_change_pickaxe_type);
	
	pickaxes = get_children();
	
	for pickaxe in pickaxes:
		if starter_types.find(pickaxe.type_name) != -1:
			pickaxe.qtd = 1;
	set_actual_pickaxe("stone");
	
	
func _on_screen_tap() -> void:
	if actual_pickaxe.qtd == 0:
		Globals.actual_pickaxe_available = false;
	if actual_pickaxe.life <= 0:
		actual_pickaxe.qtd -= 1;
		
			

func set_actual_pickaxe(type: String) -> void:
	for pickaxe in pickaxes:
		if pickaxe.type_name == type:
			actual_pickaxe = pickaxe;
	Globals.actual_picaxe_type = actual_pickaxe.type_name
	Events.emit_signal("pickaxe_type_changed");

func set_actual_pickaxe_damage(value: int) -> void:
	actual_pickaxe.life -= value;

func _on_change_pickaxe_type(dir: String) -> void:
	var actual_index := pickaxes.find(actual_pickaxe);
	if dir == "next":
		var new_type := pickaxes[actual_index + 1];
		actual_index = 0 if actual_index >= len(pickaxes) else actual_index;
		set_actual_pickaxe(new_type.type_name);
	else:
		var new_type := pickaxes[actual_index - 1];
		actual_index = len(pickaxes) - 1 if actual_index < -1 else actual_index;
		set_actual_pickaxe(new_type.type_name);
