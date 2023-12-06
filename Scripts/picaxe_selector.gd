extends CanvasLayer;

@onready var actual_label := $HBoxContainer/Actual;

func _ready() -> void:
	Events.connect("pickaxe_type_changed", _on_change_pickaxe_type);
	print(Globals.actual_picaxe_type)
	actual_label.text = Globals.actual_picaxe_type;

func _on_change_pickaxe_type(type: String) -> void:
		actual_label.text = type;

func _on_next_button_down() -> void:
	Events.emit_signal("change_pickaxe_type", "next");


func _on_previous_button_down() -> void:
	Events.emit_signal("change_pickaxe_type", "previous");
