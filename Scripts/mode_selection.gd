extends Node2D;

func _ready() -> void:
	Events.connect("open_select_mode", _on_open_select_mode);
	Events.connect("close_settings_to_selection", _on_close_settings);
	Events.connect("close_instructions_to_selection", _on_close_instructions);
	Events.connect("close_credits", _on_close_credits);
	
	%interface.visible = false;

	# while I don't have other settings besides fullscree
	if (Globals.is_mobile):
		%btn_settings.visible = false;
		# in case someone is using a controller on the phone or tablet
		%btn_instructions.focus_neighbor_left = null;

func _on_open_select_mode() -> void:
	%interface.visible = true;
	%btn_endless.grab_focus();

	if (Globals.is_mobile or Globals.is_web):
		%btn_quit.visible = false;
		%btn_credits.focus_neighbor_right = null;

func _on_close_select_mode() -> void:
	%interface.visible = false;
	Events.emit_signal("close_select_mode");

func _on_close_settings() -> void:
	%interface.visible = true;
	%btn_settings.grab_focus();

func _on_close_instructions() -> void:
	%interface.visible = true;
	%btn_instructions.grab_focus();

func _on_close_credits() -> void:
	%interface.visible = true;
	%btn_credits.grab_focus();

func _on_btn_endless_pressed() -> void:
	_on_close_select_mode();
	Events.emit_signal("start_game");

func _on_btn_settings_pressed() -> void:
	%interface.visible = false;
	Events.emit_signal("open_settings_from_selection");


func _on_btn_instructions_pressed() -> void:
	%interface.visible = false;
	Events.emit_signal("open_instructions_from_selection");


func _on_btn_credits_pressed() -> void:
	%interface.visible = false;
	Events.emit_signal("open_credits");


func _on_btn_quit_pressed() -> void:
	get_tree().quit();
