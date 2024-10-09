class_name Tool;
extends Resource;

@export var name: String;
@export_range(10, 100, 1) var resistance := 10;
@export_range(1, 10, 1) var point_multiplyer: int;