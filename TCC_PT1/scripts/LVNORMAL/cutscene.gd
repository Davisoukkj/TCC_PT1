extends Control

func _ready():
	$Timer.start()


func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://src/LVNORMAL/world.tscn")



func _on_timer_timeout():
	$AnimationPlayer.play("cutscene")
