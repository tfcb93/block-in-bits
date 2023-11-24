extends CanvasLayer;

@onready var center_label := $"Center Label";

func _ready() -> void:
	Events.connect("win", _on_win);
	
func _on_win() -> void:
	center_label.text = "YOU WIN";
	
func _on_lose() -> void:
	center_label.text = "YOU LOSE";
