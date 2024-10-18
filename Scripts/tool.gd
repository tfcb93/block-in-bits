class_name Tool;
extends Resource;

@export var name: String;
@export var link_name: Globals.AVAILABLE_TOOLS; ## Choose which tool this is. Remember to insert for new tools in Globals
@export var resistance := 5;
@export var point_multiplier: int;