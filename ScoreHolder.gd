extends CanvasLayer

onready var round_value = $MarginContainer/StatsContainer/RoundContainer/RoundValue
onready var day_value = $MarginContainer/StatsContainer/DayContainer/DayValue
onready var score_value = $MarginContainer/StatsContainer/ScoreContainer/ScoreValue

func _ready():
	round_value.text = str(Globals.current_round)+"/"+str(Globals.rounds_per_day)
	day_value.text = str(Globals.current_day)+"/"+str(Globals.total_days)
	score_value.text = "$"+str(Globals.score)
	
func _process(delta):
	round_value.text = str(Globals.current_round)+"/"+str(Globals.rounds_per_day)
	day_value.text = str(Globals.current_day)+"/"+str(Globals.total_days)
	score_value.text = "$"+str(Globals.score)
