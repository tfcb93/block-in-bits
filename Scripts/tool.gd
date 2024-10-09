class_name Tool;
extends Resource;

@export var name: String;
@export var resistance := 5;
@export_range(1, 10, 1) var point_multiplyer: int;