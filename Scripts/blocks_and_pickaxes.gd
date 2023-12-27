extends Node;

# Information about the block.
# point_status is the status against a pickaxe. It's an array of 3 numbers, those are, in order
# damage caused to the block, damage caused to the pickaxe, points given for it.
# Each of those are applicable by tap.
# "MAX" means that a tap will destroy the pickaxe/item.

# for now, all blocks has 100 of life
var blocks_info = {
	"earth" = {
		"id" = 0,
		"wettable" = false,
		"point_status" = {
			"shovel" = [100, 10, 30], "stone" = [30, 3, 5], "water" = [0, "MAX", 0], "steel" = [30, 3, 5], "blower" = [0, 0, 0], "drill" = [40, 2, 2], "hammer" = [20, 3, 5], "rubber" = [1, 5, 0], "scissors" = [1, 5, 0], "screw" = [1, 5, 0], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"sand" = {
		"id" = 1,
		"wettable" = false,
		"point_status" = {
			"shovel" = [100, 10, 30], "stone" = [30, 3, 5], "water" = [0, "MAX", 0], "steel" = [30, 3, 5], "blower" = [0, 0, 0], "drill" = [40, 2, 2], "hammer" = [20, 3, 5], "rubber" = [1, 5, 0], "scissors" = [1, 5, 0], "screw" = [1, 5, 0], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"stone" = {
		"id" = 2,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, 30, 0], "stone" = [10, 10, 5], "water" = [0, "MAX", 0], "steel" = [30, 5, 10], "blower" = [0, 0, 0], "drill" = [50, 5, 10], "hammer" = [10, 5, 2], "rubber" = [0, 5, 0], "scissors" = [1, "MAX", 0], "screw" = [1, "MAX", 0], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"coal" = {
		"id" = 3,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, 30, 0], "stone" = [10, 8, 8], "water" = [0, "MAX", 0], "steel" = [40, 3, 12], "blower" = [0, 0, 0], "drill" = [60, 3, 12], "hammer" = [10, 5, 2], "rubber" = [0, 5, 0], "scissors" = [1, "MAX", 0], "screw" = [1, "MAX", 0], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"metal" = {
		"id" = 4,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, "MAX", 0], "stone" = [2, 50, 1], "water" = [0, "MAX", 0], "steel" = [20, 20, 5], "blower" = [0, 0 ,0], "drill" = [30, 20, 8], "hammer" = [5, 5, 1], "rubber" = [0, 5, 0], "scissors" = [1, 10, 1], "screw" = [1, 10, 1], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"gold" = {
		"id" = 10,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, "MAX", 0], "stone" = [2, 50, 10], "water" = [0, "MAX", 0], "steel" = [20, 20, 50], "blower" = [0, 0 ,0], "drill" = [30, 20, 80], "hammer" = [5, 5, 10], "rubber" = [0, 5, 0], "scissors" = [1, 10, 10], "screw" = [1, 10, 10], "silk" = [100, "MAX", 1000], "super" = [100, 1, 1000]
		}
	},
	"silver" = {
		"id" = 15,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, "MAX", 0], "stone" = [2, 50, 5], "water" = [0, "MAX", 0], "steel" = [20, 20, 25], "blower" = [0, 0 ,0], "drill" = [30, 20, 40], "hammer" = [5, 5, 5], "rubber" = [0, 5, 0], "scissors" = [1, 10, 5], "screw" = [1, 10, 5], "silk" = [100, "MAX", 500], "super" = [100, 1, 500]
		}
	},
	"copper" = {
		"id" = 6,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, "MAX", 0], "stone" = [2, 50, 3], "water" = [0, "MAX", 0], "steel" = [20, 20, 15], "blower" = [0, 0 ,0], "drill" = [30, 20, 24], "hammer" = [5, 5, 3], "rubber" = [0, 5, 0], "scissors" = [1, 10, 3], "screw" = [1, 10, 3], "silk" = [100, "MAX", 300], "super" = [100, 1, 300]
		}
	},
	"quartz" = {
		"id" = 13,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, "MAX", 0], "stone" = [5, 10, 5], "water" = [0, "MAX", 0], "steel" = [20, 10, 5], "blower" = [0, 0, 0], "drill" = [30, 5, 5], "hammer" = [5, 10, 5], "rubber" = [1, 2, 0], "scissors" = [1, 50, 1], "screw" = [1, 50, 1], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"emerald" = {
		"id" = 19,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, "MAX", 0], "stone" = [5, 20, 10], "water" = [0, "MAX", 0], "steel" = [20, 10, 10], "blower" = [0, 0, 0], "drill" = [30, 5, 15], "hammer" = [5, 10, 10], "rubber" = [1, 2, 0], "scissors" = [1, 50, 1], "screw" = [1, 50, 1], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"ruby" = {
		"id" = 18,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, "MAX", 0], "stone" = [5, 30, 15], "water" = [0, "MAX", 0], "steel" = [20, 10, 15], "blower" = [0, 0, 0], "drill" = [30, 5, 20], "hammer" = [5, 10, 15], "rubber" = [1, 2, 0], "scissors" = [1, 50, 1], "screw" = [1, 50, 1], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"sapphire" = {
		"id" = 14,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, "MAX", 0], "stone" = [5, 50, 30], "water" = [0, "MAX", 0], "steel" = [20, 10, 30], "blower" = [0, 0, 0], "drill" = [30, 5, 30], "hammer" = [5, 10, 20], "rubber" = [1, 2, 0], "scissors" = [1, 50, 1], "screw" = [1, 50, 1], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"diamond" = {
		"id" = 7,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, "MAX", 0], "stone" = [0, "MAX", 0], "water" = [0, "MAX", 0], "steel" = [1, "MAX", 1], "blower" = [0, "MAX", 0], "drill" = [0, "MAX", 0], "hammer" = [0, "MAX", 0], "rubber" = [0, "MAX", 0], "scissors" = [0, "MAX", 0], "screw" = [0, "MAX", 0], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"concrete" = {
		"id" = 5,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, 10, 0], "stone" = [2, 10, 1], "water" = [0, "MAX", 0], "steel" = [10, 5, 5], "blower" = [0, 0, 0], "drill" = [20, 5, 5], "hammer" = [1, 3, 1], "rubber" = [0, 2, 0], "scissors" = [0, "MAX", 0], "screw" = [0, "MAX", 0], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"dust" = {
		"id" = 8,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, 0, 0], "stone" = [0, 0, 0], "water" = [0, "MAX", 0], "steel" = [0, 0, 0], "blower" = [100, 10, 50], "drill" = [0, 0, 0], "hammer" = [0, 0, 0], "rubber" = [0, 0, 0], "scissors" = [0, 0, 0], "screw" = [0, 0, 0], "silk" = [0, 0, 0], "super" = [100, 1, 100]
		}
	},
	"electrical" = {
		"id" = 9,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, "MAX", 0], "stone" = [0, "MAX", 0], "water" = [0, "MAX", 0], "steel" = [0, "MAX", 0], "blower" = [0, 0, 0], "drill" = [0, "MAX", 0], "hammer" = [0, "MAX", 0], "rubber" = [10, 5, 10], "scissors" = [0, "MAX", 0], "screw" = [0, "MAX", 0], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"mechanical" = {
		"id" = 11,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, "MAX", 0], "stone" = [0, "MAX", 0], "water" = [0, "MAX", 0], "steel" = [0, "MAX", 0], "blower" = [0, 0, 0], "drill" = [0, "MAX", 0], "hammer" = [0, "MAX", 0], "rubber" = [0, "MAX", 0], "scissors" = [0, "MAX", 0], "screw" = [10, 5, 10], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"plastic" = {
		"id" = 12,
		"wettable" = false,
		"point_status" = {
			"shovel" = [0, 10, 0], "stone" = [5, 2, 1], "water" = [0, "MAX", 0], "steel" = [10, 1, 1], "blower" = [0, 0, 0], "drill" = [30, 5, 5], "hammer" = [1, 1, 1], "rubber" = [0, 1, 0], "scissors" = [10, 3, 15], "screw" = [0, 5, 1], "silk" = [100, "MAX", 100], "super" = [100, 1, 100]
		}
	},
	"lava" = {
		"id" = 16,
		"wettable" = true,
		"change_to" = "stone",
		"point_status" = {
			"shovel" = [0,"MAX",0], "stone" = [0,"MAX",0], "water" = [100,"MAX",100], "steel" = [0,"MAX",0], "blower" = [0,"MAX",0], "drill" = [0,"MAX",0], "hammer" = [0,"MAX",0], "rubber" = [0,"MAX",0], "scissors" = [0,"MAX",0], "screw" = [0,"MAX",0], "silk" = [0,"MAX",0], "super" = [0,"MAX",0]
		}
	},
	"dark_matter" = {
		"id" = 17,
		"wettable" = false,
		"point_status" = {
			"shovel" = [1,"MAX",1], "stone" = [1,"MAX",1], "water" = [1,"MAX",1], "steel" = [1,"MAX",10], "blower" = [1,"MAX",10], "drill" = [1,"MAX",10], "hammer" = [1,"MAX",10], "rubber" = [1,"MAX",10], "scissors" = [1,"MAX",10], "screw" = [1,"MAX",10], "silk" = [1,"MAX",10], "super" = [1,"MAX",100]
		}
	},
}

