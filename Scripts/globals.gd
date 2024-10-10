extends Node;

const endless_initial_milestone := 100;
const endelss_milestone_multiply_factor := 2;
# Looks like I can't index the enum to stings
const available_tools_names := {AVAILABLE_TOOLS.PICKAXE: "Pickaxe", AVAILABLE_TOOLS.HAMMER: "Hammer", AVAILABLE_TOOLS.DRILL: "Drill"};

# game states
enum GAME_STATES {START_SCREEN, SELECTION, IN_GAME, IN_SHOP, PAUSED, EXIT};
var game_state := GAME_STATES.START_SCREEN;

# tools
enum AVAILABLE_TOOLS {PICKAXE = 0, HAMMER, DRILL};
var upgrades = [];
# blocks
var blocks := {};

# settings
var is_game_fullscreen := false;
var game_resolution_index := 0;