extends Area2D;

var block_type: String = "earth";
var life := 100;

@onready var block_sprite := $Sprite2D;

func _ready() -> void:
	block_sprite.texture = CompressedTexture2D.new();
	block_sprite.texture = load("res://Resources/Images/Blocks/" + block_type + ".png");
