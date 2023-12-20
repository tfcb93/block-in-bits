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
