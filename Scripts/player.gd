extends Node2D;

@export var points := 0;

var player_tools: Array[Tool];
var selected_tool_index := 0;


func _ready() -> void:
	
	Events.connect("earn_points", _on_earn_points);
	Events.connect("depth_change", _on_depth_change);
	Events.connect("change_tool", _on_change_tool);

	Events.connect("pause_game", _on_pause_game);
	Events.connect("unpause_game", _on_unpause_game);

	load_player_tools();
	assert(len(player_tools) > 0, "You need to insert tools for the player!");

	update_interface_values();
	update_interface_tool_name();

func load_player_tools() -> void:
	var tools_files := DirAccess.open("res://Resources/tools").get_files();
	for file in tools_files:
		player_tools.push_back(load("res://Resources/tools/" + file));

func get_actual_player_tool() -> Tool:
	return player_tools[selected_tool_index];

func update_interface_values():
	update_interface_tool_resistence();
	update_interface_player_points();

func update_interface_tool_resistence() -> void:
	%intf_tool_resistance.text = str(player_tools[selected_tool_index].resistance);

func update_interface_tool_name() -> void:
	%intf_tool_name.text = player_tools[selected_tool_index].name;

func update_interface_player_points() -> void:
	%intf_player_points.text = str(points);


func _on_earn_points(earned_points: int) -> void:
	points += earned_points * player_tools[selected_tool_index].point_multiplier;
	update_interface_player_points();

func _on_depth_change(new_depth: int) -> void:
	%intf_depth.text = str(new_depth) + "m";

func _on_pause_game() -> void:
	%interface.visible = false;

func _on_unpause_game() -> void:
	%interface.visible = true;

func _on_change_tool(index_direction: int) -> void:
	if (index_direction + selected_tool_index >= len(player_tools)):
		selected_tool_index = 0;
	elif (index_direction + selected_tool_index < 0):
		selected_tool_index = len(player_tools) - 1;
	else:
		selected_tool_index += index_direction;
	update_interface_tool_name();
	update_interface_tool_resistence();