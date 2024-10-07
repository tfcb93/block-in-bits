extends Node2D;

@export var player_tool: Tool;
@export var points := 0;


func _ready() -> void:
	
	Events.connect("earn_points", _on_earn_points);

	update_interface_values();
	update_interface_player_points();

func update_interface_values():
	update_interface_tool_resistence();

func update_interface_tool_resistence():
	%intf_tool_resistance.text = str(player_tool.resistance);

func update_interface_player_points():
	%intf_player_points.text = str(points);

func _on_earn_points(earned_points: int) -> void:
	points += earned_points;
	update_interface_player_points();
