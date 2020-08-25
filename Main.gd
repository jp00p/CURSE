extends Node2D

onready var shelf = $Shelf
onready var ingredient_holder = $Ingredients
onready var customer_path = $CustomerPath/PathFollow2D
onready var bgmusic = $BGAudio
onready var selectaudio = $ItemSelectAudio
var current_customer = {}
var mixed = false

func _ready():
	randomize()
	get_new_customer()

func start_round():
	pass
	
func clear_shelves():
	for n in ingredient_holder.get_children():
		n.queue_free()
	

func get_new_customer():
	mixed = false
	$UIAnimations.play("hide_cauldron")
	clear_shelves()
	clear_cauldron()
	for i in customer_path.get_children():
		i.queue_free()
	customer_path.offset = 0
	current_customer = {}
	current_customer.request = Globals.requests[randi()%Globals.requests.size()]
	current_customer.image = Globals.customer_images[randi()%Globals.customer_images.size()]
	current_customer.color = Globals.customer_colors[randi()%Globals.customer_colors.size()]
	var customer = load("res://Customer.tscn").instance()
	customer.set_image(current_customer.image)
	customer.set_light_color(current_customer.color)
	customer_path.add_child(customer)
	$CustomerAnimations.play("customer_walk")
	yield($CustomerAnimations, "animation_finished")
	$UIAnimations.play("show_cauldron")
	$UI.start_timer()
	$UI.set_text(current_customer.request.request_text)
	prepare_items(current_customer.request.required)
	
	
func prepare_items(required_items):
	#get items ready for the round
	#this ensures that required items
	#are available in the shop
	#var required_items = ["stinky", "lucky", "opposite"]
	var items_to_display = []
	var shelf_count = shelf.get_child_count()
	print("REQUIRED ITEMS:" + str(required_items))
	#add required items to the shop
	for r in range(required_items.size()):
		print(required_items[r])
		items_to_display.append(find_an_item(required_items[r]))
	print("SELECTED ITEMS:" + str(items_to_display))

	#fill in the rest of the list with random items
	for _i in range(shelf_count-items_to_display.size()):
		items_to_display.append(Globals.ingredients[randi()%Globals.ingredients.size()])

	#randomize the list once more for good measure
	items_to_display.shuffle() 
	
	#go over the list of items 
	#create Ingredient scenes from them
	#and add them to the shelves
	for ii in range(items_to_display.size()):
		var item = items_to_display[ii]
		var slot = shelf.get_child(ii)
		var ing = load("res://Ingredients/Ingredient.tscn").instance()
		ing.ingredient_type = item.type
		ing.ingredient_name = item.name
		ing.ingredient_hint = item.hint
		ing.ingredient_sprite = "res://Ingredients/"+item.image
		#make sure the item is centered on the shelf
		ing.set_position(Vector2(slot.position.x-8, slot.position.y-8))
		ing.connect("ingredient_selected", self, "_ingredient_selected")
		ingredient_holder.add_child(ing)
		
		
func _ingredient_selected(type, sprite, hint, pos):
	#when a user selects an ingredient
	#add to the global cauldron array
	#and update the UI
	$Shopkeeper.move_to = pos
	Globals.add_to_cauldron([type, sprite, hint])
	$UI.add_to_cauldron_slot(sprite, Globals.cauldron_contents.size()-1)
	selectaudio.play()
	
func clear_cauldron():
	Globals.empty_cauldron()
	$UI.reset_cauldron_ui()
	$Shopkeeper.stop_ritual()

func good_mix(time_left):
	var customer = customer_path.get_child(0)
	Globals.score += time_left * (Globals.current_day*1000)
	var response = Globals.customer_responses_good[randi()%Globals.customer_responses_good.size()]
	$UI.set_text(response)
	customer.show_happy_emote()

func bad_mix():
	var customer = customer_path.get_child(0)
	var response = Globals.customer_responses_bad[randi()%Globals.customer_responses_bad.size()]
	$UI.set_text(response)
	customer.show_sad_emote()

func too_slow():
	var customer = customer_path.get_child(0)
	var response = Globals.customer_responses_slow[randi()%Globals.customer_responses_slow.size()]
	$UI.set_text(response)
	customer.show_confused_emote()
	clear_cauldron()
	yield(get_tree().create_timer(4), "timeout")
	Globals.current_round += 1
	get_new_customer()

func find_an_item(item_type):
	#pull an item out of the global array
	#searches by item type
	Globals.ingredients.shuffle()
	for i in Globals.ingredients:
		if i.type == item_type:
			return i


func _on_RoundTimer_timeout():
	pass
	#get_new_customer()

func _on_UI_cauldron_mixed(time_left):
	#fully mixed cauldron
	mixed = true
	print(time_left)
	$Shopkeeper.stop_ritual()
	$Shopkeeper.move_to = $CashRegister.position
	var cauldron_test = []
	for c in Globals.cauldron_contents:
		cauldron_test.append(c[0])
	
	#test each item in the cauldron against what the customer wants
	if (cauldron_test[0] in current_customer.request.required and cauldron_test[1] in current_customer.request.required and cauldron_test[2] in current_customer.request.required):
		good_mix(time_left)
	else:
		bad_mix()

	yield(get_tree().create_timer(4), "timeout")
	Globals.current_round += 1
	get_new_customer()


func _on_UI_ritual_active():
	if !mixed:
		$Shopkeeper.start_ritual()
		mixed = true

func _on_UI_customer_timer_ended():
	too_slow()
