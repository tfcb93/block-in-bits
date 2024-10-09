extends Node;

# game states
enum GAME_STATES {START_SCREEN, SELECTION, IN_GAME, PAUSED, EXIT};
var game_state := GAME_STATES.START_SCREEN;

# blocks
var blocks := {};

# settings
var is_game_fullscreen := false;
var game_resolution_index := 0;