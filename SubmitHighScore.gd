extends Control
var name_edited = false
var forbidden_chars = ['!', '*', "'", "(", ")", ";", ":", "@", "&", "=", "+", "$", ",", "/", "?", "%", "#", "[", "]", " "]
onready var text_input = $CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/HBoxContainer/LineEdit

func _ready():
	var gross_amt = 39.5 * 6.66
	var monstercare_amt = gross_amt - (gross_amt*0.042)
	var net_amt = stepify(monstercare_amt - (gross_amt*0.325), 0.01)
	
	yield(get_tree().create_timer(0.5), "timeout")
	$CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Paystub/HoursAmt.text = "39.5"
	yield(get_tree().create_timer(0.5), "timeout")
	$CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Paystub/RateAmt.text = "$6.66/hour"
	yield(get_tree().create_timer(0.5), "timeout")
	$CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Paystub/GrossAmt.text = "$" + str(gross_amt)
	yield(get_tree().create_timer(0.5), "timeout")
	$CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Paystub/TaxAmt.text = "32.5%"
	yield(get_tree().create_timer(0.5), "timeout")
	$CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Paystub/MonstercareAmt.text = "4.2%"
	yield(get_tree().create_timer(0.5), "timeout")
	$CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Paystub/NetWagesAmt.text = "$" + str(net_amt)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	print(response_code)

func _on_Button_pressed():
	$CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/HBoxContainer/Button.set_disabled(true)
	var name = text_input.text
	name = name.substr(0,10)
	for c in forbidden_chars:
		name = name.replace(c, "")
	
	if !name_edited or name == "":
		#if they didn't touch the name field, dont submit it
		final_screen()
	else:
		#send high score to my server!
		$HTTPRequest.request("https://jp00p.com/curse/set_high_score.php?password=supersecretpassword&name="+name+"&score="+str(Globals.score))
		yield($HTTPRequest, "request_completed")
		final_screen()

func _on_LineEdit_focus_entered():
	if text_input.text == "Name":
		text_input.text = ""

func final_screen():
	get_tree().change_scene("res://HighScores.tscn")

func _on_LineEdit_text_changed(new_text):
	name_edited = true
