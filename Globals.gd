extends Node

var score = 0
var round_times = [30, 25, 20, 15, 10]
var round_time = round_times[0]
var current_round = 1 setget set_round
var current_day = 1
var rounds_per_day = 3
var total_days = 5

var cauldron_contents = []

var ingredients = [
	{
	  "name":"Hode",
	  "type": "head",
	  "hint": "A rune dedicated to the head and all things therein.",
	  "image": "rune_head.png"
	},
	{
	  "name":"Sjel",
	  "type": "heart",
	  "hint": "For matters of the heart. ",
	  "image": "rune_heart.png"
	},
	{
	  "name":"Gebo",
	  "type": "limb",
	  "hint": "A rune to focus on arms, legs, and limb. ",
	  "image": "rune_limbs.png"
	},
	{
	  "name": "Gloves",
	  "type": "limbs",
	  "hint": "Like socks for your hands",
	  "image": "gloves.png"
	},
	{
	  "name":"Huske",
	  "type": "human",
	  "hint": "The whole corporeal husk. ",
	  "image": "rune_human.png"
	},
	{
	  "name":"Mirror",
	  "type": "opposite",
	  "hint": "A common curse tool, gets the opposite effect of ingredients ",
	  "image": "mirror.png"
	},
	{
	  "name":"Gold Coins",
	  "type": "lucky",
	  "hint": "Lucky coins found in the street.",
	  "image": "coins.png"
	},
	{
	  "name":"Bat",
	  "type": "blindness",
	  "hint": "Blind as a bat, they say.",
	  "image": "bat.png"
	},
	{
	  "name":"Fish",
	  "type": "suffocation",
	  "hint": "Do not to choke and suffocate on these bones!",
	  "image": "fish.png"
	},
	{
	  "name":"Choke Blossom",
	  "type": "suffocation",
	  "hint": "This blossom induces suffocation.",
	  "image": "purple_flower.png"
	},
	{
	  "name":"Water",
	  "type": "water",
	  "hint": "*drip drip drip* ",
	  "image": "water.png"
	},
	{
	  "name":"Squid Ink",
	  "type": "blindness",
	  "hint": "So dark you can't even see through it. ",
	  "image": "inkbottle.png"
	},
	{
	  "name":"Chicken",
	  "type": "clumsy",
	  "hint": "A notoriously clumsy chicken.",
	  "image": "chicken.png"
	},
	{
	  "name":"Mushroom",
	  "type": "foolish",
	  "hint": "A fun (but foolish) guy.",
	  "image": "mushroom.png"
	},
	{
	  "name":"Queso",
	  "type": "smelly",
	  "hint": "Smells really funky.",
	  "image": "cheese.png"
	},
	{
	  "name":"Bees",
	  "type": "bees",
	  "hint": "How did a bee get in there?",
	  "image": "bees.png"
	},
	{
	  "name":"Heart",
	  "type": "heart",
	  "hint": "Doki doki <3",
	  "image": "heart.png"
	},
	{
	  "name":"Rock",
	  "type": "stone",
	  "hint": "Solid as a rock!",
	  "image": "rock.png"
	},
	{
	  "name":"Egg",
	  "type": "life",
	  "hint": "The beginning of a new life.",
	  "image": "egg.png"
	},
	{
	  "name":"Apple",
	  "type": "food",
	  "hint": "Om nom nom.",
	  "image": "apple.png"
	},
	{
	  "name":"Tree",
	  "type": "life",
	  "hint": "Trees provide life sustaining oxygen.",
	  "image": "tree.png"
	},
	{
	  "name":"Lucky Carrot",
	  "type": "lucky",
	  "hint": "That's Mochi's lucky carrot! ",
	  "image": "carrot.png"
	},
	{
	  "name":"Mouse",
	  "type": "clumsy",
	  "hint": "A small and clumsy creature. ",
	  "image": "mouse.png"
	},
	{
	  "name":"Ugly Stick",
	  "type": "ugly",
	  "hint": "Try to avoid getting hit by it like jp00p did",
	  "image": "stick.png"
	},
	{
	  "name": "Stump",
	  "type": "foolish",
	  "hint": "It's said someone is dumb as a stump.",
	  "image": "stump.png"
	},
	{
	  "name":"Anvil",
	  "type": "strength",
	  "hint": "Do u even lift bro?",
	  "image": "anvil.png"
	},
	{
	  "name":"Flower of Life",
	  "type": "life",
	  "hint": "This flower is thought to revive the dead.",
	  "image": "white_flower.png"
	},
	{
	  "name":"Pear",
	  "type": "food",
	  "hint": "Yum.",
	  "image": "pear.png"
	},
	{
	  "name":"Hammer",
	  "type": "hammer",
	  "hint": "Just a hammer. Can't touch this",
	  "image": "hammer.png"
	},
	{
	  "name":"Necklace",
	  "type": "necklace",
	  "hint": "Something your mum might wear.",
	  "image": "necklace.png"
	},
	{
	  "name":"Hat",
	  "type": "head",
	  "hint": "A hat for your head.",
	  "image": "hat.png"
	},
	{
	  "name":"Sack",
	  "type": "bag",
	  "hint": "A sack to put things in.",
	  "image": "sack.png"
	},
	{
	  "name":"Belt",
	  "type": "belt",
	  "hint": "Used to hold up pants.",
	  "image": "belt.png"
	},
	{
	  "name":"Helmet",
	  "type": "head",
	  "hint": "It protects the skull.",
	  "image": "helmet.png"
	},
	{
	  "name":"Cactus",
	  "type": "pain",
	  "hint": "Ouch!",
	  "image": "cactus.png"
	},
	{
	  "name":"Roast Chicken",
	  "type": "food",
	  "hint": "I'd eat it. ",
	  "image": "roast_chicken.png"
	}
]


