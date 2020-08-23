extends Control

signal ingredient_selected

var ingredient_type = "stink"
var ingredient_name = "Queso"
var ingredient_hint = "A powerful stench that is quite\nstinky and you don't want to smell\nit"
var ingredient_sprite = "res://Ingredients/cheese.png"
var selected = false

func _ready():
	$Sprite.texture = load(ingredient_sprite)
	hint_tooltip = ingredient_name + "\n" + ingredient_hint

func remove_self():
	print("Removing item")
	queue_free()

func test():
	print("TESTING")

func _on_Ingredient_gui_input(event):
	if Globals.cauldron_contents.size() >= 3:
		return
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed and !selected:
				selected = true
				$Sprite.set_visible(false)
				$LightOccluder2D.set_visible(false)
				var puff = load("res://Particles/SparklePuff.tscn").instance()
				puff.set_emitting(true)
				add_child(puff)
				yield(get_tree().create_timer(0.3), "timeout")
				emit_signal("ingredient_selected", ingredient_type, ingredient_sprite, ingredient_hint, $Sprite.global_position)
				queue_free()
