extends Node;

signal close_start_screen();
signal open_select_mode();
signal close_select_mode();
signal pause_game();
signal unpause_game();
signal exit_level();

signal open_settings_from_selection();
signal close_settings_to_selection();
signal open_settings_from_pause();
signal close_settings_to_pause();

signal start_game();
signal stop_game();

signal generate_pile();
signal hit_block(tool_resistance: int);
signal earn_points(earned_points: int);
signal depth_change(new_depth: int);
signal change_tool(index_direction: int);