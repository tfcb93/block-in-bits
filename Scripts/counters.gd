extends CanvasLayer;

@onready var counter_taps := $"VBoxContainer/Taps Container/HSplitContainer/Taps";
@onready var counter_blocks := $"VBoxContainer/Blocks Container/HSplitContainer2/Blocks";
@onready var counter_points := $"VBoxContainer/Points Container/HSplitContainer/Points";
@onready var next_level_points := $"VBoxContainer/Points Container/HSplitContainer/Next Level Points";

func _ready() -> void:
	next_level_points.text = str(Globals.next_checkpoint_points);
	Events.connect("next_level", _on_change_next_level);
	Events.connect("tap", _on_tap);
	
func _on_tap() -> void:
	counter_taps.text = str(Globals.total_taps);
	counter_blocks.text = str(Globals.total_blocks_destroyed);
	counter_points.text = str(Globals.total_player_points);

func _on_change_next_level() -> void:
	next_level_points.text = str(Globals.next_checkpoint_points);
