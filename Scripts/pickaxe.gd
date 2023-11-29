extends Node2D;

# please save me

@export_category("pickaxe attr.")
@export var life := 100;
@export var qtd := 0;
@export_subgroup("actual pickaxe")
@export var type_name := "stone";
@export var used_life := 0;
@export_subgroup("against blocks")
@export var earth := 1;
@export var stone := 1;
@export var coal := 1;
@export var metal := 1;
@export var ruby := 1;
@export var emerald := 1;
@export var lava := 1;
@export var dark_matter := 1;
