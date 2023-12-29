extends CanvasLayer;

@onready var items := $items;

var item := preload("res://Scenes/shopping_item.tscn");


func _ready() -> void:
	visible = false;
	for pickaxe in BAP.pickaxe_information:
		var pickaxe_data = BAP.pickaxe_information[pickaxe];
		var new_item := item.instantiate();
		items.add_child(new_item);
		new_item.item_id = pickaxe_data.id;
		new_item.change_product_name(pickaxe_data.name);
		new_item.change_product_price(pickaxe_data.price);
		new_item.change_product_picture("res://Resources/Images/Pickaxes/%s.png" % pickaxe_data.image_name);
		
	Events.connect("open_shop", _on_shopping_open);
	
func _on_shopping_open() -> void:
	visible = true;
	Globals.game_stop = true;


func _on_close_button_down() -> void:
	Globals.game_stop = false;
	visible = false;
	Events.emit_signal("close_shop");
