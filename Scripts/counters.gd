extends CanvasLayer;

@onready var counter_taps := $"VBoxContainer/Taps Container/HSplitContainer/Taps";
@onready var counter_blocks := $"VBoxContainer/Blocks Container/HSplitContainer2/Blocks";

func _ready() -> void:
	Events.connect("tap", _on_tap);
	
func _on_tap() -> void:
	counter_taps.text = str(Globals.total_taps);
	counter_blocks.text = str(Globals.total_blocks_destroyed);
