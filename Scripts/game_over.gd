extends Node2D;


func _ready() -> void:
	%interface.visible = false;

	Events.connect("game_over", _on_game_over);

func _on_game_over(points: int, depth: int, playtime: float) -> void:
	%interface.visible = true;
	%intf_points.text = str(points) + " points";
	%intf_depth.text = str(depth) + " meters";
	%intf_total_time.text = str(roundi(playtime)) + " seconds";

func _on_btn_exit_pressed() -> void:
	%interface.visible = false;
	Events.emit_signal("exit_level");