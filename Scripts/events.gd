extends Node;

signal enter_game();
signal close_start_screen();
signal open_select_mode();
signal close_select_mode();
signal pause_game();
signal unpause_game();
signal exit_level();
signal open_credits();
signal close_credits();

signal open_instructions_from_selection();
signal close_instructions_to_selection();
signal open_instructions_from_pause();
signal close_instructions_to_pause();

signal open_settings_from_selection();
signal close_settings_to_selection();
signal open_settings_from_pause();
signal close_settings_to_pause();
signal toggle_background(is_on: bool);

signal start_game();
signal stop_game();

signal generate_pile();
signal hit_block(tool_resistance: int);
signal earn_points(earned_points: int);
signal depth_change(new_depth: int);
signal change_tool(index_direction: int);
signal add_time(time: int);

signal open_shop();
signal close_shop();
signal inform_shop_data(player_points: int, depth: int);
signal discount_points(discounted_points: int);
signal upgrade_tools(upgrde: Upgrade);

signal game_over();