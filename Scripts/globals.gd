extends Node

var total_blocks_destroyed := 0;
var total_taps := 0;


var game_stop := false;

var game_start := false;

const block_types := ["earth", "stone", "coal", "metal"];
const block_life := {"earth" = 3, "stone" = 10, "coal" = 20, "metal" = 50};

var actual_picaxe_type: String;
var actual_block_type: String;

var block_type_pickaxe_damages = {
	"earth" = {"shovel" = 1, "stone" = 1, "water" = 1, "steel" = 1},
	"stone" = {"shovel" = 1, "stone" = 3, "water" = 1, "steel" = 1},
	"coal" = {"shovel" = 1, "stone" = 5, "water" = 1, "steel" = 3},
	"metal" = {"shovel" = 1, "stone" = 10, "water" = 1, "steel" = 5},
}

var block_type_pickaxe_points = {
	"earth" = {"shovel" = 10, "stone" = 3, "water" = 0, "steel" = 1},
	"stone" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 1},
	"coal" = {"shovel" = 0, "stone" = 5, "water" = 0, "steel" = 10},
	"metal" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 10},
}

var total_player_points:int = 0;
var actual_block_points: int = 0;
var next_checkpoint_points: int = 1000;
