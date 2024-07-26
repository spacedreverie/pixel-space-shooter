extends Control

@onready var score = $score_display:
	set(value):
		score.text = "Score: " + str(value)
