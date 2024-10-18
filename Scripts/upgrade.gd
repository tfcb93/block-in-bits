extends Resource;
class_name Upgrade;

@export var id: int;
@export var name: String;
@export var price: int;
@export var depth: int;
# Not the smartest way to organize an update for all tools, but it's what came for me
@export var effects := {Globals.AVAILABLE_TOOLS.PICKAXE: [], Globals.AVAILABLE_TOOLS.HAMMER: [], Globals.AVAILABLE_TOOLS.DRILL:[]}; ## Each too will have a pair [resistance, point multiplier]
