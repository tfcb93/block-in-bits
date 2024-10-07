extends Node;

signal tap;

signal finish;

signal next_level(value: int);

signal change_pickaxe_type(dir: String);

signal pickaxe_type_changed(type: String);

signal open_shopping;

signal close_shopping;

signal add_bits;

signal discount_bits(value: int);

signal bits_discounted;

signal bought_pickaxe(type_id: String);


# =====

signal close_start_screen();
signal open_select_mode();
signal close_select_mode();
signal pause_game();
signal unpause_game();

signal start_game();
signal stop_game();

signal generate_pile();
signal hit_block(tool_resistance: int);
signal earn_points(earned_points: int);