extends VBoxContainer;

@onready var item_picture := $Picture;
@onready var item_name := $Name;
@onready var item_price := $Price;
@onready var item_buy_button := $Button;

var price := 0;
var item_id := "";

func _ready() -> void:
	Events.connect("bits_discounted", _on_discounted_bits);
	Events.connect("open_shop", _on_shopping_open);

func change_product_name(new_name: String) -> void:
	item_name.text = new_name;

func change_product_price(val: int) -> void:
	price = val;
	item_price.text = "%d bits" % val;
	
func change_product_picture(path: String) -> void:
	item_picture.texture = load(path);

func _on_shopping_open() -> void:
	check_item_price_and_player_points();

func _on_discounted_bits() -> void:
	check_item_price_and_player_points();

func check_item_price_and_player_points() -> void:
	if Globals.total_player_points < price:
		item_buy_button.disabled = true;
	else:
		item_buy_button.disabled = false;


func _on_button_button_down() -> void:
	Events.emit_signal("discount_bits", price);
	Events.emit_signal("bought_pickaxe", item_id);
