extends Control

func _on_startbtn_pressed():
	get_tree().change_scene_to_file("res://scene/game.tscn")
func _on_quitbtn_pressed():
	get_tree().quit()
