extends VBoxContainer;

@onready var actual_label := $"Actual Pickaxe Label";
@onready var actual_qtd := $"HBoxContainer/Total pickaxes";
@onready var actual_life := $HBoxContainer/Life;

func _ready() -> void:
	Events.connect("pickaxe_type_changed", _on_change_pickaxe_type);
	Events.connect("tap", _on_tap);
	actual_label.text = Globals.actual_picaxe_type;
	actual_life.text = str(Globals.actual_picaxe_life);
	actual_qtd.text = str(Globals.actual_picaxe_qtd);

func _on_change_pickaxe_type(type: String) -> void:
	actual_label.text = type;

func _on_shop_button_down() -> void:
	Events.emit_signal("open_shop");

func _on_change_pickaxe_button_down() -> void:
	Events.emit_signal("change_pickaxe_type", "next");

func _on_tap() -> void:
	actual_life.text = str(Globals.actual_picaxe_life);
	actual_qtd.text = str(Globals.actual_picaxe_qtd);
