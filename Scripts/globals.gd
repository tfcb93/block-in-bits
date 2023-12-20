extends Node

var total_blocks_destroyed := 0;
var total_taps := 0;


var game_stop := false;

var game_start := false;

const block_types := ["earth", "sand", "stone", "coal", "metal"];
const block_life := {"earth" = 3, "stone" = 10, "coal" = 20, "metal" = 50};

var actual_picaxe_type: String;
var actual_block_type: String;

# damage a block give to a pickaxe
var block_type_pickaxe_damages = {
	"earth" = {"shovel" = 5, "stone" = 2, "water" = 100, "steel" = 2, "blower" = 0, "drill" = 2, "hammer" = 2, "rubber" = 3, "scissors" = 1, "screw" = 1, "silk" = 20, "super" = 0},
	"sand" = {"shovel" = 7, "stone" = 5, "water" = 100, "steel" = 5, "blower" = 0, "drill" = 2, "hammer" = 2, "rubber" = 3, "scissors" = 1, "screw" = 1, "silk" = 20, "super" = 0},
	"stone" = {"shovel" = 50, "stone" = 5, "water" = 100, "steel" = 3, "blower" = 0, "drill" = 2, "hammer" = 10, "rubber" = 12, "scissors" = 50, "screw" = 50, "silk" = 50, "super" = 1},
	"coal" = {"shovel" = 50, "stone" = 5, "water" = 100, "steel" = 3, "blower" = 0, "drill" = 2, "hammer" = 10, "rubber" = 12, "scissors" = 50, "screw" = 50, "silk" = 50, "super" = 1},
	"metal" = {"shovel" = 100, "stone" = 10, "water" = 100, "steel" = 5, "blower" = 0, "drill" = 5, "hammer" = 20, "rubber" = 0, "scissors" = 100, "screw" = 100, "silk" = 50, "super" = 1},
	"concrete" = {"shovel" = 100, "stone" = 10, "water" = 100, "steel" = 5, "blower" = 0, "drill" = 2, "hammer" = 15, "rubber" = 0, "scissors" = 100, "screw" = 100, "silk" = 100, "super" = 1},
	"copper" = {"shovel" = 100, "stone" = 10, "water" = 100, "steel" = 5, "blower" = 0, "drill" = 5, "hammer" = 10, "rubber" = 0, "scissors" = 90, "screw" = 90, "silk" = 100, "super" = 1},
	"diamond" = {"shovel" = 100, "stone" = 100, "water" = 100, "steel" = 100, "blower" = 0, "drill" = 100, "hammer" = 100, "rubber" = 0, "scissors" = 100, "screw" = 100, "silk" = 100, "super" = 10},
	"dust" = {"shovel" = 0, "stone" = 0, "water" = 100, "steel" = 0, "blower" = 10, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"electrical" = {"shovel" = 100, "stone" = 100, "water" = 100, "steel" = 500, "blower" = 0, "drill" = 300, "hammer" = 100, "rubber" = 10, "scissors" = 100, "screw" = 100, "silk" = 100, "super" = 1},
	"gold" = {"shovel" = 100, "stone" = 10, "water" = 100, "steel" = 5, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 1},
	"mechanical" = {"shovel" = 100, "stone" = 10, "water" = 100, "steel" = 5, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 1},
	"plastic" = {"shovel" = 100, "stone" = 10, "water" = 100, "steel" = 5, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 1},
	"quartz" = {"shovel" = 100, "stone" = 10, "water" = 100, "steel" = 5, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 1},
	"sapphire" = {"shovel" = 100, "stone" = 10, "water" = 100, "steel" = 5, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 1},
	"silver" = {"shovel" = 100, "stone" = 10, "water" = 100, "steel" = 5, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 1},
	"lava" = {"shovel" = 100, "stone" = 100, "water" = 100, "steel" = 500, "blower" = 0, "drill" = 300, "hammer" = 100, "rubber" = 100, "scissors" = 100, "screw" = 100, "silk" = 100, "super" = 1000},
	"dark_matter" = {"shovel" = 100, "stone" = 100, "water" = 100, "steel" = 500, "blower" = 0, "drill" = 300, "hammer" = 100, "rubber" = 100, "scissors" = 100, "screw" = 100, "silk" = 100, "super" = 1000},
}

# points given to each pickaxe smash for a block
var block_type_pickaxe_points = {
	"earth" = {"shovel" = 35, "stone" = 5, "water" = 0, "steel" = 5, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"sand" = {"shovel" = 35, "stone" = 5, "water" = 0, "steel" = 5, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"stone" = {"shovel" = 1, "stone" = 10, "water" = 0, "steel" = 8, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"coal" = {"shovel" = 1, "stone" = 10, "water" = 0, "steel" = 8, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"metal" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"concrete" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"copper" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"diamond" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"dust" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"electrical" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"gold" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"mechanical" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"plastic" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"quartz" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"sapphire" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"silver" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"lava" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
	"dark_matter" = {"shovel" = 0, "stone" = 3, "water" = 0, "steel" = 20, "blower" = 0, "drill" = 0, "hammer" = 0, "rubber" = 0, "scissors" = 0, "screw" = 0, "silk" = 0, "super" = 0},
}

# damage a pickaxe gives to a block
var pickaxe_type_damages = {
	"shovel" = {"earth" = 100, "sand" = 100, "stone" = 10, "coal" = 10, "metal" = 0, "ruby" = 0, "emerald" = 0, "lava" = 0, "dark_matter" = 0, "concrete" = 0, "copper" = 0, "diamond" = 0, "dust" = 0, "electrical" = 0, "gold" = 0, "mechanical" = 0, "plastic" = 0, "quartz" = 0, "sapphire" = 0, "silver" = 0,},
	"water" = {"earth" = 0, "sand" = 0, "stone" = 0, "coal" = 0, "metal" = 0, "ruby" = 0, "emerald" = 0, "lava" = 100, "dark_matter" = 0, "concrete" = 0, "copper" = 0, "diamond" = 0, "dust" = 0, "electrical" = 0, "gold" = 0, "mechanical" = 0, "plastic" = 0, "quartz" = 0, "sapphire" = 0, "silver" = 0,},
	"stone" = {"earth" = 30, "sand" = 25, "stone" = 30, "coal" = 40, "metal" = 3, "ruby" = 1, "emerald" = 1, "lava" = 0, "dark_matter" = 0, "concrete" = 0, "copper" = 0, "diamond" = 0, "dust" = 0, "electrical" = 0, "gold" = 0, "mechanical" = 0, "plastic" = 0, "quartz" = 0, "sapphire" = 0, "silver" = 0,},
	"steel" = {"earth" = 30, "sand" = 25, "stone" = 30, "coal" = 40, "metal" = 20, "ruby" = 10, "emerald" = 10, "lava" = 0, "dark_matter" = 0, "concrete" = 0, "copper" = 0, "diamond" = 0, "dust" = 0, "electrical" = 0, "gold" = 0, "mechanical" = 0, "plastic" = 0, "quartz" = 0, "sapphire" = 0, "silver" = 0,},
	"blower" = {"earth" = 30, "sand" = 25, "stone" = 30, "coal" = 40, "metal" = 20, "ruby" = 10, "emerald" = 10, "lava" = 0, "dark_matter" = 0, "concrete" = 0, "copper" = 0, "diamond" = 0, "dust" = 0, "electrical" = 0, "gold" = 0, "mechanical" = 0, "plastic" = 0, "quartz" = 0, "sapphire" = 0, "silver" = 0,},
	"drill" = {"earth" = 30, "sand" = 25, "stone" = 30, "coal" = 40, "metal" = 20, "ruby" = 10, "emerald" = 10, "lava" = 0, "dark_matter" = 0, "concrete" = 0, "copper" = 0, "diamond" = 0, "dust" = 0, "electrical" = 0, "gold" = 0, "mechanical" = 0, "plastic" = 0, "quartz" = 0, "sapphire" = 0, "silver" = 0,},
	"hammer" = {"earth" = 30, "sand" = 25, "stone" = 30, "coal" = 40, "metal" = 20, "ruby" = 10, "emerald" = 10, "lava" = 0, "dark_matter" = 0, "concrete" = 0, "copper" = 0, "diamond" = 0, "dust" = 0, "electrical" = 0, "gold" = 0, "mechanical" = 0, "plastic" = 0, "quartz" = 0, "sapphire" = 0, "silver" = 0,},
	"rubber" = {"earth" = 30, "sand" = 25, "stone" = 30, "coal" = 40, "metal" = 20, "ruby" = 10, "emerald" = 10, "lava" = 0, "dark_matter" = 0, "concrete" = 0, "copper" = 0, "diamond" = 0, "dust" = 0, "electrical" = 0, "gold" = 0, "mechanical" = 0, "plastic" = 0, "quartz" = 0, "sapphire" = 0, "silver" = 0,},
	"scissors" = {"earth" = 30, "sand" = 25, "stone" = 30, "coal" = 40, "metal" = 20, "ruby" = 10, "emerald" = 10, "lava" = 0, "dark_matter" = 0, "concrete" = 0, "copper" = 0, "diamond" = 0, "dust" = 0, "electrical" = 0, "gold" = 0, "mechanical" = 0, "plastic" = 0, "quartz" = 0, "sapphire" = 0, "silver" = 0,},
	"screw" = {"earth" = 30, "sand" = 25, "stone" = 30, "coal" = 40, "metal" = 20, "ruby" = 10, "emerald" = 10, "lava" = 0, "dark_matter" = 0, "concrete" = 0, "copper" = 0, "diamond" = 0, "dust" = 0, "electrical" = 0, "gold" = 0, "mechanical" = 0, "plastic" = 0, "quartz" = 0, "sapphire" = 0, "silver" = 0,},
	"silk" = {"earth" = 30, "sand" = 25, "stone" = 30, "coal" = 40, "metal" = 20, "ruby" = 10, "emerald" = 10, "lava" = 0, "dark_matter" = 0, "concrete" = 0, "copper" = 0, "diamond" = 0, "dust" = 0, "electrical" = 0, "gold" = 0, "mechanical" = 0, "plastic" = 0, "quartz" = 0, "sapphire" = 0, "silver" = 0,},
	"super" = {"earth" = 30, "sand" = 25, "stone" = 30, "coal" = 40, "metal" = 20, "ruby" = 10, "emerald" = 10, "lava" = 0, "dark_matter" = 0, "concrete" = 0, "copper" = 0, "diamond" = 0, "dust" = 0, "electrical" = 0, "gold" = 0, "mechanical" = 0, "plastic" = 0, "quartz" = 0, "sapphire" = 0, "silver" = 0,},
}

var pickaxe_information = {
	"shovel" = {"id"= "shovel", "name" = "shovel", "image_name" = "shovel", "price" = 100, "life_at_start" = 100}, 
	"water" = {"id"= "water", "name" = "water bucket", "image_name" = "water", "price" = 100, "life_at_start" = 1},
	"steel" = {"id"= "steel", "name" = "steel pickaxe", "image_name" = "steel", "price" = 1000, "life_at_start" = 500},
	"stone" = {"id"= "stone", "name" = "stone pickaxe", "image_name" = "stone", "price" = 300, "life_at_start" = 100},
	"blower" = {"id"= "blower", "name" = "air blower", "image_name" = "air-blower", "price" = 150, "life_at_start" = 50},
	"drill" = {"id"= "drill", "name" = "drill", "image_name" = "drill", "price" = 600, "life_at_start" = 300},
	"hammer" = {"id"= "hammer", "name" = "hammer", "image_name" = "hammer", "price" = 200, "life_at_start" = 10},
	"rubber" = {"id"= "rubber", "name" = "rubber", "image_name" = "rubber-pickaxe", "price" = 200, "life_at_start" = 60},
	"scissors" = {"id"= "scissors", "name" = "scissors", "image_name" = "scissors", "price" = 100, "life_at_start" = 10},
	"screw" = {"id"= "screw", "name" = "screw driver", "image_name" = "screw-driver", "price" = 100, "life_at_start" = 20},
	"silk" = {"id"= "silk", "name" = "silk pickaxe", "image_name" = "silk-pickaxe", "price" = 500, "life_at_start" = 10},
	"super" = {"id"= "super", "name" = "super pickaxe", "image_name" = "super-pickaxe", "price" = 10000, "life_at_start" = 1000},
}

var total_player_points:int = 0;
var actual_block_points: int = 0;
var next_checkpoint_points: int = 1000;
