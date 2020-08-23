extends Node2D

func set_image(val):
	$Sprite.texture = load("res://Customers/"+val)
	rotation_degrees = 90

func set_light_color(val):
	$Light2D.color = val

func show_happy_emote():
	var emote = Globals.customer_happy_emotes[randi()%Globals.customer_happy_emotes.size()]
	$Emote.texture = load(emote)
	$Emote.set_visible(true)
	yield(get_tree().create_timer(4), "timeout")
	$Emote.set_visible(false)

func show_confused_emote():
	var emote = Globals.customer_confused_emote
	$Emote.texture = load(emote)
	$Emote.set_visible(true)
	yield(get_tree().create_timer(4), "timeout")
	$Emote.set_visible(false)

func show_sad_emote():
	var emote = Globals.customer_sad_emotes[randi()%Globals.customer_sad_emotes.size()]
	$Emote.texture = load(emote)
	$Emote.set_visible(true)
	yield(get_tree().create_timer(4), "timeout")
	$Emote.set_visible(false)
