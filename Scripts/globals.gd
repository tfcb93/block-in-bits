extends Node

var total_blocks_destroyed := 0;
var total_taps := 0;


var game_stop := false;

var game_start := false;

const block_types := ["earth", "sand", "stone", "coal", "metal"];
const block_life := {"earth" = 3, "stone" = 10, "coal" = 20, "metal" = 50};

var actual_picaxe_type: String;
var actual_picaxe_life: int;
var actual_picaxe_qtd: int;
var actual_block_type: String;

var total_player_points:int = 0;
var actual_block_points: int = 0;
var next_checkpoint_points: int = 1000;
