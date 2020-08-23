extends Control

onready var score_grid = $CenterContainer/HBoxContainer/VBoxContainer2/ScrollContainer/CenterContainer/GridContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request("http://www.jp00p.com/curse/get_high_score.php")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	for entry in json.result:
		var name_label = Label.new()
		name_label.text = entry.name
		var score_label = Label.new()
		score_label.text = entry.score
		score_grid.add_child(name_label)
		score_grid.add_child(score_label)
		


func _on_Restart_pressed():
	get_tree().change_scene("res://Title.tscn")
