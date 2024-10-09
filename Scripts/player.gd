extends Node2D;

@export var player_tool: Tool;
@export var points := 0;


func _ready() -> void:
	
	Events.connect("earn_points", _on_earn_points);
	Events.connect("depth_change", _on_depth_change);

	Events.connect("pause_game", _on_pause_game);
	Events.connect("unpause_game", _on_unpause_game);

	update_interface_values();

func update_interface_values():
	update_interface_tool_resistence();
	update_interface_player_points();

func update_interface_tool_resistence():
	%intf_tool_resistance.text = str(player_tool.resistance);

func update_interface_player_points():
	%intf_player_points.text = str(points);

func _on_earn_points(earned_points: int) -> void:
	points += earned_points * player_tool.point_multiplyer;
	update_interface_player_points();

func _on_depth_change(new_depth: int) -> void:
	%intf_depth.text = str(new_depth) + "m";

func _on_pause_game() -> void:
	%interface.visible = false;

func _on_unpause_game() -> void:
	%interface.visible = true;