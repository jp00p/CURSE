extends Node2D

func _on_AnimationPlayer_animation_finished(anim_name):
	yield(get_tree().create_timer(1.5), "timeout")
	get_tree().change_scene("res://Title.tscn")
