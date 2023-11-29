extends Node

var total_blocks_destroyed := 0;
var total_taps := 0;


var game_stop := false;

var game_start := false;

const block_types := ["earth", "stone", "coal", "metal"];
const block_life := {"earth" = 3, "stone" = 10, "coal" = 20, "metal" = 50};
