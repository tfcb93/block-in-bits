extends Area2D;

var block_type: String = "earth";
var life := 1;

@onready var block_sprite := $Sprite2D;

func _ready() -> void:
	block_sprite.texture = CompressedTexture2D.new();
	block_sprite.texture = load("res://Resources/Images/" + block_type + ".png");
	set_life();

func set_life() -> void:
	match(block_type):
		"earth":
			life = 3;
		"stone":
			life = 10;
		"coal":
			life = 20;
		"metal":
			life = 50;
