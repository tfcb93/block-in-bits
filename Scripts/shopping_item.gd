extends VBoxContainer;

@onready var item_picture := $Picture;
@onready var item_name := $Name;
@onready var item_price := $Price;

func change_product_name(new_name: String) -> void:
	item_name.text = new_name;

func change_product_price(val: int) -> void:
	item_price.text = "%d bits" % val;
	
func change_product_picture(path: String) -> void:
	item_picture.texture_normal = load(path);
