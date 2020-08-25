extends Control
onready var buttonsound = $AudioStreamPlayer


func _on_Button_pressed():
	buttonsound.play()
	get_tree().change_scene("res://Main.tscn")
