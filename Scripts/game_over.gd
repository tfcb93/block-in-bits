extends Node2D;


func _ready() -> void:
	%interface.visible = false;

	Events.connect("game_over", _on_game_over);

func _on_game_over(points: int, depth: int, playtime: float) -> void:

	if (depth > Globals.high_depth_score):
		Globals.high_depth_score = depth;
		Events.emit_signal("config_change", "high_score", depth);
		%intf_record_label.visible = true;

	%interface.visible = true;
	%intf_points.text = str(points) + " points";
	%intf_depth.text = str(depth) + " meters";
	%intf_total_time.text = str(roundi(playtime)) + " seconds";
	%btn_exit.grab_focus();

func _on_btn_exit_pressed() -> void:
	%interface.visible = false;
	%intf_record_label.visible = false;
	Events.emit_signal("exit_level");
