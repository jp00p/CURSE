extends Node2D

var move_to = Vector2()
onready var ritualsound = $AudioStreamPlayer

func _ready():
	move_to = global_position

func _process(delta):
	global_position = lerp(global_position, move_to, 0.2)

func start_ritual():
	print("starting ritual")
	$CPUParticles2D.set_visible(true)
	$CPUParticles2D.set_emitting(true)
	$Light2D.set_energy(2)
	ritualsound.play()
	
	
func stop_ritual():
	print("ending ritual")
	$CPUParticles2D.set_emitting(false)
	$CPUParticles2D.set_visible(false)
	$Light2D.set_energy(1)
