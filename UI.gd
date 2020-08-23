extends CanvasLayer

signal cauldron_mixed
signal ritual_active
signal customer_timer_ended

onready var cauldron = $UIContainer/MarginContainer/VBoxContainer/CauldronSlots
onready var mix_button = $UIContainer/MarginContainer/VBoxContainer/CauldronMix
onready var text_box = $UIContainer/MarginContainer/VBoxContainer/TextContainer/MarginContainer/TextBox
onready var mix_progress = $UIContainer/MarginContainer/VBoxContainer/CauldronProgress
onready var text_animator = $UIContainer/MarginContainer/VBoxContainer/TextContainer/TextAnimator
onready var round_timer = Globals.round_time

func _ready():
	mix_button.set_disabled(true)
	$UIContainer/MarginContainer/VBoxContainer/TimeContainer/TimeRemaining.text = str(round_timer)

func _process(delta):
	$UIContainer/MarginContainer/VBoxContainer/TimeContainer/TimeRemaining.text = str(round_timer)
	if mix_button.disabled == false:
		mix_progress.value -= 0.3 * delta

func _on_CauldronMix_pressed():
	if Globals.cauldron_contents.size() == 3:
		mix_progress.value += 5
		emit_signal("ritual_active")

func set_text(val):
	text_animator.play("hide_text")
	yield(text_animator, "animation_finished")
	text_box.text = val
	text_animator.play("show_text")

func add_to_cauldron_slot(sprite, index):
	#add a sprite to the cauldron slots
	#once there's 3, enable the mix button
	var slot = cauldron.get_child(index)
	var NewSprite = Sprite.new()
	var itemSprite = load(sprite)
	NewSprite.texture = itemSprite
	NewSprite.centered = false
	slot.add_child(NewSprite)
	var puff = load("res://Particles/SparklePuff.tscn").instance()
	puff.set_emitting(true)
	slot.add_child(puff)
	if Globals.cauldron_contents.size() == 3:
		mix_button.set_disabled(false)
		$UIContainer/MarginContainer/VBoxContainer/CauldronMix/SparklePuff.set_emitting(true)

func reset_cauldron_ui():
	#clear cauldron slots and disable button
	mix_button.set_disabled(true)
	$UIContainer/MarginContainer/VBoxContainer/CauldronMix/SparklePuff.set_emitting(false)
	mix_progress.value = 0
	for n in cauldron.get_children():
		print(n.get_child_count())
		if n.get_child_count() > 0:
			for nn in n.get_children():
				n.remove_child(nn)
				nn.queue_free()

func _on_CauldronProgress_value_changed(value):
	#fully mixed cauldron!
	if value >= 100:
		mix_button.set_disabled(true)
		$UIContainer/MarginContainer/VBoxContainer/CauldronMix/SparklePuff.set_emitting(false)
		$Timer.stop()
		emit_signal("cauldron_mixed", round_timer)

func start_timer():
	round_timer = Globals.round_time
	$Timer.start()

func timer_tick():
	round_timer -= 1
	if round_timer <= 0:
		emit_signal("customer_timer_ended")
		$Timer.stop()
	pass # Replace with function body.