var requests = [
	{
	  "name":"Curse of Terrible Luck",
	  "request_text": "Craft me a curse of terrible luck.",
	  "required": ["lucky", "opposite", "human"]
	},
	{
	  "name":"Curse of Suspiciously Good Luck",
	  "request_text": "I need to make someone very, very lucky. Too lucky.",
	  "required": ["lucky", "lucky", "human"]
	},
	{
	  "name":"Curse of Instant Death",
	  "request_text": "...A humans's life must end.",
	  "required": ["life", "opposite", "human"]
	},
	{
	  "name":"Curse of Utter Darkness",
	  "request_text": "Make me something to cause complete blindness. It must be total darkness!",
	  "required": ["blindness", "blindness", "head"]
	},
	{
	  "name":"Curse of the Dumbdumb",
	  "request_text": "I need to make my nemisis dumb as a rock.",
	  "required": ["foolish", "stone", "head"]
	},
	{
	  "name":"Curse of Posiden",
	  "request_text": "Craft me a curse to drown my foes.",
	  "required": ["water", "suffocation", "human"]
	},
	{
	  "name":"Spontaneous Combustion",
	  "request_text": "Make my foe go up in flames.",
	  "required": ["water", "opposite", "human"]
	},
	{
	  "name":"Curse of Always Hitting Your Thumb with a Hammer",
	  "request_text": "I need to make my carpenter suffer.",
	  "required": ["clumsy", "hammer", "limb"]
	},
	{
	  "name":"Lungs Full of Bees",
	  "request_text": "I must know what happens if a human was full of bees!",
	  "required": ["bees", "suffocation", "human"]
	},
	{
	  "name":"Curse of Infatuation",
	  "request_text": "...I must make someone suffer a triple heartbreak.",
	  "required": ["heart", "heart", "heart"]
	},
	{
	  "name":"Curse of Loathing",
	  "request_text": "Make me a curse to fill a human full of hate.",
	  "required": ["heart", "opposite", "human"]
	},
	{
	  "name":"Curse of Ugly Mugly",
	  "request_text": "I need a curse to make a human ugly and smelly.",
	  "required": ["ugly", "smelly", "human"]
	},
	{
	  "name":"Medusa's Curse",
	  "request_text": "I must turn my human enemy to stone until they choke.",
	  "required": ["stone", "suffocation", "human"]
	},
	{
	  "name":"Curse of Happy Noodle Boy",
	  "request_text": "Craft me a curse to make a human weak.",
	  "required": ["strength", "opposite", "human"]
	},
	{
	  "name":"Curse of Stinky Feet",
	  "request_text": "I require a curse that make your feet extra smelly.",
	  "required": ["smelly", "smelly", "limb"]
	},
	{
	  "name":"Curse of Unbearable Beauty",
	  "request_text": "Make my face so beautiful no one dares to speak to me!",
	  "required": ["ugly", "opposite", "head"]
	},
	{
	  "name":"Curse of Unending Hunger",
	  "request_text": "Craft me something to induce starvation in a human.",
	  "required": ["food", "opposite", "human"]
	},
	{
	  "name":"Curse of Face Stinging Bees",
	  "request_text": "Cover my nemisis' face in many bee stings, please!",
	  "required": ["bees", "bees", "head"]
	},
	{
	  "name":"Curse of Perpetual Choking",
	  "request_text": "Give me a curse that will cause a human to choke on their meal.",
	  "required": ["suffocation", "food", "human"]
	},
	{
	  "name":"Cursed Hat",
	  "request_text": "Make me a hat that makes the wearer double-ugly.",
	  "required": ["ugly", "ugly", "head"]
	},
	{
	  "name":"Gloves of Clumsiness",
	  "request_text": "Make me some gloves that make the wearer clumsy in both hands.",
	  "required": ["clumsy", "limb", "limb"]
	},
	{
	  "name":"Hat of Halatosis",
	  "request_text": "Make me a hat to give the wearer smelly, smelly, breath.",
	  "required": ["smelly", "smelly", "head"]
	},
	{
	  "name":"Helmet of Weakness",
	  "request_text": "Make me a helmet that causes weakness.",
	  "required": ["head", "strength", "opposite"]
	},
	{
	  "name":"Gloves of Inedible Food",
	  "request_text": "Craft me some gloves that make the wearer's food turn to stone.",
	  "required": ["limb", "food", "stone"]
	},
	{
	  "name":"Bag of Mighty Bees",
	  "request_text": "Craft me a bag full of mighty bees!",
	  "required": ["strength", "bees", "bag"]
	},
	{
	  "name":"Belt from the Bog of Stench",
	  "request_text": "I need a belt that will make a human very, very smelly.",
	  "required": ["smelly", "smelly", "human"]
	},
	{
	  "name":"Curse of Torment",
	  "request_text": "I need to torment someone. Give me a stinky and painful curse for humans.",
	  "required": ["smelly", "pain", "human"]
	},
	{
	  "name":"Cursed Hammer Toes",
	  "request_text": "I require a hammer which gives the user stinky legs.",
	  "required": ["smelly", "hammer", "limb"]
	}	
]

