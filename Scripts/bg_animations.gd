extends Node2D;

func _play_animation() -> void:
	var pattern_index := randi_range(1, len(%patterns.get_children())); 
	for pattern in %patterns.get_children():
		if (not pattern.name.contains(str(pattern_index))):
			pattern.visible = false;
		else:
			pattern.visible = true;
			pattern.self_modulate = Color(randf(), randf(), randf(), 0.3);
	%player.play("pattern_" + str(pattern_index) +"_anim");
	%player.speed_scale = 0.3;
