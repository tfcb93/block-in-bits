extends CanvasLayer;

@onready var center_label := $"Center Label";
	
func _on_win() -> void:
	center_label.text = "YOU WIN";
	
func _on_lose() -> void:
	center_label.text = "YOU LOSE";