var customer_images = ["customer1.png", "customer_0.png", "customer_1.png", "customer_2.png", "customer_3.png", "customer_4.png", "customer_5.png", "customer_6.png", "customer_7.png"]
var customer_colors = [Color("#c7432a"), Color("#ffa114"), Color("#fff769"), Color("#4a6b1c"), Color("#d2ff40")]

var customer_responses_good = [
	"This is exactly what I wanted.",
	"Excellent.",
	"Sick work dude.",
	"This will work.",
	"Thank you, here is the money payment.",
	"Beautifully done.",
	"Thank you.",
	"Wicked good.",
	"*hastily grabs the curse and scurries away*",
	"Thanks buddy.",
	"*bows and vanishes*",
	"Thank you in all cruelness."
]

var customer_responses_bad = [
	"I'm not paying for that.",
	"You ninny! That's not what I wanted.",
	"What were you thinking?",
	"Ugh, I'll come back later.",
	"It's all wrong.",
	"It's raw! YOU DONKEY",
	"I shan't pay for subpar curses.",
	"*farts and leaves*",
	"*hisses and runs away*",
	"Aw man, that's not it.",
	"*scowls and vanishes*",
	"Ugh, are you new?",
	"Wow this is terrible! And not in a good way!"
]

var customer_responses_slow = [
	"Slowest curse creator ever!",
	"Um, can I talk to your manager?",
	"Wow. Learn to make curses."
]

var customer_happy_emotes = [
	"res://Customers/emote_faceHappy.png",
	"res://Customers/emote_heart.png"
]

var customer_sad_emotes = [
	"res://Customers/emote_cross.png",
	"res://Customers/emote_faceAngry.png",
	"res://Customers/emote_faceSad.png"
]

var customer_confused_emote = "res://Customers/emote_question.png"

func _ready():
	randomize()
	ingredients.shuffle()
	requests.shuffle()
	customer_images.shuffle()
	var cursor_image = load("res://UI/cursor.png")
	Input.set_custom_mouse_cursor(cursor_image,
		Input.CURSOR_ARROW,
		Vector2(0, 0))

func add_to_cauldron(ing):
	cauldron_contents.append(ing)

func empty_cauldron():
	cauldron_contents = []

func set_round(val):
	current_round = val
	if val > rounds_per_day:
		current_day += 1
		current_round = 1
		
	if current_day >= 6:
		end_game()
	else:
		round_time = round_times[current_day-1]

func end_game():
	get_tree().change_scene("res://SubmitHighScore.tscn")

func _input(event):
	if event.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
