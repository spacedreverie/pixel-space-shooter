extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_score(value):
	$game_end/FinalScore.text = "Score: " + str(value)

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()
