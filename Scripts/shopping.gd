extends CanvasLayer;

@onready var items := $items;

var item := preload("res://Scenes/shopping_item.tscn");


func _ready() -> void:
	for pickaxe in Globals.pickaxe_information:
		print(Globals.pickaxe_information[pickaxe].name);
		var new_item := item.instantiate();
		items.add_child(new_item);
		new_item.change_product_name(Globals.pickaxe_information[pickaxe].name);
		new_item.change_product_price(Globals.pickaxe_information[pickaxe].price);
