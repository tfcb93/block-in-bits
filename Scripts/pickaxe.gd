extends Node2D;

# please save me

@export_category("pickaxe attr.")
@export var life := 100;
@export var qtd := 0;
@export var type_name := "stone";
@export_subgroup("actual pickaxe")
@export var used_life := 0;
@export_subgroup("against blocks")
@export var block_types := {"earth" = 1, "stone" = 1, "coal" = 1, "metal" = 1, "ruby" = 1, "emerald" = 1, "lava" = 1, "dark_matter" = 1};