var pickaxe_information = {
	"shovel" = {"id"= "shovel", "name" = "shovel", "image_name" = "shovel", "price" = 100, "life_at_start" = 100}, 
	"water" = {"id"= "water", "name" = "water bucket", "image_name" = "water", "price" = 100, "life_at_start" = 1},
	"steel" = {"id"= "steel", "name" = "steel pickaxe", "image_name" = "steel", "price" = 500, "life_at_start" = 500},
	"stone" = {"id"= "stone", "name" = "stone pickaxe", "image_name" = "stone", "price" = 300, "life_at_start" = 100},
	"blower" = {"id"= "blower", "name" = "air blower", "image_name" = "air-blower", "price" = 150, "life_at_start" = 50},
	"drill" = {"id"= "drill", "name" = "drill", "image_name" = "drill", "price" = 600, "life_at_start" = 300},
	"hammer" = {"id"= "hammer", "name" = "hammer", "image_name" = "hammer", "price" = 200, "life_at_start" = 10},
	"rubber" = {"id"= "rubber", "name" = "rubber", "image_name" = "rubber-pickaxe", "price" = 200, "life_at_start" = 60},
	"scissors" = {"id"= "scissors", "name" = "scissors", "image_name" = "scissors", "price" = 100, "life_at_start" = 10},
	"screw" = {"id"= "screw", "name" = "screw driver", "image_name" = "screw-driver", "price" = 100, "life_at_start" = 20},
	"silk" = {"id"= "silk", "name" = "silk pickaxe", "image_name" = "silk-pickaxe", "price" = 500, "life_at_start" = 10},
	"super" = {"id"= "super", "name" = "super pickaxe", "image_name" = "super-pickaxe", "price" = 1000000, "life_at_start" = 10},
}
