extends Control


func _process(delta):
	if Input.is_action_just_pressed("Start"):
		get_tree().change_scene_to_file("res://Menu/title_screen.tscn")
