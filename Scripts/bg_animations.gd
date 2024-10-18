extends Node2D;

var actualPatern: Sprite2D;

func create_animation_background() -> void:
	var pattern_index := randi_range(1, len(%patterns.get_children())); 
	for pattern in %patterns.get_children():
		if (not pattern.name.contains(str(pattern_index))):
			pattern.visible = false;
		else:
			actualPatern = pattern;
			pattern.visible = true;
			pattern.self_modulate = Color(randf(), randf(), randf(), 0.3);
	%player.play("pattern_" + str(pattern_index) +"_anim");
	%player.speed_scale = 0.3;

	if (not Globals.is_background_on):
		stop_background();


func stop_background() -> void:
	%pattern_0.visible = true;
	actualPatern.visible = false;
	%player.pause();

func play_background() -> void:
	%pattern_0.visible = false;
	actualPatern.visible = true;
	%player.play();

